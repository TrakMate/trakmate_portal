import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:trakmate_portal/src/ui/widgets/heroanimation.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmereffect.dart';

import '../../utils/colors.dart';
import '../widgets/footer_section.dart';

class IndustriesSection extends StatefulWidget {
  final bool isActive;
  const IndustriesSection({super.key, required this.isActive});

  @override
  State<IndustriesSection> createState() => _IndustriesSectionState();
}

class _IndustriesSectionState extends State<IndustriesSection> {
  // static const String _heroImage = 'images/company.jpg';
  bool _heroImageLoading = true; // NEW
  @override
  void initState() {
    super.initState(); // NEW
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadHeroImage();
    });
  }

  Future<void> _preloadHeroImage() async {
    try {
      await precacheImage(const AssetImage('images/sol3.jpg'), context);
      await Future.delayed(const Duration(seconds: 3)); //  testing only
    } catch (e) {
      debugPrint('Error preloading solutions hero image: $e');
    }

    if (!mounted) return;
    setState(() {
      _heroImageLoading = false;
    });
  }

  static const List<_IndustryData> _industries = [
    _IndustryData(
      icon: "icons/car.svg",
      title: 'Automotive',
      image: 'images/automotive.jpg',
      tag: 'CONNECTED MOBILITY',
      description:
          'Connected vehicle electronics, telematics and intelligent systems that make mobility safer, smarter and more efficient.',
      accent: tBlue3,
    ),

    _IndustryData(
      icon: "icons/ev.svg",
      title: 'Electric Mobility',
      image: 'images/electric_mobility.jpg',
      tag: 'EV TECHNOLOGY',
      description:
          'Technology for the EV ecosystem including battery intelligence, vehicle connectivity, monitoring and energy-aware systems.',
      accent: tOrange1,
    ),

    _IndustryData(
      icon: "icons/truck.svg",
      title: 'Fleet & Logistics',
      image: 'images/fleet_logistics.jpg',
      tag: 'FLEET INTELLIGENCE',
      description:
          'Real-time visibility, vehicle health, route intelligence and operational insights for modern transport and logistics fleets.',
      accent: tBlue3,
    ),

    _IndustryData(
      icon: "icons/automation.svg",
      title: 'Industrial',
      image: 'images/industrial.jpg',
      tag: 'SMART OPERATIONS',
      description:
          'Connected industrial solutions that improve equipment visibility, process efficiency, predictive insights and uptime.',
      accent: tOrange1,
    ),

    _IndustryData(
      icon: "icons/city.svg",
      title: 'Smart Cities',
      image: 'images/smartcity.jpg',
      tag: 'URBAN CONNECTIVITY',
      description:
          'IoT-driven infrastructure solutions designed to improve mobility, monitoring, resource utilisation and urban services.',
      accent: tBlue3,
    ),

    _IndustryData(
      icon: "icons/agriculture.svg",
      title: 'Agriculture',
      image: 'images/agriculture.jpg',
      tag: 'SMART FARMING',
      description:
          'Connected sensing and monitoring solutions that help agricultural operations make better decisions with real-time data.',
      accent: tOrange1,
    ),

    _IndustryData(
      icon: "icons/healthcare.svg",
      title: 'Healthcare',
      image: 'images/healthcare.png',
      tag: 'CONNECTED CARE',
      description:
          'Reliable connected-device technologies for monitoring, asset visibility and smarter healthcare operations.',
      accent: tBlue3,
    ),

    _IndustryData(
      icon: "icons/supplychain.svg",
      title: 'Supply Chain',
      image: 'images/supplychain.png',
      tag: 'ASSET VISIBILITY',
      description:
          'Track critical assets and shipments with connected technology that brings transparency across the supply chain.',
      accent: tOrange1,
    ),

    _IndustryData(
      icon: "icons/retail.svg",
      title: 'Retail',
      image: 'images/retail1.png',
      tag: 'SMART RETAIL',
      description:
          'Technology that helps retailers connect assets, monitor operations and create more responsive customer experiences.',
      accent: tBlue3,
    ),

    _IndustryData(
      icon: "icons/utilities.svg",
      title: 'Energy',
      image: 'images/energy.png',
      tag: 'ENERGY INTELLIGENCE',
      description:
          'Connected monitoring and management solutions supporting efficient, reliable and data-driven energy operations.',
      accent: tOrange1,
    ),
  ];

  static const List<_ValueItemData> _values = [
    _ValueItemData(
      icon: 'icons/build.svg',
      title: 'Built Around Your Industry',
      description:
          'Solutions are shaped around real operational requirements instead of one-size-fits-all technology.',
    ),

    _ValueItemData(
      icon: 'icons/software_solutions.svg',
      title: 'Hardware + Software',
      description:
          'A connected approach across embedded electronics, firmware, cloud platforms and applications.',
    ),

    _ValueItemData(
      icon: 'icons/decision.svg',
      title: 'Data That Drives Decisions',
      description:
          'Turn connected-device data into useful visibility, insights and measurable operational improvements.',
    ),

    _ValueItemData(
      icon: 'icons/design.svg',
      title: 'Reliable by Design',
      description:
          'Engineered for dependable operation, security, maintainability and long-term deployment.',
    ),

    _ValueItemData(
      icon: 'icons/build.svg',
      title: 'Ready to Scale',
      description:
          'Architecture that can grow with more devices, users, locations, data and business requirements.',
    ),

    _ValueItemData(
      icon: 'icons/build.svg',
      title: 'Long-Term Partnership',
      description:
          'Support throughout design, deployment, optimisation and the next stage of your connected journey.',
    ),
  ];

  // BUILD
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // _buildHeroSection(),
          _heroImageLoading
              ? const HeroHeaderShimmer() // NEW
              : _buildHeroSection(),

          const SizedBox(height: 30),

          _buildIndustriesSection(),

          const SizedBox(height: 45),

          _buildValueSection(),

          const SizedBox(height: 45),

          FooterSection(),
        ],
      ),
    );
  }

  // HERO SECTION

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: tBlue2),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeroAnimatedText(
                  isActive: widget.isActive,
                  delay: 20,
                  child: Text(
                    'INDUSTRIES WE EMPOWER',
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: tOrange1,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                HeroAnimatedText(
                  isActive: widget.isActive,
                  delay: 120,
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.manrope(
                        fontSize: 48,
                        fontWeight: FontWeight.w600,
                        height: 1.15,
                        color: tWhite,
                      ),
                      children: [
                        const TextSpan(text: 'Technology Solutions.\n'),
                        TextSpan(
                          text: 'for a Better Tomorrow',
                          style: const TextStyle(
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
                  delay: 320,
                  child: Text(
                    'We deliver innovative, reliable and scalable solutions across diverse industries, driving efficiency, safety and sustainable growth.',
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      color: tWhite,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeroAnimatedText(
                      isActive: widget.isActive,
                      delay: 520,
                      child: _buildHeroFeature(
                        icon: Icons.workspace_premium_outlined,
                        title: 'Industry Expertise',
                        description: 'Deep knowledge across industries',
                      ),
                    ),
                    HeroAnimatedText(
                      isActive: widget.isActive,
                      delay: 720,
                      child: _buildHeroFeature(
                        icon: Icons.settings_suggest_outlined,
                        title: 'Tailored Solutions',
                        description: 'Solutions built around your needs',
                      ),
                    ),

                    HeroAnimatedText(
                      isActive: widget.isActive,
                      delay: 920,
                      child: _buildHeroFeature(
                        icon: Icons.auto_graph_outlined,
                        title: 'Improved Efficiency',
                        description: 'Technology that drives better results',
                      ),
                    ),
                    HeroAnimatedText(
                      isActive: widget.isActive,
                      delay: 1120,
                      child: _buildHeroFeature(
                        icon: Icons.verified_user_outlined,
                        title: 'Sustainable Impact',
                        description:
                            'Built for long-term value and consiistency',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 40),

          Expanded(
            child: Container(
              height: 350,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/hero_industry.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(75),
                  bottomRight: Radius.circular(75),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // HERO FEATURE
  Widget _buildHeroFeature({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: tOrange1, size: 30),

          const SizedBox(height: 10),

          Text(
            title,
            style: GoogleFonts.manrope(
              color: tWhite,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              color: tWhite.withOpacity(0.7),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

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

          LayoutBuilder(
            builder: (context, constraints) {
              const int columns = 5;

              const double horizontalSpacing = 18;

              const double verticalSpacing = 18;

              const double cardHeight = 360;

              final double totalSpacing = horizontalSpacing * (columns - 1);

              final double cardWidth =
                  (constraints.maxWidth - totalSpacing) / columns;

              return Wrap(
                spacing: horizontalSpacing,
                runSpacing: verticalSpacing,
                children: List.generate(
                  _industries.length,
                  (index) => SizedBox(
                    width: cardWidth,
                    height: cardHeight,
                    child: _buildIndustryCard(_industries[index], index),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // INDUSTRY CARD

  Widget _buildIndustryCard(_IndustryData data, int index) {
    return _IndustryHoverCard(data: data, index: index);
  }

  // WHY CHOOSE US

  Widget _buildValueSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 46),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(35, 28, 35, 28),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [tBlue2, tBlue3],
          ),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          children: [
            // HEADER
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: tOrange1.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: tOrange1.withOpacity(0.25)),
                  ),
                  child: Text(
                    'WHY CHOOSE US',
                    style: GoogleFonts.manrope(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: tOrange1,
                      letterSpacing: 1,
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.manrope(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: tWhite,
                      ),
                      children: [
                        const TextSpan(text: 'One technology partner. '),
                        TextSpan(
                          text: 'Many possibilities.',
                          style: GoogleFonts.manrope(
                            color: tOrange1,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // COUNTER
                Row(
                  children: [
                    Text(
                      '06',
                      style: GoogleFonts.manrope(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: tOrange1,
                      ),
                    ),

                    const SizedBox(width: 6),

                    Text(
                      'CORE\nADVANTAGES',
                      style: GoogleFonts.manrope(
                        fontSize: 7,
                        height: 1.2,
                        fontWeight: FontWeight.w700,
                        color: tWhite.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8),

            // DESCRIPTION
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 125),
                child: Text(
                  'We bring together industry understanding and engineering depth to help organisations move from an idea to a dependable connected solution.',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
                    color: tWhite.withOpacity(0.55),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // TOP ROW
            Row(
              children: [
                Expanded(child: _buildCompactValue(_values[0])),

                const SizedBox(width: 12),

                Expanded(child: _buildCompactValue(_values[1])),

                const SizedBox(width: 12),

                Expanded(child: _buildCompactValue(_values[2])),
              ],
            ),

            const SizedBox(height: 12),

            // BOTTOM ROW
            Row(
              children: [
                Expanded(child: _buildCompactValue(_values[3])),

                const SizedBox(width: 12),

                Expanded(child: _buildCompactValue(_values[4])),

                const SizedBox(width: 12),

                Expanded(child: _buildCompactValue(_values[5])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // COMPACT VALUE ITEM

  Widget _buildCompactValue(_ValueItemData item) {
    return Container(
      height: 78,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: tWhite.withOpacity(0.055),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tWhite.withOpacity(0.08)),
      ),
      child: Row(
        children: [
          // SVG ICON
          Container(
            width: 45,
            height: 45,
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: tOrange1,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: tOrange1.withOpacity(0.18),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SvgPicture.asset(
              item.icon,
              width: 20,
              height: 20,
              color: tWhite,
            ),
          ),

          const SizedBox(width: 11),

          // TEXT
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: tWhite,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  item.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(
                    fontSize: 10,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                    color: tWhite.withOpacity(0.48),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 6),
          // INDICATOR
          Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: tOrange1,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  // COMMON
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

// INDUSTRY HOVER CARD

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

          // border: Border.all(
          //   color:
          //       _hovered
          //           ? tOrange1.withOpacity(0.75)
          //           : tBlack1.withOpacity(0.08),
          //   width: _hovered ? 1.2 : 1,
          // ),
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
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                _hovered
                    ? tOrange1.withOpacity(0.75)
                    : tBlack1.withOpacity(0.08),
            width: _hovered ? 1.2 : 1,
          ),
        ),

        clipBehavior: Clip.antiAlias,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                        child: SvgPicture.asset(
                          data.icon,
                          width: 22,
                          height: 22,
                          color: tBlue3.withOpacity(0.55),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // INFORMATION
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

                // INDUSTRY ICON
                Positioned(
                  top: -25,
                  left: 17,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOut,
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
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
                      opacity: _hovered ? 1.0 : 0.60,
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SvgPicture.asset(
                            data.icon,
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
          ],
        ),
      ),
    );
  }
}

// DATA MODELS

class _IndustryData {
  final String icon;
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
  final String icon;
  final String title;
  final String description;

  const _ValueItemData({
    required this.icon,
    required this.title,
    required this.description,
  });
}
