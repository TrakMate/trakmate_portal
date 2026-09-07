import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/widgets/process_section.dart';
import 'package:trakmate_portal/src/utils/colors.dart';

class BuildEngineeringSection extends StatelessWidget {
  const BuildEngineeringSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildServicesSection(),
        const SizedBox(height: 40),
        // _buildProcessSection(),
        _buildCtaBanner(),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
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
    final List<_ServiceItem> row1 = [
      _ServiceItem(
        icon: 'icons/cad.svg',
        iconBg: tBlueGradient5,
        image: 'images/cad.png',
        title: 'CAD Design',
        description:
            'High-quality 3D CAD modeling and drafting for components, assemblies and complex products.',
      ),
      _ServiceItem(
        icon: 'icons/product.svg',
        iconBg: tOrangeGradient2,
        image: 'images/product.png',
        title: 'Product Design',
        description:
            'Innovative product design that combines aesthetics, usability and functionality to create exceptional experiences.',
      ),
      _ServiceItem(
        icon: 'icons/mechanical.svg',
        iconBg: tBlueGradient5,
        image: 'images/mech.png',
        title: 'Mechanical Engineering',
        description:
            'Engineering analysis, simulation and mechanical design for reliable and high-performance products.',
      ),
      _ServiceItem(
        icon: 'icons/pcb.svg',
        iconBg: tOrangeGradient2,
        image: 'images/pcb.jpg',
        title: 'PCB Design',
        description:
            'Schematic capture, layout design and signal integrity analysis for robust and optimized PCB designs.',
      ),
    ];

    final List<_ServiceItem> row2 = [
      _ServiceItem(
        icon: 'icons/electronics_design.svg',
        iconBg: tBlueGradient5,
        image: 'images/pcba.jpg',
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
        image: 'images/prototype.png',
        title: 'Prototyping',
        description:
            'Fast and cost-effective prototyping to validate designs, test performance and accelerate time-to-market.',
      ),
    ];

    return Container(
      width: double.infinity,
      color: const Color(0xFFF6F8FB),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Column(
        children: [
          Text(
            'OUR ENGINEERING SERVICES',
            style: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: tOrange1,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Comprehensive Engineering Solutions',
            style: GoogleFonts.manrope(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: tBlue2,
            ),
          ),
          const SizedBox(height: 35),

          LayoutBuilder(
            builder: (context, constraints) {
              const cardSpacing = 20.0;
              final cardWidth = (constraints.maxWidth - (cardSpacing * 3)) / 4;

              return Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children:
                          row1
                              .map(
                                (item) => Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
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
                          row2
                              .map(
                                (item) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: SizedBox(
                                    width: cardWidth,
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Learn More',
                        style: GoogleFonts.manrope(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: tOrange1,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(Icons.arrow_forward, size: 15, color: tOrange1),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCtaBanner() {
    final List<_CtaItem> items = [
      _CtaItem(icon: 'icons/collaboration.svg', label: 'Expert Engineers'),
      _CtaItem(icon: 'icons/tools.svg', label: 'Advanced Tools'),
      _CtaItem(icon: 'icons/quality.svg', label: 'Quality Focused'),
      _CtaItem(icon: 'icons/ontime.svg', label: 'On-Time Delivery'),
      // _CtaItem(icon: 'icons/ontime.svg', label: 'On-Time Delivery'),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            // Color(0xFF0B2380),
            // Color.fromARGB(255, 6, 19, 62),
            // Color(0xFF2348AD),
            // Color.fromARGB(255, 6, 19, 62),
            // Color(0xFF2348AD),
            // Color(0xFF0B2380),
            // tBlue2,
            // tBlue3,
            Color(0xFF101B72),
            Color(0xFF263FA8),
            Color(0xFF3154B8),
          ],
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
      // padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 22),
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
                      // height: constraints.maxHeight * 0.6,
                      // child: RotatedBox(
                      // quarterTurns: 1,
                      child: SvgPicture.asset(
                        'icons/waves_7.svg',
                        fit: BoxFit.fill,
                        // colorFilter: ColorFilter.mode(
                        //   tWhite.withOpacity(0.3),
                        //   BlendMode.srcIn,
                        // ),
                      ),
                      // ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Positioned(
          //   left: 330,
          //   top: 5,
          //   child: IgnorePointer(
          //     child: SizedBox(
          //       width: 400,
          //       height: 125,
          //       child: FittedBox(
          //         fit: BoxFit.fill,
          //         child: SvgPicture.asset(
          //           'icons/map2.svg',
          //           width: 700,
          //           height: 165,
          //           color: tBlue1.withOpacity(0.2),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 22),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // LEFT CONTENT
                Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Have an engineering challenge?',
                        style: GoogleFonts.manrope(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: tWhite,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "Let's build something extraordinary together.",
                        style: GoogleFonts.manrope(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: tWhite.withOpacity(0.82),
                        ),
                      ),

                      const SizedBox(height: 16),

                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tOrange1,
                          foregroundColor: tWhite,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
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
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 20),

                // RIGHT CAPABILITIES
                Expanded(flex: 4, child: _buildCtaCapabilities(items)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildCtaDivider() {
  //   return Container(width: 1, height: 34, color: tWhite.withOpacity(0.2));
  // }
  Widget _buildCtaCapabilities(List<_CtaItem> items) {
    return SizedBox(
      height: 135,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // const double cardWidth = 88;
          // const double cardHeight = 102;

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
              //card 5
              // Positioned(
              //   left: 451,
              //   top: 0,
              //   child: Transform.rotate(
              //     angle: -0.15,
              //     child: _buildCtaCard(items[4], background: tOrange1),
              //   ),
              // ),

              // // LABEL 1
              // Positioned(
              //   left: 0,
              //   top: 108,
              //   width: 98,
              //   child: _buildCtaLabel(items[0].label),
              // ),

              // // LABEL 2
              // Positioned(
              //   left: 73,
              //   top: 108,
              //   width: 98,
              //   child: _buildCtaLabel(items[1].label),
              // ),

              // // LABEL 3
              // Positioned(
              //   left: 146,
              //   top: 108,
              //   width: 98,
              //   child: _buildCtaLabel(items[2].label),
              // ),

              // // LABEL 4
              // Positioned(
              //   left: 219,
              //   top: 108,
              //   width: 98,
              //   child: _buildCtaLabel(items[3].label),
              // ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCtaCard(_CtaItem item, {required Color background}) {
    return Container(
      width: 130,
      height: 130,
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
          // SUBTLE INNER SHAPE
          // Positioned(
          //   right: -20,
          //   bottom: -25,
          //   child: Container(
          //     width: 80,
          //     height: 80,
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: tWhite.withValues(alpha: 0.07),
          //     ),
          //   ),
          // ),

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

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: _hovering ? 1.04 : 1.0,
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
                color: tBlack.withOpacity(_hovering ? 0.18 : 0.06),
                blurRadius: _hovering ? 28 : 16,
                offset: Offset(0, _hovering ? 16 : 6),
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
