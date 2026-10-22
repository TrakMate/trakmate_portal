//manufacturing
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:trakmate_portal/src/ui/widgets/hero_animation.dart';
import 'package:trakmate_portal/src/ui/widgets/nav_footer.dart';
import 'package:trakmate_portal/src/ui/widgets/process_section.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmer_effect.dart';
import 'package:trakmate_portal/src/utils/responsive.dart';
import '../../utils/colors.dart';
import '../widgets/footer_section.dart';

class ManufacturingSection extends StatefulWidget {
  final bool isActive;
  final void Function(int index) onNavigate;

  const ManufacturingSection({
    super.key,
    required this.isActive,
    required this.onNavigate,
  });

  @override
  State<ManufacturingSection> createState() => _ManufacturingSectionState();
}

class _ManufacturingSectionState extends State<ManufacturingSection> {
  bool _heroImageLoading = true;
  bool _cardsLoading = true;

  // Breakpoints come from ResponsiveLayout:
  //   mobile  < 700   |   tablet 700 - 1099   |   desktop >= 1100
  bool get isMobile => ResponsiveLayout.isMobile(context);
  bool get isTablet => ResponsiveLayout.isTablet(context);

  // Horizontal page padding for the content blocks below the hero
  double get _pagePadding => isMobile ? 16 : (isTablet ? 24 : 40);

  final Set<int> _hoveredServiceCards = {};

  @override
  void initState() {
    super.initState();
    SectionScrollBus.instance.pendingKey.addListener(_onPendingKeyChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadHeroImage();
      _preloadServiceImages();
      _tryScrollToPending();
    });
  }

  @override
  void didUpdateWidget(covariant ManufacturingSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _tryScrollToPending(),
      );
    }
  }

  @override
  void dispose() {
    SectionScrollBus.instance.pendingKey.removeListener(_onPendingKeyChanged);
    super.dispose();
  }

  void _onPendingKeyChanged() {
    if (widget.isActive) _tryScrollToPending();
  }

  void _tryScrollToPending() {
    final target = SectionScrollBus.instance.pendingKey.value;
    if (target == null) return;

    final key = _serviceKeys[target.key];
    if (key == null) return; // not one of this section's items

    final ctx = key.currentContext;
    if (ctx == null) {
      // layout not ready yet, retry next frame
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _tryScrollToPending(),
      );
      return;
    }

    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      alignment: 0.1,
    );

    SectionScrollBus.instance.pendingKey.value = null; // consumed
  }

  Future<void> _preloadHeroImage() async {
    try {
      await precacheImage(
        const AssetImage(_heroImage), // images/manufacturing.jpg
        context,
        onError: (e, s) => debugPrint('Failed to load manufacturing hero: $e'),
      ).timeout(const Duration(seconds: 10)); // never stay stuck on shimmer
    } catch (e) {
      // ignore
    }

    if (!mounted) return;
    setState(() {
      _heroImageLoading = false;
    });
  }

  Future<void> _preloadServiceImages() async {
    try {
      await Future.wait(
        _services.map(
          (s) => precacheImage(
            AssetImage(s.image),
            context,
            onError: (e, st) => debugPrint('FAILED to load ${s.image}: $e'),
          ),
        ),
      );
    } catch (e) {
      // ignore
    }
    if (!mounted) return;
    setState(() => _cardsLoading = false);
  }

  static const String _heroImage = 'images/manufacturing.jpg';

  final Map<String, GlobalKey> _serviceKeys = {
    'Electronics Manufacturing': GlobalKey(),
    'Product Assembly': GlobalKey(),
    'Testing & Validation': GlobalKey(),
    'Quality Assurance': GlobalKey(),
    'Production Support': GlobalKey(),
    'Contract Manufacturing': GlobalKey(),
  };
  final List<_ManufacturingService> _services = const [
    _ManufacturingService(
      title: 'Electronics Manufacturing',
      description:
          'End-to-end electronics manufacturing with reliable processes and quality-focused production.',
      image: 'images/manufacture.jpg',
      icon: 'icons/automation.svg',
    ),
    _ManufacturingService(
      title: 'Product Assembly',
      description:
          'Efficient product assembly solutions built for consistent quality and scalable production.',
      image: 'images/pcba.jpg',
      icon: 'icons/product.svg',
    ),
    _ManufacturingService(
      title: 'Testing & Validation',
      description:
          'Comprehensive testing, electrical validation and performance checks for dependable products.',
      image: 'images/testing.jpg',
      icon: 'icons/search.svg',
    ),
    _ManufacturingService(
      title: 'Quality Assurance',
      description:
          'Rigorous quality control processes and standards to deliver defect-free products consistently.',
      image: 'images/quality_assurance.jpg',
      icon: 'icons/quality.svg',
    ),
    _ManufacturingService(
      title: 'Production Support',
      description:
          'End-to-end production support including supply-chain management and process improvement.',
      image: 'images/production_support.jpg',
      icon: 'icons/production.svg',
    ),
    _ManufacturingService(
      title: 'Contract Manufacturing',
      description:
          'Flexible manufacturing support designed to scale with your product and business requirements.',
      image: 'images/contract_manufacturing.jpg',
      icon: 'icons/contract.svg',
    ),
  ];

  final List<_ManufacturingValue> _values = const [
    _ManufacturingValue(
      icon: 'icons/quality.svg',
      title: 'High Quality',
      description: 'Standardized processes and consistent product quality.',
    ),
    _ManufacturingValue(
      icon: 'icons/laptop.svg',
      title: 'Advanced Facilities',
      description: 'Modern capabilities for efficient and reliable production.',
    ),
    _ManufacturingValue(
      icon: 'icons/team.svg',
      title: 'Experienced Team',
      description: 'Skilled professionals focused on precision and execution.',
    ),
    _ManufacturingValue(
      icon: 'icons/scalability.svg',
      title: 'Scalable Solutions',
      description:
          'Production support designed to grow with your requirements.',
    ),
    _ManufacturingValue(
      icon: 'icons/ontime.svg',
      title: 'On-Time Delivery',
      description: 'Structured planning and dependable production schedules.',
    ),
    _ManufacturingValue(
      icon: 'icons/secured.svg',
      title: 'Confidential & Secure',
      description: 'Responsible handling of products, processes and data.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double gap = isMobile ? 32 : 42;

    return SingleChildScrollView(
      child: Column(
        children: [
          _heroImageLoading ? const HeroHeaderShimmer() : _buildHero(),

          SizedBox(height: gap),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: _pagePadding),
            child: _buildServicesSection(),
          ),

          SizedBox(height: gap),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: _pagePadding),
            child: _buildQualityBar(),
          ),

          SizedBox(height: gap),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: _pagePadding),
            child: ProcessSection(
              eyebrow: 'OUR MANUFACTURING PROCESS',
              title: 'From Concept to Customer',
              steps: const [
                ProcessStepData(
                  number: '01',
                  icon: 'icons/design.svg',
                  title: 'Design for Manufacturability',
                  description:
                      'We understand your product requirements, specifications and production goals.',
                ),
                ProcessStepData(
                  number: '02',
                  icon: 'icons/automation.svg',
                  title: 'Sourcing & Planning',
                  description:
                      'We source the right materials, components and resources for production.',
                ),
                ProcessStepData(
                  number: '03',
                  icon: 'icons/product.svg',
                  title: 'Production & Assembly',
                  description:
                      'Products are assembled and manufactured with precision and controlled processes.',
                ),
                ProcessStepData(
                  number: '04',
                  icon: 'icons/search.svg',
                  title: 'Testing & Validation',
                  description:
                      'Products undergo testing and validation to ensure reliability and performance.',
                ),
                ProcessStepData(
                  number: '05',
                  icon: 'icons/truck.svg',
                  title: 'Packaging & Delivery',
                  description:
                      'Finished products are prepared, packaged and coordinated for delivery.',
                ),
              ],
            ),
          ),

          SizedBox(height: isMobile ? 36 : 45),

          FooterSection(onNavigate: widget.onNavigate),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HERO
  // ---------------------------------------------------------------------------
  Widget _buildHero() {
    // Mobile has its own stacked layout (image on top, text below).
    if (isMobile) return _buildMobileHero();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tBlue2, tBlue3],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // How much of the hero width the image covers (from the right).
          final double imageWidth =
              constraints.maxWidth * (isTablet ? 0.5 : 0.62);

          return Stack(
            children: [
              // 1) IMAGE LAYER (behind the text), blended into the blue
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                width: imageWidth,
                child: _buildBlendedHeroImage(),
              ),

              // 2) CONTENT LAYER (text + cards) on top
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 400),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 24 : 40,
                    vertical: 25,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: isTablet ? 8 : 1,
                        child: _buildHeroTextColumn(),
                      ),
                      SizedBox(width: isTablet ? 0 : 40),
                      // Empty half: the image shows through behind this space.
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // MOBILE hero: image banner on top (fading into the blue), text below.
  Widget _buildMobileHero() {
    final double screenW = MediaQuery.of(context).size.width;

    return Container(
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
          SizedBox(
            width: double.infinity,
            height: screenW * 0.62,
            child: _buildMobileHeroImage(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
            child: _buildHeroTextColumn(),
          ),
        ],
      ),
    );
  }

  /// Mobile hero image: only the bottom edge fades into the blue.
  Widget _buildMobileHeroImage() {
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.black, Colors.transparent],
          stops: [0.0, 0.6, 1.0],
        ).createShader(rect);
      },
      child: Image.asset(
        _heroImage,
        fit: BoxFit.cover,
        alignment: Alignment.centerRight,
        errorBuilder: (context, error, stackTrace) {
          return _buildImageFallback(dark: true);
        },
      ),
    );
  }

  /// Hero image with its LEFT edge (and a bit of the BOTTOM edge)
  /// faded to transparent, so it melts into the blue background.
  Widget _buildBlendedHeroImage() {
    // Horizontal fade: left = invisible -> right = fully visible
    final Widget horizontallyFaded = ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.transparent, Colors.black54, Colors.black],
          stops: [0.0, 0.30, 0.55],
        ).createShader(rect);
      },
      child: Image.asset(
        _heroImage,
        fit: BoxFit.cover,
        alignment: Alignment.centerRight,
        errorBuilder: (context, error, stackTrace) {
          return _buildImageFallback(dark: true);
        },
      ),
    );

    // Vertical fade: softens the bottom edge into the blue.
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.black, Colors.transparent],
          stops: [0.0, 0.80, 1.0],
        ).createShader(rect);
      },
      child: horizontallyFaded,
    );
  }

  /// Left side: label, title, description and the 4 hero points.
  Widget _buildHeroTextColumn() {
    final bool mobile = isMobile;
    final double screenW = MediaQuery.of(context).size.width;
    final bool compact = screenW < 380; // medium phones

    final double headingSize =
        mobile ? (compact ? 25 : 30) : (isTablet ? 34 : 48);

    // (icon, title, subtitle, animation delay)
    const List<(String, String, String, int)> pointData = [
      (
        'icons/laptop.svg',
        'Advanced Infrastructure',
        'Modern facilities for efficient production',
        520,
      ),
      (
        'icons/team.svg',
        'Skilled Workforce',
        'Experienced teams focused on precision',
        720,
      ),
      (
        'icons/quality1.svg',
        'Quality Focus',
        'Consistent quality at every stage',
        920,
      ),
      (
        'icons/ontime.svg',
        'On-Time Delivery',
        'Reliable production and timely delivery',
        1120,
      ),
    ];

    Widget pointAt(int i) => HeroAnimatedText(
      isActive: widget.isActive,
      delay: pointData[i].$4,
      child: _buildHeroPoint(
        icon: pointData[i].$1,
        title: pointData[i].$2,
        subtitle: pointData[i].$3,
      ),
    );

    Widget points;
    if (mobile) {
      // Mobile: 2 x 2 grid
      const double hPad = 20;
      const double gap = 16;
      final double cardW = ((screenW - (hPad * 2) - gap) / 2).floorToDouble();
      points = Wrap(
        spacing: gap,
        runSpacing: 22,
        children: [
          for (int i = 0; i < pointData.length; i++)
            SizedBox(width: cardW, child: pointAt(i)),
        ],
      );
    } else {
      // Tablet / desktop (unchanged): one row
      points = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: pointAt(0)),
          SizedBox(width: isTablet ? 17 : 0),
          Expanded(child: pointAt(1)),
          Expanded(child: pointAt(2)),
          Expanded(child: pointAt(3)),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroAnimatedText(
          isActive: widget.isActive,
          delay: 20,
          child: Text(
            'MANUFACTURING EXCELLENCE',
            style: GoogleFonts.manrope(
              fontSize: mobile ? 12 : 13,
              fontWeight: FontWeight.w600,
              color: tOrange1,
              letterSpacing: 1.2,
            ),
          ),
        ),

        SizedBox(height: mobile ? 12 : 15),
        HeroAnimatedText(
          isActive: widget.isActive,
          delay: 120,
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.manrope(
                fontSize: headingSize,
                fontWeight: FontWeight.w600,
                height: mobile ? 1.2 : 1.15,
                color: tWhite,
              ),
              children: [
                const TextSpan(text: 'Precision Manufacturing.\n'),
                TextSpan(
                  text: 'Trusted Delivery.',
                  style: TextStyle(
                    color: tOrange1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: mobile ? 14 : 18),
        HeroAnimatedText(
          isActive: widget.isActive,
          delay: 320,
          child: Text(
            'End-to-end manufacturing solutions designed to deliver reliable, scalable and quality-focused products.',
            style: GoogleFonts.manrope(
              fontSize: 13,
              color: tWhite,
              fontWeight: FontWeight.w400,
              height: 1.55,
            ),
          ),
        ),

        SizedBox(height: mobile ? 26 : 32),

        points,
      ],
    );
  }

  Widget _buildHeroPoint({
    required String icon,
    required String title,
    required String subtitle,
  }) {
    final bool mobile = isMobile;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mobile ? 0 : (isTablet ? 1 : 6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(icon, width: 30, height: 30, color: tOrange1),
            const SizedBox(height: 10),

            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                maxLines: 1,
                softWrap: false,
                style: GoogleFonts.manrope(
                  color: tWhite,
                  fontSize: isTablet ? 12.5 : 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 6),

            Text(
              subtitle,
              style: GoogleFonts.manrope(
                color: tWhite.withOpacity(0.7),
                fontSize: isTablet ? 11 : (mobile ? 11.5 : 12),
                height: 1.35,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SERVICES
  // ---------------------------------------------------------------------------
  Widget _buildServicesSection() {
    // final bool mobile = isMobile;

    final Widget description = Text(
      'From electronics manufacturing and assembly to testing and production support, we help bring products from concept to reality.',
      textAlign: TextAlign.center,
      style: GoogleFonts.manrope(
        fontSize: isMobile ? 12.5 : 13,
        fontWeight: FontWeight.w500,
        color: tBlack,
        height: 1.5,
      ),
    );

    return Column(
      children: [
        Text(
          'OUR MANUFACTURING SERVICES',
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: isMobile ? 12 : 13,
            fontWeight: FontWeight.w600,
            color: tOrange1,
            letterSpacing: 1.2,
          ),
        ),

        SizedBox(height: isMobile ? 8 : 10),

        Text(
          'End-to-End Manufacturing Solutions',
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: isMobile ? 20 : 25,
            fontWeight: FontWeight.w700,
            color: tBlue2,
            height: 1.2,
          ),
        ),

        const SizedBox(height: 4),

        // Desktop / tablet keep the fixed 600px width; mobile uses full width
        if (isMobile) description else SizedBox(width: 600, child: description),

        SizedBox(height: isMobile ? 24 : 30),

        LayoutBuilder(
          builder: (context, constraints) {
            const double spacing = 16;

            // Mobile: 1 card per row on phones, 2 on very wide phones.
            // Tablet / desktop: 3 per row (unchanged).
            final int columns =
                isMobile ? (constraints.maxWidth >= 560 ? 2 : 1) : 3;

            final double cardWidth =
                ((constraints.maxWidth - spacing * (columns - 1)) / columns)
                    .clamp(0.0, double.infinity);

            if (_cardsLoading) {
              return Wrap(
                spacing: spacing,
                runSpacing: 16,
                children: List.generate(_services.length, (index) {
                  return SizedBox(
                    width: cardWidth,
                    child: const ServiceCardShimmer(),
                  );
                }),
              );
            }
            return Wrap(
              spacing: spacing,
              runSpacing: 30,
              children: List.generate(_services.length, (index) {
                final service = _services[index];

                return SizedBox(
                  key: _serviceKeys[service.title],
                  width: cardWidth,
                  child: _buildServiceCard(service, index),
                );
              }),
            );
          },
        ),
      ],
    );
  }

  Widget _buildServiceCard(_ManufacturingService service, int index) {
    // final bool mobile = _isMobile;
    final Color iconBackground = index.isEven ? tBlue2 : tOrange1;
    final bool touch = isMobile || isTablet;

    // Hover only ever applies on desktop
    final bool isHovered = !touch && _hoveredServiceCards.contains(index);

    return MouseRegion(
      cursor: touch ? MouseCursor.defer : SystemMouseCursors.click,

      onEnter: (_) {
        if (touch) return;
        setState(() {
          _hoveredServiceCards.add(index);
        });
      },

      onExit: (_) {
        if (touch) return;
        setState(() {
          _hoveredServiceCards.remove(index);
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,

        // Card hover effect
        transform: Matrix4.translationValues(0, isHovered ? -5 : 0, 0),

        height: isMobile ? 320 : (isTablet ? 350 : 310), //card height

        decoration: BoxDecoration(
          color: tWhite,
          borderRadius: BorderRadius.circular(14),

          border: Border.all(
            color:
                isHovered
                    ? tOrange1.withOpacity(0.75)
                    : tBlack1.withOpacity(0.08),
            width: isHovered ? 1.2 : 1,
          ),

          boxShadow: [
            BoxShadow(
              color:
                  isHovered
                      ? tBlue2.withOpacity(0.14)
                      : tBlack.withOpacity(0.045),
              blurRadius: isHovered ? 20 : 14,
              offset: Offset(0, isHovered ? 9 : 5),
            ),
          ],
        ),

        clipBehavior: Clip.none,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: isMobile ? 190 : 200, // image height
              width: double.infinity,

              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),

                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        service.image,
                        fit: BoxFit.cover,
                        frameBuilder: (
                          context,
                          child,
                          frame,
                          wasSynchronouslyLoaded,
                        ) {
                          // Cached / instantly available: show immediately
                          if (wasSynchronouslyLoaded) return child;

                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              const ShimmerBox(height: double.infinity),
                              AnimatedOpacity(
                                opacity: frame == null ? 0 : 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                                child: child,
                              ),
                            ],
                          );
                        },
                        errorBuilder:
                            (context, error, stackTrace) =>
                                _buildImageFallback(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Stack(
                clipBehavior: Clip.none,

                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 30, 15, 12),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.manrope(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: tBlack,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Expanded(
                          child: Text(
                            service.description,
                            maxLines: isTablet ? null : 3,
                            overflow:
                                isTablet
                                    ? TextOverflow.visible
                                    : TextOverflow.ellipsis,
                            style: GoogleFonts.manrope(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: tBlack.withOpacity(0.58),
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // STACKED ICON — SAME AS INDUSTRY CARD
                  Positioned(
                    top: -25,
                    left: 17,

                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOut,

                      width: 50,
                      height: 50,

                      decoration: BoxDecoration(
                        color: iconBackground.withOpacity(
                          isHovered ? 1.0 : 0.80,
                        ),

                        borderRadius: BorderRadius.circular(13),

                        boxShadow: [
                          BoxShadow(
                            color: tBlack.withOpacity(isHovered ? 0.16 : 0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),

                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 180),
                        curve: Curves.easeOut,

                        opacity: isHovered ? 1.0 : 0.60,

                        child: SizedBox(
                          width: 50,
                          height: 50,

                          child: Padding(
                            padding: const EdgeInsets.all(8),

                            child: SvgPicture.asset(
                              service.icon,
                              fit: BoxFit.contain,
                              color: tWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // QUALITY BAR ("Why partner with us")
  // ---------------------------------------------------------------------------
  Widget _buildQualityBar() {
    // final bool mobile = _isMobile;

    return Container(
      width: double.infinity,
      padding:
          isMobile
              ? const EdgeInsets.symmetric(horizontal: 14, vertical: 20)
              : const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tBlue2, tBlue3],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: tBlue2.withOpacity(0.16),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'WHY PARTNER WITH US',
            style: GoogleFonts.manrope(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: tOrange1,
              letterSpacing: 1.1,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            'Built on Quality. Driven by Commitment.',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: isMobile ? 17 : 19,
              fontWeight: FontWeight.w700,
              color: tWhite,
              height: isMobile ? 1.25 : null,
            ),
          ),

          SizedBox(height: isMobile ? 20 : 18),

          // Mobile: 2 per row | Tablet: 3 per row | Desktop: single row
          if (isMobile || isTablet)
            LayoutBuilder(
              builder: (context, constraints) {
                const gap = 16.0;
                final int columns = isMobile ? 2 : 3;
                final itemWidth =
                    ((constraints.maxWidth - gap * (columns - 1)) / columns)
                        .clamp(0.0, double.infinity);
                return Wrap(
                  spacing: gap,
                  runSpacing: 24,
                  children: [
                    for (final v in _values)
                      SizedBox(width: itemWidth, child: _buildQualityItem(v)),
                  ],
                );
              },
            )
          else
            Row(
              children: [
                for (int i = 0; i < _values.length; i++) ...[
                  Expanded(child: _buildQualityItem(_values[i])),
                  if (i < _values.length - 1)
                    Container(
                      width: 1,
                      height: 55,
                      color: tWhite.withOpacity(0.14),
                    ),
                ],
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildQualityItem(_ManufacturingValue value) {
    final bool wrapText = isTablet || isMobile;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 4 : 10),
      child: Column(
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: SvgPicture.asset(value.icon, color: tOrange1),
          ),

          const SizedBox(height: 7),

          Text(
            value.title,
            textAlign: TextAlign.center,
            maxLines: wrapText ? null : 1,
            overflow: wrapText ? TextOverflow.visible : TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: tWhite,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            value.description,
            textAlign: TextAlign.center,
            maxLines: wrapText ? null : 2,
            overflow: wrapText ? TextOverflow.visible : TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: tWhite.withOpacity(0.62),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  // IMAGE FALLBACK
  Widget _buildImageFallback({bool dark = false}) {
    return Container(
      color: dark ? tBlue2 : tBlack.withOpacity(0.04),
      alignment: Alignment.center,
      child: Icon(
        Icons.image_not_supported_outlined,
        size: dark ? 48 : 34,
        color: dark ? tWhite.withOpacity(0.55) : tBlack.withOpacity(0.25),
      ),
    );
  }
}

// DATA MODELS

class _ManufacturingService {
  final String title;
  final String description;
  final String image;
  final String icon;

  const _ManufacturingService({
    required this.title,
    required this.description,
    required this.image,
    required this.icon,
  });
}

class _ManufacturingValue {
  final String icon;
  final String title;
  final String description;

  const _ManufacturingValue({
    required this.icon,
    required this.title,
    required this.description,
  });
}
