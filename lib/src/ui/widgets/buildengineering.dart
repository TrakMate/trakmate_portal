import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/utils/colors.dart';

class BuildEngineeringSection extends StatelessWidget {
  const BuildEngineeringSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildServicesSection(),
        const SizedBox(height: 40),
        _buildProcessSection(),
        const SizedBox(height: 30),
        _buildCtaBanner(),
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
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
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

  Widget _buildProcessSection() {
    final List<_ProcessStep> steps = [
      _ProcessStep(
        number: '01',
        icon: 'icons/analysis1.svg',
        title: 'Concept & Analysis',
        description: 'Understanding requirements and feasibility analysis.',
      ),
      _ProcessStep(
        number: '02',
        icon: 'icons/design.svg',
        title: 'Design & Development',
        description: 'CAD, schematic & system design and development.',
      ),
      _ProcessStep(
        number: '03',
        icon: 'icons/electronics_design.svg',
        title: 'Prototyping',
        description: 'Build prototypes and validate design.',
      ),
      _ProcessStep(
        number: '04',
        icon: 'icons/validation.svg',
        title: 'Testing & Validation',
        description: 'Rigorous testing to ensure quality and performance.',
      ),
      _ProcessStep(
        number: '05',
        icon: 'icons/production.svg',
        title: 'Production Handoff',
        description: 'Smooth transition to manufacturing for mass production.',
      ),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tBlue2, tBlue3],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 35),
      child: Column(
        children: [
          Text(
            'OUR ENGINEERING PROCESS',
            style: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: tOrange1,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'From Concept to Creation',
            style: GoogleFonts.manrope(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: tWhite,
            ),
          ),
          const SizedBox(height: 35),

          LayoutBuilder(
            builder: (context, constraints) {
              final columnWidth = constraints.maxWidth / steps.length;
              final inset = columnWidth / 2;
              return Stack(
                children: [
                  // dashed line runs from the center of the first circle
                  // to the center of the last circle, passing through all of them
                  Positioned(
                    top: 28,
                    left: inset,
                    right: inset,
                    child: CustomPaint(
                      size: const Size(double.infinity, 1),
                      painter: _DashedLinePainter(
                        color: tWhite.withOpacity(0.3),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        steps
                            .map(
                              (step) =>
                                  Expanded(child: _buildProcessStep(step)),
                            )
                            .toList(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProcessStep(_ProcessStep step) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: tBlue3.withOpacity(0.9),
            border: Border.all(color: tBlue1.withOpacity(0.7), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: tOrange1.withOpacity(0.35),
                blurRadius: 14,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: SvgPicture.asset(
                step.icon,
                fit: BoxFit.contain,
                color: tOrange1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          step.number,
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: tOrange1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          step.title,
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: tWhite,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 130,
          child: Text(
            step.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 11.5,
              fontWeight: FontWeight.w400,
              height: 1.4,
              color: tWhite.withOpacity(0.58),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCtaBanner() {
    final List<_CtaItem> items = [
      _CtaItem(icon: 'icons/collaboration.svg', label: 'Expert Engineers'),
      _CtaItem(icon: 'icons/tools.svg', label: 'Advanced Tools'),
      _CtaItem(icon: 'icons/quality.svg', label: 'Quality Focused'),
      _CtaItem(icon: 'icons/ontime.svg', label: 'On-Time Delivery'),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tBlue3, tOrange1],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Have an engineering challenge?',
                  style: GoogleFonts.manrope(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: tWhite,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Let's build something extraordinary together.",
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: tWhite.withOpacity(0.85),
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
                      borderRadius: BorderRadius.circular(8),
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
                      const Icon(Icons.arrow_forward, size: 15),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < items.length; i++) ...[
                  if (i != 0) _buildCtaDivider(),
                  _buildCtaIconItem(items[i]),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCtaDivider() {
    return Container(width: 1, height: 34, color: tWhite.withOpacity(0.2));
  }

  Widget _buildCtaIconItem(_CtaItem item) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(item.icon, width: 34, height: 34, color: tWhite),
        const SizedBox(height: 8),
        Text(
          item.label,
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: tWhite,
          ),
        ),
      ],
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

class _ProcessStep {
  final String number;
  final String icon;
  final String title;
  final String description;

  _ProcessStep({
    required this.number,
    required this.icon,
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

class _DashedLinePainter extends CustomPainter {
  final Color color;

  _DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 1;

    const dashWidth = 4.0;
    const dashSpace = 4.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter oldDelegate) => false;
}
