import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';
import '../widgets/footer_section.dart';

class IndustriesSection extends StatelessWidget {
  const IndustriesSection({super.key});

  static const String _heroImage = 'assets/images/company.jpg';

  // INDUSTRIES
  static const List<_IndustryData> _industries = [
    _IndustryData(
      icon: Icons.directions_car_filled_outlined,
      title: 'Automotive',
      image: 'assets/images/automotive.jpg',
      tag: 'CONNECTED MOBILITY',
      description:
          'Connected vehicle electronics, telematics and intelligent systems that make mobility safer, smarter and more efficient.',
      accent: tBlue3,
    ),
    _IndustryData(
      icon: Icons.electric_car_outlined,
      title: 'Electric Mobility',
      image: 'assets/images/electric_mobility.jpg',
      tag: 'EV TECHNOLOGY',
      description:
          'Technology for the EV ecosystem including battery intelligence, vehicle connectivity, monitoring and energy-aware systems.',
      accent: tOrange1,
    ),
    _IndustryData(
      icon: Icons.local_shipping_outlined,
      title: 'Fleet & Logistics',
      image: 'assets/images/fleet_logistics.jpg',
      tag: 'FLEET INTELLIGENCE',
      description:
          'Real-time visibility, vehicle health, route intelligence and operational insights for modern transport and logistics fleets.',
      accent: tBlue3,
    ),
    _IndustryData(
      icon: Icons.factory_outlined,
      title: 'Industrial',
      image: 'assets/images/industrial.jpg',
      tag: 'SMART OPERATIONS',
      description:
          'Connected industrial solutions that improve equipment visibility, process efficiency, predictive insights and uptime.',
      accent: tOrange1,
    ),
    _IndustryData(
      icon: Icons.location_city_outlined,
      title: 'Smart Cities',
      image: 'assets/images/smartcity.jpg',
      tag: 'URBAN CONNECTIVITY',
      description:
          'IoT-driven infrastructure solutions designed to improve mobility, monitoring, resource utilisation and urban services.',
      accent: tBlue3,
    ),
    _IndustryData(
      icon: Icons.agriculture_outlined,
      title: 'Agriculture',
      image: 'assets/images/agriculture.jpg',
      tag: 'SMART FARMING',
      description:
          'Connected sensing and monitoring solutions that help agricultural operations make better decisions with real-time data.',
      accent: tOrange1,
    ),
    _IndustryData(
      icon: Icons.health_and_safety_outlined,
      title: 'Healthcare',
      image: 'assets/images/healthcare.png',
      tag: 'CONNECTED CARE',
      description:
          'Reliable connected-device technologies for monitoring, asset visibility and smarter healthcare operations.',
      accent: tBlue3,
    ),
    _IndustryData(
      icon: Icons.inventory_2_outlined,
      title: 'Supply Chain',
      image: 'assets/images/supplychain.png',
      tag: 'ASSET VISIBILITY',
      description:
          'Track critical assets and shipments with connected technology that brings transparency across the supply chain.',
      accent: tOrange1,
    ),
    _IndustryData(
      icon: Icons.storefront_outlined,
      title: 'Retail',
      image: 'assets/images/retail1.png',
      tag: 'SMART RETAIL',
      description:
          'Technology that helps retailers connect assets, monitor operations and create more responsive customer experiences.',
      accent: tBlue3,
    ),
    _IndustryData(
      icon: Icons.bolt_outlined,
      title: 'Energy',
      image: 'assets/images/energy.png',
      tag: 'ENERGY INTELLIGENCE',
      description:
          'Connected monitoring and management solutions supporting efficient, reliable and data-driven energy operations.',
      accent: tOrange1,
    ),
  ];

  // VALUE ITEMS
  static const List<_ValueItemData> _values = [
    _ValueItemData(
      icon: Icons.architecture_outlined,
      title: 'Built Around Your Industry',
      description:
          'Solutions are shaped around real operational requirements instead of one-size-fits-all technology.',
    ),
    _ValueItemData(
      icon: Icons.hub_outlined,
      title: 'Hardware + Software',
      description:
          'A connected approach across embedded electronics, firmware, cloud platforms and applications.',
    ),
    _ValueItemData(
      icon: Icons.insights_outlined,
      title: 'Data That Drives Decisions',
      description:
          'Turn connected-device data into useful visibility, insights and measurable operational improvements.',
    ),
    _ValueItemData(
      icon: Icons.security_outlined,
      title: 'Reliable by Design',
      description:
          'Engineered for dependable operation, security, maintainability and long-term deployment.',
    ),
    _ValueItemData(
      icon: Icons.trending_up_outlined,
      title: 'Ready to Scale',
      description:
          'Architecture that can grow with more devices, users, locations, data and business requirements.',
    ),
    _ValueItemData(
      icon: Icons.support_agent_outlined,
      title: 'Long-Term Partnership',
      description:
          'Support throughout design, deployment, optimisation and the next stage of your connected journey.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeroSection(),
          const SizedBox(height: 72),
          _buildIndustriesSection(),
          const SizedBox(height: 72),
          _buildValueSection(),
          const SizedBox(height: 55),
          FooterSection(),
        ],
      ),
    );
  }

  // =========================================================
  // HERO SECTION
  // =========================================================

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tBlue2, tBlue3],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 47,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 46,
                right: 28,
                top: 34,
                bottom: 28,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'INDUSTRIES WE EMPOWER',
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: tOrange1,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 14),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.manrope(
                        fontSize: 44,
                        fontWeight: FontWeight.w600,
                        height: 1.13,
                        color: tWhite,
                      ),
                      children: [
                        const TextSpan(text: 'Technology Solutions\n'),
                        TextSpan(
                          text: 'for a Better Tomorrow',
                          style: TextStyle(
                            color: tOrange1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 455,
                    child: Text(
                      'We deliver innovative, reliable and scalable solutions across diverse industries, driving efficiency, safety and sustainable growth.',
                      style: GoogleFonts.manrope(
                        fontSize: 13,
                        height: 1.55,
                        fontWeight: FontWeight.w400,
                        color: tWhite.withOpacity(0.82),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: _buildHeroFeature(
                          Icons.workspace_premium_outlined,
                          'Industry',
                          'Expertise',
                        ),
                      ),
                      Expanded(
                        child: _buildHeroFeature(
                          Icons.settings_suggest_outlined,
                          'Tailored',
                          'Solutions',
                        ),
                      ),
                      Expanded(
                        child: _buildHeroFeature(
                          Icons.auto_graph_outlined,
                          'Improved',
                          'Efficiency',
                        ),
                      ),
                      Expanded(
                        child: _buildHeroFeature(
                          Icons.verified_user_outlined,
                          'Sustainable',
                          'Impact',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(flex: 53, child: _buildHeroVisual()),
        ],
      ),
    );
  }

  Widget _buildHeroFeature(IconData icon, String title, String subtitle) {
    return SizedBox(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: tOrange1, size: 40),
          const SizedBox(height: 10),
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: tWhite,
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.manrope(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: tWhite.withOpacity(0.88),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroVisual() {
    return ClipRect(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            _heroImage,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: tBlue3,
                alignment: Alignment.center,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  size: 55,
                  color: tWhite.withOpacity(0.45),
                ),
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  tBlue3.withOpacity(0.92),
                  tBlue3.withOpacity(0.35),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.28, 0.62],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroNode(IconData icon) {
    return Container(
      width: 39,
      height: 39,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: tBlue3.withOpacity(0.72),
        border: Border.all(color: tWhite.withOpacity(0.38), width: 1),
        boxShadow: [BoxShadow(color: tBlue3.withOpacity(0.35), blurRadius: 12)],
      ),
      child: Icon(icon, size: 19, color: tWhite.withOpacity(0.9)),
    );
  }

  // =========================================================
  // INDUSTRIES SECTION
  // =========================================================

  Widget _buildIndustriesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 46),
      child: Column(
        children: [
          _sectionEyebrow('INDUSTRIES WE SERVE'),
          const SizedBox(height: 4),
          Text(
            'Solutions shaped for real-world industries',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: tBlue2,
            ),
          ),
          const SizedBox(height: 11),
          SizedBox(
            width: 720,
            child: Text(
              'Our technology adapts to the needs of different industries while keeping one thing constant — practical, reliable and connected solutions.',
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 12.5,
                height: 1.55,
                fontWeight: FontWeight.w500,
                color: tBlack.withOpacity(0.58),
              ),
            ),
          ),
          const SizedBox(height: 32),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildIndustryCard(_industries[0], 0)),
              const SizedBox(width: 18),
              Expanded(child: _buildIndustryCard(_industries[1], 1)),
              const SizedBox(width: 18),
              Expanded(child: _buildIndustryCard(_industries[2], 2)),
              const SizedBox(width: 18),
              Expanded(child: _buildIndustryCard(_industries[3], 3)),
              const SizedBox(width: 18),
              Expanded(child: _buildIndustryCard(_industries[4], 4)),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildIndustryCard(_industries[5], 5)),
              const SizedBox(width: 18),
              Expanded(child: _buildIndustryCard(_industries[6], 6)),
              const SizedBox(width: 18),
              Expanded(child: _buildIndustryCard(_industries[7], 7)),
              const SizedBox(width: 18),
              Expanded(child: _buildIndustryCard(_industries[8], 8)),
              const SizedBox(width: 18),
              Expanded(child: _buildIndustryCard(_industries[9], 9)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIndustryCard(_IndustryData data, int index) {
    return _IndustryHoverCard(data: data, index: index);
  }

  // =========================================================
  // VALUE SECTION
  // =========================================================

  Widget _buildValueSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 46),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [tBlue2, tBlue3],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.fromLTRB(40, 42, 40, 44),
        child: Column(
          children: [
            _sectionEyebrow('WHY CHOOSE US', light: true),
            const SizedBox(height: 11),
            Text(
              'One technology partner. Many possibilities.',
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: tWhite,
              ),
            ),
            const SizedBox(height: 11),
            SizedBox(
              width: 680,
              child: Text(
                'We bring together industry understanding and engineering depth to help organisations move from an idea to a dependable connected solution.',
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  height: 1.55,
                  fontWeight: FontWeight.w500,
                  color: tWhite.withOpacity(0.72),
                ),
              ),
            ),
            const SizedBox(height: 35),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildValueItem(_values[0])),
                const SizedBox(width: 30),
                Expanded(child: _buildValueItem(_values[1])),
                const SizedBox(width: 30),
                Expanded(child: _buildValueItem(_values[2])),
              ],
            ),

            const SizedBox(height: 30),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildValueItem(_values[3])),
                const SizedBox(width: 30),
                Expanded(child: _buildValueItem(_values[4])),
                const SizedBox(width: 30),
                Expanded(child: _buildValueItem(_values[5])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValueItem(_ValueItemData item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: tOrange1,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: tBlack.withOpacity(0.12), blurRadius: 10),
            ],
          ),
          child: Icon(item.icon, color: tWhite, size: 22),
        ),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: GoogleFonts.manrope(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: tWhite,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                item.description,
                style: GoogleFonts.manrope(
                  fontSize: 10.5,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                  color: tWhite.withOpacity(0.68),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =========================================================
  // COMMON
  // =========================================================

  Widget _sectionEyebrow(String text, {bool light = false}) {
    return Text(
      text,
      style: GoogleFonts.manrope(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        color: tOrange1,
        letterSpacing: 1.15,
      ),
    );
  }
}

// =========================================================
// INDUSTRY CARD
// =========================================================

class _IndustryHoverCard extends StatefulWidget {
  final _IndustryData data;
  final int index;

  const _IndustryHoverCard({required this.data, required this.index});

  @override
  State<_IndustryHoverCard> createState() => _IndustryHoverCardState();
}

class _IndustryHoverCardState extends State<_IndustryHoverCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    final bool isOddCard = widget.index.isEven;

    // Each card keeps its own original color.
    // NO color swapping on hover.
    final Color topColor = isOddCard ? tBlue3 : tOrange1;

    return MouseRegion(
      cursor: SystemMouseCursors.click,

      onEnter: (_) {
        setState(() {
          _hovered = true;
        });
      },

      onExit: (_) {
        setState(() {
          _hovered = false;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),

        curve: Curves.easeOut,

        transform: Matrix4.translationValues(0, _hovered ? -5 : 0, 0),

        decoration: BoxDecoration(
          color: tWhite,

          borderRadius: BorderRadius.circular(16),

          border: Border.all(
            color:
                _hovered
                    ? tOrange1.withOpacity(0.75)
                    : tBlack1.withOpacity(0.08),
            width: _hovered ? 1.2 : 1,
          ),

          boxShadow: [
            BoxShadow(
              color:
                  _hovered
                      ? tBlue3.withOpacity(0.14)
                      : tBlack.withOpacity(0.055),
              blurRadius: _hovered ? 20 : 12,
              offset: Offset(0, _hovered ? 9 : 4),
            ),
          ],
        ),

        clipBehavior: Clip.antiAlias,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // =================================================
            // IMAGE
            // =================================================
            SizedBox(
              width: double.infinity,
              height: 175,

              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    data.image,
                    fit: BoxFit.cover,

                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: tBlue3.withOpacity(0.08),

                        alignment: Alignment.center,

                        child: Icon(
                          data.icon,
                          size: 42,
                          color: tBlue3.withOpacity(0.55),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // =================================================
            // INFORMATION
            // =================================================
            Stack(
              clipBehavior: Clip.none,

              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(17, 34, 17, 18),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.tag,
                        style: GoogleFonts.manrope(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w800,
                          color: tOrange1,
                          letterSpacing: 0.9,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        data.title,
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: tBlack,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        data.description,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.manrope(
                          fontSize: 10.5,
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                          color: tBlack.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),

                // =================================================
                // ICON
                //
                // NORMAL:
                //   Background = same original color at 60%
                //   Icon       = 60%
                //
                // HOVER:
                //   Background = same original color at 100%
                //   Icon       = 100%
                //
                // NO COLOR SWAPPING
                // =================================================
                Positioned(
                  top: -25,
                  left: 17,

                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),

                    curve: Curves.easeOut,

                    width: 50,
                    height: 50,

                    decoration: BoxDecoration(
                      // Same color in both states.
                      //
                      // Only opacity changes.
                      color: topColor.withOpacity(_hovered ? 1.0 : 0.80),

                      borderRadius: BorderRadius.circular(13),

                      boxShadow: [
                        BoxShadow(
                          color: tBlack.withOpacity(_hovered ? 0.16 : 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),

                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 180),

                      curve: Curves.easeOut,

                      // Icon opacity:
                      // Normal = 60%
                      // Hover  = 100%
                      opacity: _hovered ? 1.0 : 0.60,

                      child: Icon(data.icon, color: tWhite, size: 25),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================
// DATA MODELS
// =========================================================

class _IndustryData {
  final IconData icon;
  final String title;
  final String tag;
  final String description;
  final Color accent;
  final String image;

  const _IndustryData({
    required this.icon,
    required this.title,
    required this.tag,
    required this.description,
    required this.accent,
    required this.image,
  });
}

class _ValueItemData {
  final IconData icon;
  final String title;
  final String description;

  const _ValueItemData({
    required this.icon,
    required this.title,
    required this.description,
  });
}
