import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmereffect.dart';
import '../../utils/colors.dart';

/// One slide: a background image + two stacked text lines.
class HeroSlide {
  final String image;
  final String line1; // white
  final String line2; // orange
  final String? label; // optional small orange tag above the text
  final VoidCallback? onTap; // optional click on the slide

  const HeroSlide({
    required this.image,
    required this.line1,
    required this.line2,
    this.label,
    this.onTap,
  });
}

/// Reusable hero slider.
///
/// HeroSlider(
///   isActive: widget.isActive,   // pauses auto-play when the page is hidden
///   slides: [HeroSlide(...), HeroSlide(...), HeroSlide(...)],
/// )
class HeroSlider extends StatefulWidget {
  final bool isActive;
  final List<HeroSlide> slides;
  final double? height; // optional fixed override
  final double heightFactor; // fraction of screen height
  final Duration autoPlayInterval;

  const HeroSlider({
    super.key,
    required this.isActive,
    required this.slides,
    this.height, // null -> use screen height
    this.heightFactor = 0.71, //header height
    this.autoPlayInterval = const Duration(seconds: 5), //duration interval
  });

  @override
  State<HeroSlider> createState() => _HeroSliderState();
}

class _HeroSliderState extends State<HeroSlider> {
  late final PageController _controller;
  Timer? _timer;
  bool _loading = true;
  int _virtualPage = 0; // keeps counting up/down forever

  // the real slide number (0..count-1)
  int get _index =>
      widget.slides.isEmpty ? 0 : _virtualPage % widget.slides.length;
  bool _isPrevHovered = false;
  bool _isNextHovered = false;
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();

    // start in the middle so you can go left from the first slide too
    final n = widget.slides.length;
    _virtualPage = n > 0 ? n * 1000 : 0;
    _controller = PageController(initialPage: _virtualPage);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadImages();
    });
  }

  @override
  void didUpdateWidget(covariant HeroSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isActive != widget.isActive) {
      _restartTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _preloadImages() async {
    try {
      await Future.wait(
        widget.slides.map((s) => precacheImage(AssetImage(s.image), context)),
      );
    } catch (e) {
      debugPrint('Error preloading hero slider images: $e');
    }

    if (!mounted) return;
    setState(() {
      _loading = false;
    }); //1
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && widget.isActive) _focusNode.requestFocus();
    });
    _restartTimer();
  }

  void _restartTimer() {
    _timer?.cancel();
    if (!widget.isActive || _loading || widget.slides.length < 2) return;

    _timer = Timer.periodic(widget.autoPlayInterval, (_) {
      _goTo(_virtualPage + 1);
    });
  }

  void _goTo(int target) {
    if (!_controller.hasClients) return;
    _controller.animateToPage(
      target,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  void _onManualMove(int target) {
    _goTo(target);
    _restartTimer(); // reset the countdown after the user interacts
  }

  double _resolveHeight(BuildContext context) {
    return widget.height ??
        MediaQuery.of(context).size.height * widget.heightFactor;
  }

  @override
  Widget build(BuildContext context) {
    final double h = _resolveHeight(context);

    if (_loading) {
      return SizedBox(
        width: double.infinity,
        height: h,
        child: const HeroSliderShimmer(),
      );
    }

    final int count = widget.slides.length;

    return Focus(
      focusNode: _focusNode,
      onKeyEvent: (node, event) {
        if (!widget.isActive || count < 2) return KeyEventResult.ignored;

        // Swallow up/down so the arrow keys don't scroll the page
        if (event.logicalKey == LogicalKeyboardKey.arrowDown ||
            event.logicalKey == LogicalKeyboardKey.arrowUp) {
          return KeyEventResult.handled;
        }

        if (event is! KeyDownEvent) return KeyEventResult.ignored;

        if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
          _onManualMove(_virtualPage - 1);
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
          _onManualMove(_virtualPage + 1);
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: MouseRegion(
        onEnter: (_) => _focusNode.requestFocus(),
        // onHover: (_) {
        //   // keep reclaiming focus while the cursor moves over the slider
        //   if (!_focusNode.hasFocus) _focusNode.requestFocus();
        // },//2
        child: SizedBox(
          width: double.infinity,
          height: h,
          child: Stack(
            children: [
              //  SLIDES
              PageView.builder(
                controller: _controller,
                // no itemCount -> infinite
                onPageChanged: (i) => setState(() => _virtualPage = i),
                itemBuilder: (context, i) {
                  final int real = i % count;
                  return _buildSlide(widget.slides[real], real);
                },
              ),

              // ---------- ARROWS ----------
              if (count > 1) ...[
                Positioned(
                  left: 20,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _arrow(
                      CupertinoIcons.chevron_left,
                      _isPrevHovered,
                      (v) => setState(() => _isPrevHovered = v),
                      () => _onManualMove(_virtualPage - 1),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _arrow(
                      CupertinoIcons.chevron_right,
                      _isNextHovered,
                      (v) => setState(() => _isNextHovered = v),
                      () => _onManualMove(_virtualPage + 1),
                    ),
                  ),
                ),
              ],

              // ---------- DOTS ----------
              if (count > 1)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(count, (i) {
                      final bool isActive = (i == _index);
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap:
                              () => _onManualMove(_virtualPage + (i - _index)),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: isActive ? 13 : 10,
                            height: isActive ? 13 : 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color:
                                    isActive
                                        ? tOrange1
                                        : tWhite.withOpacity(0.5),
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: isActive ? 6 : 0,
                                height: isActive ? 6 : 0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: tOrange1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlide(HeroSlide slide, int i) {
    final bool current = i == _index;

    final Widget content = Stack(
      fit: StackFit.expand,
      children: [
        // background image
        Image.asset(
          slide.image,
          // fit: BoxFit.fill,
          fit: BoxFit.cover,
          errorBuilder:
              (context, error, stackTrace) => Container(
                color: tBlue3,
                alignment: Alignment.center,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  size: 50,
                  color: tWhite.withOpacity(0.6),
                ),
              ),
        ),

        // dark overlay so the text is always readable
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                tBlue2.withOpacity(0.85),
                tBlue2.withOpacity(0.55),
                tTransparent,
              ],
              stops: const [0.0, 0.45, 1.0],
            ),
          ),
        ),

        // two-line text stacked above the image
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80), //text position
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
              offset: current ? Offset.zero : const Offset(-0.06, 0),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 700),
                opacity: current ? 1 : 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (slide.label != null) ...[
                      Text(
                        slide.label!,
                        style: GoogleFonts.manrope(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: tOrange1,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    Text(
                      slide.line1,
                      style: GoogleFonts.manrope(
                        fontSize: 48,
                        fontWeight: FontWeight.w600,
                        height: 1.15,
                        color: tWhite,
                      ),
                    ),
                    Text(
                      slide.line2,
                      style: GoogleFonts.manrope(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        height: 1.15,
                        color: tOrange1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );

    if (slide.onTap == null) return content;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(onTap: slide.onTap, child: content),
    );
  }

  Widget _arrow(
    IconData icon,
    bool hovered,
    ValueChanged<bool> onHover,
    VoidCallback onTap,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: tWhite.withOpacity(0.15),
            border: Border.all(
              color: hovered ? tOrange1 : tWhite.withOpacity(0.6),
              width: 1.5,
            ),
          ),
          child: Icon(icon, color: hovered ? tOrange1 : tWhite, size: 26),
        ),
      ),
    );
  }
}
