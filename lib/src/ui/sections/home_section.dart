import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/widgets/buildhome.dart';
import 'package:trakmate_portal/src/utils/colors.dart';
import '../widgets/footer_section.dart';

class HomeSection extends StatefulWidget {
  final ValueChanged<int>? onNavigate;

  const HomeSection({super.key, this.onNavigate});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

// Data for a single hero slide
class _HeroSlideData {
  final String image;
  final String label;
  final String headingLine1;
  final String headingLine2;
  final String description;
  // final String buttonText;
  final List<_StatData> stats;

  const _HeroSlideData({
    required this.image,
    required this.label,
    required this.headingLine1,
    required this.headingLine2,
    required this.description,
    // required this.buttonText,
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
      image: "images/hero1.png",
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
      image: "images/hero1.png",
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
      image: "images/hero1.png",
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
  Timer? _autoSlideTimer;
  int _currentVirtualPage = 0;
  bool _isPrevHovered = false;
  bool _isNextHovered = false;
  bool _isSlideHovered = false;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) return;
      _currentVirtualPage++;
      _pageController.animateToPage(
        _currentVirtualPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  void _onNextPressed() {
    _currentVirtualPage++;
    _pageController.animateToPage(
      _currentVirtualPage,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );

    _startAutoSlide();
  }

  void _onPrevPressed() {
    _currentVirtualPage--;
    _pageController.animateToPage(
      _currentVirtualPage,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );

    _startAutoSlide();
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeroSection(),
          const SizedBox(height: 40),
          IndustriesProductsSection(onNavigate: widget.onNavigate),
          const SizedBox(height: 40),
          FooterSection(),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isSlideHovered = true),
      onExit: (_) => setState(() => _isSlideHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isSlideHovered = true),
        child: SizedBox(
          width: double.infinity,
          height: 400,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentVirtualPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final slideIndex = index % _slides.length;
                  return _buildSlide(_slides[slideIndex]);
                },
              ),

              // Dot indicators
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
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
                          color: isActive ? tOrange1 : tWhite.withOpacity(0.5),
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

              // Left
              Positioned(
                left: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _isSlideHovered ? 1.0 : 0.0,
                    child: IgnorePointer(
                      ignoring: !_isSlideHovered,
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
                    opacity: _isSlideHovered ? 1.0 : 0.0,
                    child: IgnorePointer(
                      ignoring: !_isSlideHovered,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlide(_HeroSlideData slide) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(slide.image),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
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
        // padding: const EdgeInsets.symmetric(horizontal: 40),
        padding: const EdgeInsets.only(left: 65, right: 40),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    slide.label,
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: tOrange1,
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 20),

                  RichText(
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

                  const SizedBox(height: 20),

                  SizedBox(
                    width: 480,
                    child: Text(
                      slide.description,
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: tWhite.withOpacity(0.85),
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  Row(
                    children: [
                      for (int i = 0; i < slide.stats.length; i++) ...[
                        if (i != 0) const SizedBox(width: 66),
                        _buildStatItem(
                          slide.stats[i].icon,
                          slide.stats[i].value,
                          slide.stats[i].label,
                        ),
                      ],
                    ],
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
            const Expanded(flex: 2, child: SizedBox()),
          ],
        ),
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
            fontWeight: FontWeight.w400,
            color: tWhite.withOpacity(0.75),
          ),
        ),
      ],
    );
  }
}
