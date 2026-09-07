import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/widgets/buildhome.dart';
import 'package:trakmate_portal/src/ui/widgets/scroller_button.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmereffect.dart';
import 'package:trakmate_portal/src/utils/colors.dart';
import '../widgets/footer_section.dart';
import 'package:video_player/video_player.dart';

import '../widgets/heroanimation.dart';

class HomeSection extends StatefulWidget {
  final ValueChanged<int>? onNavigate;
  final bool isActive;

  const HomeSection({super.key, this.onNavigate, required this.isActive});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

// Data for a single hero slide
class _HeroSlideData {
  final String video;
  final String label;
  final String headingLine1;
  final String headingLine2;
  final String description;
  final List<_StatData> stats;

  const _HeroSlideData({
    required this.video,
    required this.label,
    required this.headingLine1,
    required this.headingLine2,
    required this.description,
    required this.stats,
  });
}

class _StatData {
  final String icon;
  final String value;
  final String label;

  const _StatData({
    required this.icon,
    required this.value,
    required this.label,
  });
}

class _HomeSectionState extends State<HomeSection> {
  final List<_HeroSlideData> _slides = const [
    _HeroSlideData(
      video: "video/v1.mp4",
      label: "SMART FLEET",
      headingLine1: "Driving Innovation.",
      headingLine2: "Charging a Sustainable Tomorrow.",
      description:
          'TrakMate’s smart fleet solutions connect vehicles, capture real-time data, and deliver actionable insights to help businesses monitor, manage, and optimize their fleets.',
      stats: [
        _StatData(
          icon: "icons/badge.svg",
          value: "12+",
          label: "Years of Experience",
        ),
        _StatData(
          icon: "icons/delivery.svg",
          value: "750+",
          label: "Projects Delivered",
        ),
        _StatData(
          icon: "icons/handshake.svg",
          value: "25+",
          label: "Happy Clients",
        ),
        _StatData(
          icon: "icons/globe.svg",
          value: "6+",
          label: "Countries Served",
        ),
      ],
      // buttonText: "Explore Solutions",
    ),
    _HeroSlideData(
      video: "video/v2.mp4",
      label: "CONNECTED TECHNOLOGY",
      headingLine1: "Smart Connections.",
      headingLine2: "Smarter Asset Management.",
      description:
          'TrakMate connects your assets, captures valuable data, and turns it into actionable insights—giving businesses the knowledge they need, when they need it.',
      stats: [
        _StatData(
          icon: "icons/badge.svg",
          value: "12+",
          label: "Years of Experience",
        ),
        _StatData(
          icon: "icons/delivery.svg",
          value: "750+",
          label: "Projects Delivered",
        ),
        _StatData(
          icon: "icons/handshake.svg",
          value: "25+",
          label: "Happy Clients",
        ),
        _StatData(
          icon: "icons/globe.svg",
          value: "6+",
          label: "Countries Served",
        ),
      ],
      // buttonText: "Explore Solutions",
    ),
    _HeroSlideData(
      video: "video/v3.mp4",
      label: "TRUSTED WORLDWIDE",
      headingLine1: "Built for Scale.",
      headingLine2: "Delivered with Precision.",
      description:
          'With clients across 6+ countries and 750+ products delivered, TrakMate is a technology partner businesses rely on globally.',
      stats: [
        _StatData(
          icon: "icons/badge.svg",
          value: "12+",
          label: "Years of Experience",
        ),
        _StatData(
          icon: "icons/delivery.svg",
          value: "750+",
          label: "Projects Delivered",
        ),
        _StatData(
          icon: "icons/handshake.svg",
          value: "25+",
          label: "Happy Clients",
        ),
        _StatData(
          icon: "icons/globe.svg",
          value: "6+",
          label: "Countries Served",
        ),
      ],
      // buttonText: "Explore Solutions",
    ),
    _HeroSlideData(
      video: "video/v4.mp4",
      label: "TRUSTED WORLDWIDE",
      headingLine1: "Built for Scale.",
      headingLine2: "Delivered with Precision.",
      description:
          'With clients across 6+ countries and 750+ products delivered, TrakMate is a technology partner businesses rely on globally.',
      stats: [
        _StatData(
          icon: "icons/badge.svg",
          value: "12+",
          label: "Years of Experience",
        ),
        _StatData(
          icon: "icons/delivery.svg",
          value: "750+",
          label: "Projects Delivered",
        ),
        _StatData(
          icon: "icons/handshake.svg",
          value: "25+",
          label: "Happy Clients",
        ),
        _StatData(
          icon: "icons/globe.svg",
          value: "6+",
          label: "Countries Served",
        ),
      ],
      // buttonText: "Explore Solutions",
    ),
  ];

  final PageController _pageController = PageController(initialPage: 0);
  final ScrollController _scrollController = ScrollController();
  final List<VideoPlayerController> _videoControllers = [];

  Timer? _autoSlideTimer;
  int _currentVirtualPage = 0;
  bool _isPrevHovered = false;
  bool _isNextHovered = false;
  bool _isSlideHovered = false;
  bool _isSliderPaused = false;
  bool _showPauseButton = true;
  bool _isMuted = true;
  // bool _isScrollButtonHovered = false;
  Timer? _pauseButtonTimer;
  // ADD THIS
  bool get _isCurrentVideoReady {
    final int activeIndex = _currentVirtualPage % _slides.length;
    if (_videoControllers.length <= activeIndex) return false;
    return _videoControllers[activeIndex].value.isInitialized;
  }

  @override
  void initState() {
    super.initState();

    _initializeVideos();
    _startAutoSlide();
  }

  Future<void> _initializeVideos() async {
    // Create controllers first
    for (final slide in _slides) {
      _videoControllers.add(VideoPlayerController.asset(slide.video));
    }

    // Initialize ONLY the first video immediately
    final firstController = _videoControllers[0];

    try {
      // ADD
      await firstController.initialize();
      await firstController.setLooping(true);
      await firstController.setVolume(0);
      // await Future.delayed(const Duration(seconds: 3)); //testing only
    } catch (e) {
      // ADD
      debugPrint('Failed to initialize first video: $e'); // ADD
    }
    if (mounted) {
      setState(() {});
    }

    // Start first video as soon as it is ready
    if (mounted && widget.isActive) {
      await firstController.play();
    }

    // Load remaining videos in the background
    for (int i = 1; i < _videoControllers.length; i++) {
      _initializeVideoInBackground(i);
    }
  }

  Future<void> _initializeVideoInBackground(int index) async {
    final controller = _videoControllers[index];

    if (controller.value.isInitialized) return;

    try {
      await controller.initialize();
      await controller.setLooping(true);
      await controller.setVolume(0);

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint('Failed to initialize video $index: $e');
    }
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();

    _autoSlideTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (!mounted || _isSliderPaused) return;

      _currentVirtualPage++;

      _pageController.animateToPage(
        _currentVirtualPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  //   void _startAutoSlide() {
  //   _autoSlideTimer?.cancel();
  //   debugPrint('🔵 Starting auto-slide timer: 15 seconds'); // ADD THIS

  //   _autoSlideTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
  //     if (!mounted || _isSliderPaused) return;
  //     debugPrint('🔵 Auto-advancing slide at ${DateTime.now()}'); // ADD THIS

  //     _currentVirtualPage++;
  //     _pageController.animateToPage(
  //       _currentVirtualPage,
  //       duration: const Duration(milliseconds: 600),
  //       curve: Curves.easeInOut,
  //     );
  //   });
  // }

  void _showPauseControl() {
    _pauseButtonTimer?.cancel();

    if (!mounted) return;

    setState(() {
      _showPauseButton = true;
    });
  }

  void _hidePauseControl() {
    _pauseButtonTimer?.cancel();

    if (_isSliderPaused) return;

    _pauseButtonTimer = Timer(const Duration(milliseconds: 500), () {
      if (!mounted || _isSliderPaused) return;

      setState(() {
        _showPauseButton = false;
      });
    });
  }

  void _onNextPressed() {
    if (_isSliderPaused) return;

    _showPauseControl();

    _currentVirtualPage++;

    _pageController.animateToPage(
      _currentVirtualPage,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );

    _startAutoSlide();
  }

  void _onPrevPressed() {
    if (_isSliderPaused) return;

    _showPauseControl();

    _currentVirtualPage--;

    _pageController.animateToPage(
      _currentVirtualPage,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );

    _startAutoSlide();
  }

  double _getHeroHeight(BuildContext context) {
    final width = MediaQuery.of(context).size.height;

    return width * 0.91;
    //  return (width * 0.35).clamp(500.0, 600.0);
  }
  // double _getHeroHeight(BuildContext context) {
  //   final width = MediaQuery.of(context).size.width;

  //   if (width < 900) {
  //     return 360;
  //   }

  //   if (width < 1400) {
  //     return 420;
  //   }

  //   if (width < 1800) {
  //     return 460;
  //   }

  //   return 500;
  // }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pauseButtonTimer?.cancel();
    _pageController.dispose();
    _scrollController.dispose();
    for (final controller in _videoControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  Future<void> _updateVideoPlayback() async {
    if (!mounted || _videoControllers.isEmpty) return;

    // Home is not active → stop all videos
    if (!widget.isActive) {
      for (final controller in _videoControllers) {
        if (controller.value.isInitialized) {
          await controller.pause();
        }
      }
      return;
    }

    // Home is active, but user manually paused → keep it paused
    if (_isSliderPaused) {
      return;
    }

    // Home is active and slider is not paused → play current video
    final int activeIndex = _currentVirtualPage % _slides.length;

    final controller = _videoControllers[activeIndex];

    if (controller.value.isInitialized) {
      await controller.play();
    }
  }

  @override
  void didUpdateWidget(covariant HomeSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isActive != widget.isActive) {
      if (widget.isActive) {
        _startAutoSlide();
      } else {
        _autoSlideTimer?.cancel();
      }

      _updateVideoPlayback();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          _buildHeroSection(),
          const SizedBox(height: 10),
          IndustriesProductsSection(onNavigate: widget.onNavigate),
          const SizedBox(height: 40),
          FooterSection(),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    // final width = MediaQuery.of(context).size.width;
    // print("SCREEN WIDTH: $width");
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isSlideHovered = true);
        _showPauseControl();
      },
      onExit: (_) {
        setState(() => _isSlideHovered = false);
        _hidePauseControl();
      },
      child: GestureDetector(
        onTapDown: (_) {
          if (!_isSliderPaused) {
            setState(() => _isSlideHovered = true);
          }
        },
        child: SizedBox(
          width: double.infinity,
          // height: 460,
          height: _getHeroHeight(context),
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                physics:
                    _isSliderPaused
                        ? const NeverScrollableScrollPhysics()
                        : const PageScrollPhysics(),
                onPageChanged: (index) {
                  final int newIndex = index % _slides.length;

                  // Update page immediately
                  setState(() {
                    _currentVirtualPage = index;
                  });

                  // Make sure controllers are available
                  if (_videoControllers.length != _slides.length) {
                    return;
                  }

                  // Pause all videos
                  for (final controller in _videoControllers) {
                    if (controller.value.isInitialized) {
                      controller.pause();
                    }
                  }

                  // Play current video's beginning
                  final controller = _videoControllers[newIndex];

                  if (controller.value.isInitialized) {
                    controller
                      ..seekTo(Duration.zero)
                      ..setVolume(_isMuted ? 0.0 : 1.0)
                      ..play();
                  }
                },
                itemBuilder: (context, index) {
                  final slideIndex = index % _slides.length;
                  return _buildSlide(_slides[slideIndex]);
                },
              ),
              // Sound button
              // Positioned(
              //   bottom: 20,
              //   right: 20,
              //   child: GestureDetector(
              //     onTap: () async {
              //       final int activeIndex =
              //           _currentVirtualPage % _slides.length;

              //       if (_videoControllers.length <= activeIndex) return;

              //       final controller = _videoControllers[activeIndex];

              //       if (!controller.value.isInitialized) return;

              //       setState(() {
              //         _isMuted = !_isMuted;
              //       });

              //       await controller.setVolume(_isMuted ? 0.0 : 1.0);
              //     },
              //     child: Container(
              //       width: 25,
              //       height: 25,
              //       decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         color: tWhite.withOpacity(0.12),
              //         border: Border.all(
              //           color: tOrange1.withOpacity(0.7),
              //           width: 1.5,
              //         ),
              //       ),
              //       child: Icon(
              //         _isMuted
              //             ? CupertinoIcons.volume_off
              //             : CupertinoIcons.volume_up,
              //         color: tOrange1,
              //         size: 15,
              //       ),
              //     ),
              //   ),
              // ),
              // Pause / Resume button
              Positioned.fill(
                child: IgnorePointer(
                  // ignoring: !_showPauseButton && !_isSliderPaused,
                  ignoring:
                      !_isCurrentVideoReady ||
                      (!_showPauseButton && !_isSliderPaused),
                  child: Center(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 900),
                      curve: Curves.easeOut,
                      // opacity:
                      //     _isSliderPaused
                      //         ? 1.0
                      //         : (_showPauseButton ? 1.0 : 0.0),
                      opacity:
                          !_isCurrentVideoReady
                              ? 0.0
                              : (_isSliderPaused
                                  ? 1.0
                                  : (_showPauseButton ? 1.0 : 0.0)),
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            _isSliderPaused = !_isSliderPaused;
                          });
                          if (_isSliderPaused) {
                            _pauseButtonTimer?.cancel();
                            _showPauseButton = true;
                            _autoSlideTimer?.cancel();

                            for (final controller in _videoControllers) {
                              controller.pause();
                            }
                          } else {
                            _startAutoSlide();

                            final int activeIndex =
                                _currentVirtualPage % _slides.length;

                            if (_videoControllers[activeIndex]
                                .value
                                .isInitialized) {
                              final controller = _videoControllers[activeIndex];

                              await controller.play();
                            }

                            if (_isSlideHovered) {
                              _showPauseControl();
                            } else {
                              _hidePauseControl();
                            }
                          }
                        },
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            border: Border.all(
                              color: tOrange1.withOpacity(0.7),
                              width: 1.8,
                            ),
                          ),
                          child: Icon(
                            _isSliderPaused
                                ? CupertinoIcons.play_fill
                                : CupertinoIcons.pause_fill,
                            color: tOrange1.withOpacity(0.7),
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Dot indicators
              Positioned(
                bottom: 12,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  // ignoring: _isSliderPaused,
                  ignoring: !_isCurrentVideoReady || _isSliderPaused,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    // opacity: _isSliderPaused ? 0.0 : 1.0,
                    opacity:
                        !_isCurrentVideoReady
                            ? 0.0
                            : (_isSliderPaused ? 0.0 : 1.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_slides.length, (index) {
                        final int activeIndex =
                            _currentVirtualPage % _slides.length;
                        final bool isActive = (activeIndex == index);
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: isActive ? 13 : 10,
                          height: isActive ? 13 : 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                                  isActive ? tOrange1 : tWhite.withOpacity(0.5),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: isActive ? 6 : 0,
                              height: isActive ? 6 : 0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: tOrange1,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),

              // Left
              Positioned(
                left: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    // opacity:
                    //     _isSliderPaused ? 0.0 : (_isSlideHovered ? 1.0 : 0.0),
                    opacity:
                        !_isCurrentVideoReady
                            ? 0.0
                            : (_isSliderPaused
                                ? 0.0
                                : (_isSlideHovered ? 1.0 : 0.0)),
                    child: IgnorePointer(
                      // ignoring: !_isSlideHovered,
                      ignoring: !_isCurrentVideoReady || !_isSlideHovered,
                      child: MouseRegion(
                        onEnter: (_) => setState(() => _isPrevHovered = true),
                        onExit: (_) => setState(() => _isPrevHovered = false),
                        child: InkWell(
                          onTap: _onPrevPressed,
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: tWhite.withOpacity(0.15),
                              border: Border.all(
                                color:
                                    _isPrevHovered
                                        ? tOrange1
                                        : tWhite.withOpacity(0.6),
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              CupertinoIcons.arrow_left,
                              color: _isPrevHovered ? tOrange1 : Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Right
              Positioned(
                right: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    // opacity:
                    //     _isSliderPaused ? 0.0 : (_isSlideHovered ? 1.0 : 0.0),
                    opacity:
                        !_isCurrentVideoReady
                            ? 0.0
                            : (_isSliderPaused
                                ? 0.0
                                : (_isSlideHovered ? 1.0 : 0.0)),
                    child: IgnorePointer(
                      // ignoring: _isSliderPaused || !_isSlideHovered,
                      ignoring:
                          !_isCurrentVideoReady ||
                          _isSliderPaused ||
                          !_isSlideHovered,
                      child: MouseRegion(
                        onEnter: (_) => setState(() => _isNextHovered = true),
                        onExit: (_) => setState(() => _isNextHovered = false),
                        child: InkWell(
                          onTap: _onNextPressed,
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: tWhite.withOpacity(0.15),
                              border: Border.all(
                                color:
                                    _isNextHovered
                                        ? tOrange1
                                        : tWhite.withOpacity(0.6),
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              CupertinoIcons.arrow_right,
                              color: _isNextHovered ? tOrange1 : Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Scroller
              Positioned(
                right: 45,
                bottom: 45,
                child: ScrollerButton(
                  isVisible: _isSlideHovered && _isCurrentVideoReady,
                  onTap: () {
                    if (!_scrollController.hasClients) return;

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (!_scrollController.hasClients) return;

                      final double target = _getHeroHeight(context);

                      _scrollController.animateTo(
                        target.clamp(
                          0.0,
                          _scrollController.position.maxScrollExtent,
                        ),
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.easeInOutCubic,
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlide(_HeroSlideData slide) {
    final int slideIndex = _slides.indexOf(slide);

    if (_videoControllers.length <= slideIndex) {
      // return Container(width: double.infinity, color: tBlue2);
      return const SizedBox(width: double.infinity, child: HeroVideoShimmer());
    }

    final VideoPlayerController controller = _videoControllers[slideIndex];

    return SizedBox(
      width: double.infinity,
      child: Stack(
        // fit: StackFit.expand,
        children: [
          // Background video
          // if (controller.value.isInitialized)
          //   Positioned.fill(
          //     child: FittedBox(
          //       fit: BoxFit.cover,
          //       child: SizedBox(
          //         width: controller.value.size.width,
          //         height: controller.value.size.height,
          //         child: VideoPlayer(controller),
          //       ),
          //     ),
          //   )
          // else
          //   Container(color: tBlue2),
          // Background video
          if (controller.value.isInitialized)
            Positioned.fill(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: controller.value.size.width,
                  height: controller.value.size.height,
                  child: VideoPlayer(controller),
                ),
              ),
            )
          else
            const Positioned.fill(child: HeroVideoShimmer()), // CHANGED
          // Dark gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  tBlue2.withOpacity(0.85),
                  tBlue2.withOpacity(0.55),
                  Colors.transparent,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: const [0.0, 0.45, 1.0],
              ),
            ),
          ),
          if (controller.value.isInitialized) // ADD THIS GUARD
            // Your existing content
            if (controller.value.isInitialized)
              Padding(
                padding: const EdgeInsets.only(
                  left: 115,
                  right: 40,
                ), //fr whole text block
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Transform.translate(
                        offset: const Offset(0, -38),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeroAnimatedText(
                              isActive: widget.isActive,
                              delay: 520,
                              child: Text(
                                slide.label,
                                style: GoogleFonts.manrope(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: tOrange1,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),
                            HeroAnimatedText(
                              isActive: widget.isActive,
                              delay: 720,
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.manrope(
                                    fontSize: 48,
                                    fontWeight: FontWeight.w600,
                                    height: 1.15,
                                    color: tWhite,
                                  ),
                                  children: [
                                    TextSpan(text: "${slide.headingLine1}\n"),
                                    TextSpan(
                                      text: slide.headingLine2,
                                      style: GoogleFonts.manrope(
                                        color: tOrange1,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),
                            HeroAnimatedText(
                              isActive: widget.isActive,
                              delay: 920,
                              child: SizedBox(
                                width: 480,
                                child: Text(
                                  slide.description,
                                  style: GoogleFonts.manrope(
                                    fontSize: 14,
                                    color: tWhite.withOpacity(0.95),
                                    fontWeight: FontWeight.w500,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 40),
                            HeroAnimatedText(
                              isActive: widget.isActive,
                              delay: 1120,
                              child: Row(
                                children: [
                                  for (
                                    int i = 0;
                                    i < slide.stats.length;
                                    i++
                                  ) ...[
                                    if (i != 0) const SizedBox(width: 66),
                                    _buildStatItem(
                                      slide.stats[i].icon,
                                      slide.stats[i].value,
                                      slide.stats[i].label,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            // ElevatedButton(
                            //   onPressed: () {},
                            //   style: ElevatedButton.styleFrom(
                            //     backgroundColor: tOrange1,
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(8),
                            //     ),
                            //     padding: const EdgeInsets.symmetric(
                            //       horizontal: 22,
                            //       vertical: 18,
                            //     ),
                            //   ),
                            //   child: Row(
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: [
                            //       Text(
                            //         slide.buttonText,
                            //         style: GoogleFonts.manrope(
                            //           color: tWhite,
                            //           fontSize: 13,
                            //           fontWeight: FontWeight.w600,
                            //         ),
                            //       ),
                            //       const SizedBox(width: 8),
                            //       const Icon(
                            //         Icons.arrow_forward,
                            //         color: tWhite,
                            //         size: 16,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(flex: 2, child: SizedBox()),
                  ],
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String iconPath, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,

          // decoration: BoxDecoration(
          //   shape: BoxShape.circle,
          //   border: Border.all(color: tOrange1.withOpacity(0.6), width: 1.2),
          // ),
          child: SvgPicture.asset(
            iconPath,
            width: 30,
            height: 30,
            // colorFilter: const ColorFilter.mode(tOrange1, BlendMode.srcIn),
            color: tOrange1,
          ),
        ),
        const SizedBox(height: 10),

        Text(
          value,
          style: GoogleFonts.manrope(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: tWhite,
          ),
        ),

        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: tWhite.withOpacity(0.75),
          ),
        ),
      ],
    );
  }
}
