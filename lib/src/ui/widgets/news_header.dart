import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmer_effect.dart';
import 'package:trakmate_portal/src/utils/responsive.dart';
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
/// Tablet / desktop: full-bleed image with the text on top (unchanged).
/// Mobile: same look as the Manufacturing hero - image banner on top
/// (fading into the blue gradient) with the text underneath.
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
      // debugPrint('Error preloading hero slider images: $e');
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

  // Medium phones (e.g. 360px wide)
  bool _isCompact(BuildContext context) =>
      MediaQuery.of(context).size.width < 380;

  // Mobile image banner height (same ratio as the Manufacturing hero)
  double _mobileImageHeight(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.62;

  // Mobile text area under the image (label + heading + room for the dots)
  double _mobileTextHeight(BuildContext context) =>
      _isCompact(context) ? 300 : 340;

  double _resolveHeight(BuildContext context) {
    if (widget.height != null) return widget.height!;

    if (ResponsiveLayout.isMobile(context)) {
      return _mobileImageHeight(context) + _mobileTextHeight(context);
    }

    return MediaQuery.of(context).size.height * widget.heightFactor;
  }

  @override
  Widget build(BuildContext context) {
    final double h = _resolveHeight(context);
    final bool isMobile = ResponsiveLayout.isMobile(context);

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
        child: SizedBox(
          width: double.infinity,
          height: h,
          child: Stack(
            children: [
              //  SLIDES (on a phone you can also swipe left / right)
              PageView.builder(
                controller: _controller,
                // no itemCount -> infinite
                onPageChanged: (i) {
                  setState(() => _virtualPage = i);
                  if (isMobile) _restartTimer(); // restart after a swipe
                },
                itemBuilder: (context, i) {
                  final int real = i % count;
                  return isMobile
                      ? _buildMobileSlide(widget.slides[real], real)
                      : _buildSlide(widget.slides[real], real);
                },
              ),

              // ---------- ARROWS (tablet / desktop only) ----------
              if (count > 1 && !isMobile) ...[
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
                  bottom: isMobile ? 16 : 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(count, (i) {
                      final bool isActive = (i == _index);
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
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

  // ---------------------------------------------------------------------------
  // MOBILE SLIDE - same structure as the Manufacturing mobile hero:
  // blue gradient, image banner on top fading into the blue, text below.
  // ---------------------------------------------------------------------------
  Widget _buildMobileSlide(HeroSlide slide, int i) {
    final bool current = i == _index;
    final bool compact = _isCompact(context);
    final double headingSize = compact ? 25 : 30; // same as Manufacturing hero

    // "\n" breaks are tuned for wide screens; on a phone let text wrap.
    final String line2 = slide.line2.replaceAll('\n', ' ');

    final Widget content = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tBlue2, tBlue3],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE: only the bottom edge fades into the blue
          SizedBox(
            width: double.infinity,
            height: _mobileImageHeight(context),
            child: ShaderMask(
              blendMode: BlendMode.dstIn,
              shaderCallback: (Rect rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [tBlack, tBlack, tTransparent],
                  stops: [0.0, 0.6, 1.0],
                ).createShader(rect);
              },
              child: Image.asset(
                slide.image,
                fit: BoxFit.cover,
                alignment: Alignment.centerRight,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      color: tBlue2,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 48,
                        color: tWhite.withOpacity(0.55),
                      ),
                    ),
              ),
            ),
          ),

          // TEXT (bottom padding leaves room for the dots)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              child: Align(
                alignment: Alignment.topLeft,
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
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: tOrange1,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 35,
                            height: 3,
                            decoration: BoxDecoration(
                              color: tOrange1,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                        Text(
                          slide.line1,
                          style: GoogleFonts.manrope(
                            fontSize: headingSize,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                            color: tWhite,
                          ),
                        ),
                        Text(
                          line2,
                          style: GoogleFonts.manrope(
                            fontSize: headingSize,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                            color: tOrange1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    if (slide.onTap == null) return content;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(onTap: slide.onTap, child: content),
    );
  }

  // ---------------------------------------------------------------------------
  // TABLET / DESKTOP SLIDE (unchanged)
  // ---------------------------------------------------------------------------
  Widget _buildSlide(HeroSlide slide, int i) {
    final bool current = i == _index;
    final bool isTablet = ResponsiveLayout.isTablet(context);
    final Widget content = Stack(
      fit: StackFit.expand,
      children: [
        // background image
        Image.asset(
          slide.image,
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
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 80 : 80,
          ), //text position
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
                          fontSize: isTablet ? 13 : 14,
                          fontWeight: FontWeight.w700,
                          color: tOrange1,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 35,
                        height: 3,
                        decoration: BoxDecoration(
                          color: tOrange1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    Text(
                      slide.line1,
                      style: GoogleFonts.manrope(
                        fontSize: isTablet ? 35 : 48,
                        fontWeight: FontWeight.w600,
                        height: 1.15,
                        color: tWhite,
                      ),
                    ),
                    Text(
                      slide.line2,
                      style: GoogleFonts.manrope(
                        fontSize: isTablet ? 35 : 48,
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
