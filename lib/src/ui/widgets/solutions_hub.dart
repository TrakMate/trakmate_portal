import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';

import '../../utils/colors.dart';
import 'solutions_detail.dart';

class SolutionsHubPage extends StatelessWidget {
  const SolutionsHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final solutions = <SolutionDetailsData>[
      SolutionDetailsData(
        backgroundImage: 'images/mobileapps1.png',
        icon: 'icons/phone.svg',
        iconBackgroundColor: tOrange1,
        eyebrow: 'MOBILE APPLICATIONS',
        title: 'Mobile Apps',
        description:
            'Powerful and intuitive mobile applications designed to connect users, devices and businesses on the go.',
        cards: const [
          SolutionCardData(
            'images/mobileapps.jpg',
            'icons/phone.svg',
            'Mobile App Development',
            'Custom mobile applications designed for smooth, intuitive and reliable user experiences.',
          ),
          SolutionCardData(
            'images/mobileapps.jpg',
            'icons/globe.svg',
            'Cloud Integration',
            'Connect mobile applications with cloud platforms, APIs and real-time business data.',
          ),
          SolutionCardData(
            'images/mobileapps.jpg',
            'icons/iot.svg',
            'Device Connectivity',
            'Connect mobile applications with connected devices, vehicles and IoT ecosystems.',
          ),
          SolutionCardData(
            'images/mobileapps.jpg',
            'icons/globe.svg',
            'Data & Analytics',
            'Present meaningful business information through dashboards, reports and analytics.',
          ),
        ],
      ),
      SolutionDetailsData(
        backgroundImage: 'images/webapps1.png',
        icon: 'icons/laptop.svg',
        iconBackgroundColor: tBlue3,
        eyebrow: 'WEB APPLICATIONS',
        title: 'Web Apps',
        description:
            'Scalable and secure web applications that transform complex business processes into simple digital experiences.',
        cards: const [
          SolutionCardData(
            'images/trakfleet.png',
            'icons/laptop.svg',
            'TrakFleet',
            'Scalable web platforms built around your business workflows, users and operational requirements.',
          ),
          SolutionCardData(
            'images/trakfleet.png',
            'icons/globe.svg',
            'Trakblue',
            'Secure cloud-connected applications with centralized data and easy access from anywhere.',
          ),
          SolutionCardData(
            'images/trakfleet.png',
            'icons/iot.svg',
            'IoT Integration',
            'Connect web applications with devices, vehicles and real-time IoT data.',
          ),
          SolutionCardData(
            'images/trakfleet.png',
            'icons/globe.svg',
            'Dashboards & Analytics',
            'Transform business and device data into clear dashboards, reports and actionable insights.',
          ),
        ],
      ),
    ];

    return Container(
      width: double.infinity,
      color: tWhite,
      padding: const EdgeInsets.fromLTRB(40, 10, 40, 55),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 25,
            runSpacing: 25,
            children:
                solutions
                    .map(
                      (solution) => SizedBox(
                        width: 420,
                        child: _SolutionCard(
                          backgroundImage: solution.backgroundImage,
                          icon: solution.icon,
                          iconBackgroundColor: solution.iconBackgroundColor,
                          eyebrow: solution.eyebrow,
                          title: solution.title,
                          description: solution.description,
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) =>
                                          SolutionsDetailsPage(data: solution),
                                ),
                              ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}

class _SolutionCard extends StatefulWidget {
  final String backgroundImage, icon, eyebrow, title, description;
  final Color iconBackgroundColor;
  final VoidCallback onTap;

  const _SolutionCard({
    required this.backgroundImage,
    required this.icon,
    required this.iconBackgroundColor,
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  State<_SolutionCard> createState() => _SolutionCardState();
}

class _SolutionCardState extends State<_SolutionCard> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.identity()..translate(0.0, hovering ? -7.0 : 0.0),
          height: 420,
          decoration: BoxDecoration(
            color: tWhite,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: tBlack.withOpacity(hovering ? .14 : .10),
                blurRadius: hovering ? 24 : 20,
                offset: Offset(0, hovering ? 10 : 8),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: Image.asset(
                      widget.backgroundImage,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(color: tBlue3),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 45, 22, 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.eyebrow,
                          style: GoogleFonts.manrope(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: tOrange1,
                            letterSpacing: 1.1,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          widget.title,
                          style: GoogleFonts.manrope(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: tBlue3,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.manrope(
                            fontSize: 12.5,
                            color: tBlack.withOpacity(.6),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 225,
                left: 20,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: widget.iconBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    widget.icon,
                    width: 26,
                    height: 26,
                    color: tWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
