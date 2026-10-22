import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/pages/main_page.dart';
import 'package:trakmate_portal/src/ui/widgets/process_section.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmer_effect.dart';
import 'package:trakmate_portal/src/utils/colors.dart';
import 'package:trakmate_portal/src/utils/responsive.dart';

class BuildEngineeringSection extends StatefulWidget {
  final Map<String, GlobalKey>? serviceKeys;
  const BuildEngineeringSection({super.key, this.serviceKeys});

  @override
  State<BuildEngineeringSection> createState() =>
      _BuildEngineeringSectionState();
}

class _BuildEngineeringSectionState extends State<BuildEngineeringSection> {
  bool _cardsLoading = true;

  // Breakpoints come from ResponsiveLayout:
  //   mobile  < 700   |   tablet 700 - 1099   |   desktop >= 1100
  bool get isMobile => ResponsiveLayout.isMobile(context);
  bool get isTablet => ResponsiveLayout.isTablet(context);

  // CTA banner is stacked vertically on both tablet and mobile
  bool get _stackedCta => isTablet || isMobile;

  final List<_ServiceItem> _row1 = [
    _ServiceItem(
      icon: 'icons/cad.svg',
      iconBg: tBlueGradient5,
      image: 'images/cad_design.png',
      title: 'CAD Design',
      description:
          'High-quality 3D CAD modeling and drafting for components, assemblies and complex products.',
    ),
    _ServiceItem(
      icon: 'icons/product.svg',
      iconBg: tOrangeGradient2,
      image: 'images/product_design1.png',
      title: 'Product Design',
      description:
          'Innovative product design that combines aesthetics, usability and functionality to create exceptional experiences.',
    ),
    _ServiceItem(
      icon: 'icons/mechanical.svg',
      iconBg: tBlueGradient5,
      image: 'images/mechanical_engineering2.png',
      title: 'Mechanical Engineering',
      description:
          'Engineering analysis, simulation and mechanical design for reliable and high-performance products.',
    ),
    _ServiceItem(
      icon: 'icons/pcb.svg',
      iconBg: tOrangeGradient2,
      image: 'images/pcb2.png',
      title: 'PCB Design',
      description:
          'Schematic capture, layout design and signal integrity analysis for robust and optimized PCB designs.',
    ),
  ];

  final List<_ServiceItem> _row2 = [
    _ServiceItem(
      icon: 'icons/electronics_design.svg',
      iconBg: tBlueGradient5,
      image: 'images/pcba1.png',
      title: 'PCB Assembly (PCBA)',
      description:
          'High-quality PCB assembly with advanced SMT/DIP technology and strict quality control processes.',
    ),
    _ServiceItem(
      icon: 'icons/embedded_systems.svg',
      iconBg: tOrangeGradient2,
      image: 'images/firmware.png',
      title: 'Firmware Development',
      description:
          'Reliable firmware development for embedded systems with optimized performance, security and scalability.',
    ),
    _ServiceItem(
      icon: 'icons/cube.svg',
      iconBg: tBlueGradient5,
      image: 'images/prototype2.png',
      title: 'Prototyping',
      description:
          'Fast and cost-effective prototyping to validate designs, test performance and accelerate time-to-market.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadServiceImages();
    });
  }

  Future<void> _preloadServiceImages() async {
    try {
      await Future.wait([
        ..._row1.map((s) => precacheImage(AssetImage(s.image), context)),
        ..._row2.map((s) => precacheImage(AssetImage(s.image), context)),
      ]);
    } catch (e) {
      // ignore
    }

    if (!mounted) return;
    setState(() {
      _cardsLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool mobile = isMobile;

    return Column(
      children: [
        _buildServicesSection(),
        SizedBox(height: mobile ? 32 : 40),
        _buildCtaBanner(),
        const SizedBox(height: 30),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mobile ? 16 : (isTablet ? 24 : 40),
          ),
          child: ProcessSection(
            eyebrow: 'OUR ENGINEERING PROCESS',
            title: 'From Concept to Creation',
            steps: const [
              ProcessStepData(
                number: '01',
                icon: 'icons/analysis1.svg',
                title: 'Concept & Analysis',
                description:
                    'We understand requirements, assess feasibility and define the right approach.',
              ),
              ProcessStepData(
                number: '02',
                icon: 'icons/design.svg',
                title: 'Design & Development',
                description:
                    'We develop practical designs, detailed schematics and reliable system architectures.',
              ),
              ProcessStepData(
                number: '03',
                icon: 'icons/electronics_design.svg',
                title: 'Prototyping',
                description:
                    'We build functional prototypes, test performance and validate the design.',
              ),
              ProcessStepData(
                number: '04',
                icon: 'icons/validation.svg',
                title: 'Testing & Validation',
                description:
                    'We conduct rigorous testing to ensure quality, reliability and performance.',
              ),
              ProcessStepData(
                number: '05',
                icon: 'icons/production.svg',
                title: 'Production Handoff',
                description:
                    'We ensure a smooth transition from validated designs to scalable mass production.',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServicesSection() {
    final bool mobile = isMobile;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? 16 : (isTablet ? 24 : 40),
        vertical: 10,
      ),
      child: Column(
        children: [
          Text(
            'OUR ENGINEERING SERVICES',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: mobile ? 12 : 13,
              fontWeight: FontWeight.w700,
              color: tOrange1,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: mobile ? 10 : 12),
          Text(
            'Comprehensive Engineering Solutions',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: mobile ? 20 : 25,
              fontWeight: FontWeight.w700,
              color: tBlue2,
              height: mobile ? 1.25 : null,
            ),
          ),
          SizedBox(height: mobile ? 24 : 35),

          LayoutBuilder(
            builder: (context, constraints) {
              const cardSpacing = 20.0;
              final cardWidth = ((constraints.maxWidth - (cardSpacing * 3)) / 4)
                  .clamp(0.0, double.infinity);

              if (isTablet) return _buildTabletGrid();

              // Mobile: 1 card per row on phones, 2 per row on very wide
              // phones / foldables (reuses the tablet 2-column grid).
              if (mobile) {
                return constraints.maxWidth >= 560
                    ? _buildTabletGrid()
                    : _buildMobileList();
              }

              if (_cardsLoading) {
                return Column(
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: List.generate(
                          _row1.length,
                          (_) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: const EngineeringServiceCardShimmer(),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: List.generate(
                          _row2.length,
                          (_) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              width: cardWidth,
                              child: const EngineeringServiceCardShimmer(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              return Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children:
                          _row1
                              .map(
                                (item) => Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    key: widget.serviceKeys?[item.title],
                                    child: _buildServiceCard(item),
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children:
                          _row2
                              .map(
                                (item) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: SizedBox(
                                    width: cardWidth,
                                    key: widget.serviceKeys?[item.title],
                                    child: _buildServiceCard(item),
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabletGrid() {
    final items = [..._row1, ..._row2];
    return Column(
      children: [
        for (int i = 0; i < items.length; i += 2)
          Padding(
            padding: EdgeInsets.only(bottom: i + 2 < items.length ? 20 : 0),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _tabletCell(items[i])),
                  const SizedBox(width: 20),
                  Expanded(
                    child:
                        i + 1 < items.length
                            ? _tabletCell(items[i + 1])
                            : const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  // Mobile: one service card per row (full width)
  Widget _buildMobileList() {
    final items = [..._row1, ..._row2];
    return Column(
      children: [
        for (int i = 0; i < items.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: i < items.length - 1 ? 16 : 0),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [Expanded(child: _tabletCell(items[i]))],
              ),
            ),
          ),
      ],
    );
  }

  Widget _tabletCell(_ServiceItem item) {
    if (_cardsLoading) return const EngineeringServiceCardShimmer();
    return KeyedSubtree(
      key: widget.serviceKeys?[item.title],
      child: _buildServiceCard(item),
    );
  }

  Widget _buildServiceCard(_ServiceItem item) {
    return _HoverCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.5,
                child: Image.asset(
                  item.image,
                  fit: BoxFit.cover,
                  frameBuilder: (
                    context,
                    child,
                    frame,
                    wasSynchronouslyLoaded,
                  ) {
                    if (wasSynchronouslyLoaded) return child;
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        // shimmer stays until the first frame is decoded
                        if (frame == null)
                          const ShimmerBox(height: double.infinity),
                        AnimatedOpacity(
                          opacity: frame == null ? 0 : 1,
                          duration: const Duration(milliseconds: 250),
                          child: child,
                        ),
                      ],
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: tBlack.withOpacity(0.05),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 36,
                        color: tBlack.withOpacity(0.3),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: item.iconBg,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      bottomRight: Radius.circular(14),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: tBlack.withOpacity(0.25),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      item.icon,
                      width: 28,
                      height: 28,
                      color: tWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: tBlue3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height:
                        57, // fontSize 12.5 * lineHeight 1.5 * 3 lines ≈ 56.25
                    child: Text(
                      item.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.manrope(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        color: tBlack.withOpacity(0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCtaBanner() {
    // final bool mobile = isMobile;

    final List<_CtaItem> items = [
      _CtaItem(icon: 'icons/collaboration.svg', label: 'Expert Engineers'),
      _CtaItem(icon: 'icons/tools.svg', label: 'Advanced Tools'),
      _CtaItem(icon: 'icons/quality.svg', label: 'Quality Focused'),
      _CtaItem(icon: 'icons/ontime.svg', label: 'On-Time Delivery'),
    ];

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : (isTablet ? 24 : 40),
      ),
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [tBlue4, tBlue5, tBlue6],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: tBlue3.withOpacity(0.12),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Center(
                    child: SizedBox(
                      width: constraints.maxWidth * 1.8,
                      height: constraints.maxHeight,
                      child: SvgPicture.asset(
                        'icons/waves_7.svg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding:
                isMobile
                    ? const EdgeInsets.symmetric(horizontal: 20, vertical: 22)
                    : const EdgeInsets.symmetric(horizontal: 35, vertical: 22),
            child: Flex(
              direction: _stackedCta ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment:
                  _stackedCta
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
              children: [
                // LEFT CONTENT
                _flexChild(
                  8,
                  _tabletTopRow(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Have an engineering challenge?',
                          style: GoogleFonts.manrope(
                            fontSize: isMobile ? 18 : 20,
                            fontWeight: FontWeight.w800,
                            color: tWhite,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "Let's build something extraordinary together.",
                          style: GoogleFonts.manrope(
                            fontSize: isMobile ? 12.5 : 13,
                            fontWeight: FontWeight.w400,
                            color: tWhite.withOpacity(0.82),
                          ),
                        ),

                        SizedBox(height: _stackedCta ? 0 : 16),

                        if (!_stackedCta) _ctaButton(),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 20, height: 20),

                // RIGHT CAPABILITIES
                _flexChild(4, _buildCtaCapabilities(items)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _flexChild(int flex, Widget child) =>
      _stackedCta ? child : Expanded(flex: flex, child: child);

  Widget _tabletTopRow(Widget textColumn) {
    // Desktop: just the text column (button lives inside it)
    if (!_stackedCta) return textColumn;

    // Mobile: text, then a full-width button underneath
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textColumn,
          const SizedBox(height: 16),
          SizedBox(width: double.infinity, child: _ctaButton()),
        ],
      );
    }

    // Tablet (unchanged): text on the left, button on the right
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: textColumn),
        const SizedBox(width: 16),
        _ctaButton(),
      ],
    );
  }

  Widget _ctaButton() {
    return ElevatedButton(
      onPressed: () => showGetInTouchDialog(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: tOrange1,
        foregroundColor: tWhite,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        elevation: 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Talk to Our Experts',
            style: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_rounded, size: 15),
        ],
      ),
    );
  }

  Widget _buildCtaCapabilities(List<_CtaItem> items) {
    const colors = [tBlue3, tOrange1, tBlue3, tBlue2];

    // Mobile: 2 x 2 grid of square cards that fill the banner width
    if (isMobile) {
      return LayoutBuilder(
        builder: (context, constraints) {
          const double gap = 12;
          final double size = ((constraints.maxWidth - gap) / 2)
              .floorToDouble()
              .clamp(90.0, 150.0);

          return Wrap(
            alignment: WrapAlignment.center,
            spacing: gap,
            runSpacing: gap,
            children: [
              for (int i = 0; i < items.length && i < 4; i++)
                _buildCtaCard(items[i], background: colors[i], size: size),
            ],
          );
        },
      );
    }

    if (isTablet) {
      return Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          for (int i = 0; i < items.length && i < 4; i++)
            _buildCtaCard(items[i], background: colors[i]),
        ],
      );
    }
    return SizedBox(
      height: 135,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              // CARD 1
              Positioned(
                left: 5,
                top: 15,
                child: Transform.rotate(
                  angle: -0.10,
                  child: _buildCtaCard(items[0], background: tBlue3),
                ),
              ),

              // CARD 2
              Positioned(
                left: 118,
                top: 4,
                child: Transform.rotate(
                  angle: 0.035,
                  child: _buildCtaCard(items[1], background: tOrange1),
                ),
              ),

              // CARD 3
              Positioned(
                left: 341,
                top: 10,
                child: Transform.rotate(
                  angle: -0.035,
                  child: _buildCtaCard(items[2], background: tBlue3),
                ),
              ),

              // CARD 4
              Positioned(
                left: 226,
                top: 0,
                child: Transform.rotate(
                  angle: 0.09,
                  child: _buildCtaCard(items[3], background: tBlue2),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCtaCard(
    _CtaItem item, {
    required Color background,
    double size = 130,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: tWhite.withValues(alpha: 0.45), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: tBlack.withValues(alpha: 0.20),
            blurRadius: 12,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Stack(
        children: [
          // SVG ICON
          Center(
            child: Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: tWhite.withValues(alpha: 0.10),
                border: Border.all(
                  color: tWhite.withValues(alpha: 0.22),
                  width: 1,
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  item.icon,
                  width: 29,
                  height: 29,
                  color: tWhite,
                ),
              ),
            ),
          ),
          Positioned(
            left: 5,
            right: 5,
            bottom: 10,
            child: _buildCtaLabel(item.label),
          ),
        ],
      ),
    );
  }

  Widget _buildCtaLabel(String label) {
    return Text(
      label,
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.manrope(
        fontSize: 9.5,
        fontWeight: FontWeight.w700,
        color: tWhite,
        height: 1.2,
      ),
    );
  }
}

class _ServiceItem {
  final String icon;
  final Gradient iconBg;
  final String image;
  final String title;
  final String description;

  _ServiceItem({
    required this.icon,
    required this.iconBg,
    required this.image,
    required this.title,
    required this.description,
  });
}

class _CtaItem {
  final String icon;
  final String label;

  _CtaItem({required this.icon, required this.label});
}

class _HoverCard extends StatefulWidget {
  final Widget child;

  const _HoverCard({required this.child});

  @override
  State<_HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<_HoverCard> {
  bool _hovering = false;

  // No hover effect on tablet / mobile layouts
  bool get _isTouch =>
      ResponsiveLayout.isMobile(context) || ResponsiveLayout.isTablet(context);

  @override
  Widget build(BuildContext context) {
    // Even if a stray onEnter fires (mobile browsers emit synthetic mouse
    // events on tap), the effect is only ever shown on desktop.
    final bool active = _hovering && !_isTouch;

    return MouseRegion(
      cursor: _isTouch ? MouseCursor.defer : SystemMouseCursors.click,
      onEnter: (_) {
        if (!_isTouch) setState(() => _hovering = true);
      },
      onExit: (_) {
        if (!_isTouch) setState(() => _hovering = false);
      },
      child: AnimatedScale(
        scale: active ? 1.04 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: tWhite,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: tBlack.withOpacity(active ? 0.18 : 0.06),
                blurRadius: active ? 28 : 16,
                offset: Offset(0, active ? 16 : 6),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: widget.child,
        ),
      ),
    );
  }
}
