import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:trakmate_portal/src/ui/widgets/heroanimation.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmereffect.dart';
import '../../utils/colors.dart';
import '../widgets/footer_section.dart';

class AboutusSection extends StatefulWidget {
  final bool isActive;
  final void Function(int index)? onNavigate;
  const AboutusSection({super.key, required this.isActive, this.onNavigate});

  @override
  State<AboutusSection> createState() => _AboutusSectionState();
}

class _AboutusSectionState extends State<AboutusSection>
    with SingleTickerProviderStateMixin {
  bool _heroImageLoading = true; // NEW

  final ScrollController _certScrollController = ScrollController();
  late final Ticker _certTicker;

  // Duration _certLastElapsed = Duration.zero;
  // double _certScrollOffset = 0.0;

  // static const double _certItemWidth = 200.0;
  // static const double _certSeparatorWidth = 24.0;
  // static const double _certScrollSpeed = 40.0; //scroll speed
  // static const int _maxFrameDeltaMs = 100;

  final List<_CertData> _certs = const [
    _CertData(
      logo: 'icons/ais.svg',
      code: 'AIS 140',
      label: 'Vehicle Tracking & Telematics',
      logoHeight: 42,
      logoWidth: 42,
    ),
    _CertData(
      logo: 'icons/iso.svg',
      code: '9001:2015',
      label: 'Quality Management',
      logoHeight: 42,
      logoWidth: 42,
    ),
    _CertData(
      logo: 'icons/iso.svg',
      code: '14001:2015',
      label: 'Environmental Management',
      logoHeight: 42,
      logoWidth: 42,
    ),
    _CertData(
      logo: 'icons/iso.svg',
      code: '45001:2018',
      label: 'Occupational Health & Safety',
      logoHeight: 42,
      logoWidth: 42,
    ),
    _CertData(
      logo: 'icons/rohs.svg',
      code: 'ROHS',
      label: 'Vehicle Tracking & Telematics',
      logoHeight: 62,
      logoWidth: 62,
    ),
    _CertData(
      logo: 'icons/ce.svg',
      code: 'CE Certified',
      label: 'Ensures EU product compliance',
      logoHeight: 42,
      logoWidth: 42,
    ),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadHeroImage();
      // _startCertAutoScroll();
    });
  }

  Future<void> _preloadHeroImage() async {
    try {
      await precacheImage(const AssetImage('images/sol3.jpg'), context);
      // await Future.delayed(const Duration(seconds: 3)); //  testing only
    } catch (e) {
      debugPrint('Error preloading solutions hero image: $e');
    }

    if (!mounted) return;
    setState(() {
      _heroImageLoading = false;
    });
  }

  @override
  void dispose() {
    _certTicker.dispose();
    _certScrollController.dispose();

    super.dispose();
  }

  // void _startCertAutoScroll() {
  //   final singleSetWidth =
  //       _certs.length * (_certItemWidth + _certSeparatorWidth);

  //   _certTicker = createTicker((elapsed) {
  //     if (!_certScrollController.hasClients) return;

  //     final deltaMs = (elapsed - _certLastElapsed).inMilliseconds.clamp(
  //       0,
  //       _maxFrameDeltaMs,
  //     );

  //     _certLastElapsed = elapsed;

  //     _certScrollOffset += _certScrollSpeed * deltaMs / 1000;

  //     if (_certScrollOffset >= singleSetWidth) {
  //       _certScrollOffset -= singleSetWidth;
  //     }

  //     _certScrollController.jumpTo(_certScrollOffset);
  //   })..start();
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // _buildAboutUsHeader(),
          _heroImageLoading
              ? const HeroHeaderShimmer() // NEW
              : _buildAboutUsHeader(),
          SizedBox(height: 25),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: tBlue1.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: buildMissionVisionCard(
                      icon: 'icons/impact.svg',
                      title: 'Our Mission',
                      description:
                          'To deliver innovative and reliable engineering solutions that empower businesses and improve lives through technology and excellence.',
                    ),
                  ),

                  const SizedBox(height: 30),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    width: 3,
                    height: 100,
                    color: tOrange1,
                  ),
                  const SizedBox(height: 30),

                  Expanded(
                    child: buildMissionVisionCard(
                      icon: 'icons/vision.svg',
                      title: 'Our Vision',
                      description:
                          'To become a global leader in engineering innovation, driving sustainable growth and creating lasting value for our customers.',
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 25),

          SizedBox(height: 25),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: _infrastructureBrickLayout()),

                const SizedBox(width: 40),

                Expanded(flex: 3, child: _timeline()),
              ],
            ),
          ),

          SizedBox(height: 25),

          _ourTeamSection(),

          SizedBox(height: 25),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: _buildInfrastructureSection(),
          ),

          SizedBox(height: 35),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: _buildNewsMediaSection(),
          ),

          const SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [tBlue2, tBlue3],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: tOrange1, width: 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildAchievementsCard(
                    icon: 'icons/collaboration.svg',
                    title: '110+',
                    subtitle: 'Team Members',
                  ),
                  _divider(),
                  buildAchievementsCard(
                    icon: 'icons/badge.svg',
                    title: '12+',
                    subtitle: 'Years of excellence',
                  ),
                  _divider(),
                  buildAchievementsCard(
                    icon: 'icons/globe.svg',
                    title: '6+',
                    subtitle: 'Countries Served',
                  ),
                  _divider(),
                  buildAchievementsCard(
                    icon: 'icons/delivery.svg',
                    title: '750+',
                    subtitle: 'Products Delivered',
                  ),
                  _divider(),
                  buildAchievementsCard(
                    icon: 'icons/manufacture.svg',
                    title: '2L+',
                    subtitle: 'Units Manufactured',
                  ),
                  _divider(),
                  buildAchievementsCard(
                    icon: 'icons/handshake.svg',
                    title: '25+',
                    subtitle: 'Happy Clients',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: _buildCertificationsSection(),
          ),
          SizedBox(height: 40),
          FooterSection(onNavigate: widget.onNavigate),
        ],
      ),
    );
  }

  Widget _buildHeaderIntroCard({
    required String icon,
    required String title,
    required String description,
  }) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(icon, width: 30, height: 30, color: tOrange1),
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

  Widget _buildAboutUsHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tBlue2, tBlue3],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeroAnimatedText(
                  isActive: widget.isActive,
                  delay: 20,
                  child: Text(
                    'About TrakMate',
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: tOrange1,
                    ),
                  ),
                ),
                SizedBox(height: 20),
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
                        const TextSpan(text: "Engineering Innovation.\n"),
                        TextSpan(
                          text: "Building a Smarter Tomorrow.",
                          style: TextStyle(
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
                    'TrakMate is a product engineering and manufacturing company delivering end-to-end solutions in IoT, Embedded Systems, Software, Hardware Design and Manufacturing.',
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
                      child: _buildHeaderIntroCard(
                        icon: 'icons/innovation.svg',
                        title: 'Innovation',
                        description: 'At the core of everything we do',
                      ),
                    ),
                    HeroAnimatedText(
                      isActive: widget.isActive,
                      delay: 720,
                      child: _buildHeaderIntroCard(
                        icon: 'icons/integrity.svg',
                        title: 'Integrity',
                        description: 'We build trust through transparency',
                      ),
                    ),
                    HeroAnimatedText(
                      isActive: widget.isActive,
                      delay: 920,
                      child: _buildHeaderIntroCard(
                        icon: 'icons/collaboration.svg',
                        title: 'Collaboration',
                        description: 'Stronger together, better outcomes',
                      ),
                    ),
                    HeroAnimatedText(
                      isActive: widget.isActive,
                      delay: 1120,
                      child: _buildHeaderIntroCard(
                        icon: 'icons/impact.svg',
                        title: 'Impact',
                        description: 'Technology that makes a difference',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 40),
          Expanded(
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/company.png"),
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

  Widget buildMissionVisionCard({
    required String icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: const BoxDecoration(
            color: tBlue3,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(icon, width: 35, height: 35, color: tWhite),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.manrope(
                  color: tBlue3,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: GoogleFonts.manrope(
                  color: tBlue3,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildAchievementsCard({
    required String icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(icon, width: 40, height: 40, color: tOrange1),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.manrope(
                color: tWhite,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.manrope(
                color: tWhite,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      width: 2,
      height: 65,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            tWhite.withOpacity(0.0),
            tWhite.withOpacity(0.25),
            tOrange1,
            tWhite.withOpacity(0.25),
            tWhite.withOpacity(0.0),
          ],
          stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
        ),
      ),
    );
  }

  Widget _storyContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Our Story",
          style: GoogleFonts.manrope(
            color: tBlue,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          "Built on Passion.\nDriven by Purpose.",
          style: GoogleFonts.manrope(
            color: tBlack,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),

        const SizedBox(height: 10),
        Container(
          width: 75,
          height: 2,
          decoration: BoxDecoration(color: tOrange1),
        ),

        const SizedBox(height: 20),

        Text(
          "TrakMate was founded with a simple idea – use technology to solve real-world problems and create meaningful connections. What started as a small team of engineers and dreamers has grown into a technology partner for businesses across the globe.",
          style: GoogleFonts.manrope(
            fontSize: 12,
            color: tBlack,
            height: 1.35,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          "From building intelligent IoT devices to developing robust embedded systems and scalable software platforms, our journey is fueled by innovation, trust, and a relentless focus on our customers.",
          style: GoogleFonts.manrope(
            fontSize: 12,
            color: tBlack,
            height: 1.35,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _storyImage() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/workspace.jpg"),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(75),
          bottomRight: Radius.circular(75),
        ),
      ),
    );
  }

  Widget _timeline() {
    return Column(
      children: [
        _timelineItem(
          "2013",
          "The Beginning",
          "TrakMate was founded with a vision to innovate",
          false,
        ),

        _timelineItem(
          "2016",
          "Expanding Solutions",
          "Launched IoT products and embedded solutions",
          false,
        ),

        _timelineItem(
          "2019",
          "Global Growth",
          "Expanded into international markets and built strong partnerships",
          false,
        ),

        _timelineItem(
          "Today",
          "Shaping the Future",
          "Continuously innovating to build a smarter, connected world",
          false,
        ),
      ],
    );
  }

  Widget _timelineItem(
    String year,
    String title,
    String description,
    bool first,
  ) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: tTransparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: tBlue, width: 1),
                ),
                child: Center(
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: tBlue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),

              if (!first)
                Expanded(
                  child: Container(
                    width: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          tTransparent,
                          tBlue.withOpacity(0.4),
                          tBlue,
                          tBlue.withOpacity(0.4),
                          tTransparent,
                        ],
                        stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    year,
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      color: tBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    title,
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      color: tBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    description,
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      color: tBlack,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infrastructureBrickLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'OUR STORY',
          style: GoogleFonts.manrope(
            color: tOrange1,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          'Built for Engineering. Designed for Scale.',
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            color: tBlue2,
            fontSize: 25,
            fontWeight: FontWeight.w700,
            height: 1.05,
          ),
        ),

        const SizedBox(height: 18),

        Row(
          children: [
            Expanded(
              child: _buildInfrastructureBrick(
                icon: 'icons/innovation.svg',
                title: 'Foundation & Vision',
                description: 'Where our journey began.',
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _buildInfrastructureBrick(
                icon: 'icons/impact.svg',
                title: 'Innovation & Expansion',
                description: 'Growing our capabilities through new ideas.',
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        FractionallySizedBox(
          widthFactor: 0.78,
          child: _buildInfrastructureBrick(
            icon: 'icons/collaboration.svg',
            title: 'Connected Growth',
            description: 'Building stronger solutions and partnerships.',
          ),
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: _buildInfrastructureBrick(
                icon: 'icons/globe.svg',
                title: 'Global Reach',
                description: 'Expanding our presence across new markets.',
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _buildInfrastructureBrick(
                icon: 'icons/manufacture.svg',
                title: 'Future & Evolution',
                description: 'Continuously shaping what comes next.',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfrastructureBrick({
    required String icon,
    required String title,
    required String description,
  }) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tBlue2.withOpacity(0.92), tBlue2.withOpacity(0.72)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tWhite.withOpacity(0.22), width: 1),
        boxShadow: [
          BoxShadow(
            color: tBlue2.withOpacity(0.18),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // LEFT ICON (unchanged)
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: tWhite.withOpacity(0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: SvgPicture.asset(
                icon,
                width: 33,
                height: 33,
                color: tOrange1,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // TEXT
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(
                    color: tWhite,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(
                    color: tWhite.withOpacity(0.70),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // RIGHT ICON: same icon, light blue, big, no background
          SvgPicture.asset(
            icon,
            width: 60,
            height: 56,
            fit: BoxFit.contain,
            color: const Color(0xFF8DB8FF).withOpacity(0.3), // light blue
          ),
        ],
      ),
    );
  }

  Widget _ourTeamSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Meet Our Leadership",
                  style: GoogleFonts.manrope(
                    color: tBlack,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 75,
                  height: 2,
                  decoration: BoxDecoration(color: tOrange1),
                ),
                const SizedBox(height: 20),
                Text(
                  "Our diverse team of engineers, designers, developers and industry experts work together to deliver exceptional solutions and exceed expectations.",
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    color: tBlack,
                    height: 1.35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),

          const SizedBox(width: 80),

          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: buildTeamProfileCard(
                    image: "images/img2.jpg",
                    name: "NL Srinivas",
                    designation: "Co-Founder & CEO",
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: buildTeamProfileCard(
                    image: "images/img1.jpg",
                    name: "M Pramod",
                    designation: "Co-Founder & COO",
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: buildTeamProfileCard(
                    image: "images/img2.jpg",
                    name: "S Srinivasa",
                    designation: "Co-Founder & CTO",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTeamProfileCard({
    required String image,
    required String name,
    required String designation,
  }) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tBlue1.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: tBlack.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 150,
              width: double.infinity,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: tBlack,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    designation,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: tOrange1,
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

  Widget _buildNewsMediaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'NEWS & MEDIA',
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: tOrange1,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.manrope(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: tBlue2,
                      ),
                      children: [
                        const TextSpan(text: 'Stay Connected '),
                        TextSpan(
                          text: 'With TrakMate',
                          style: TextStyle(color: tBlue2),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 10),
                  // Container(width: 60, height: 3, color: tOrange1),
                  const SizedBox(height: 6),
                  Text(
                    'The latest updates, milestones and stories from our engineering journey.',
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      color: tBlack.withOpacity(0.75),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 25),
            // Row(
            //   children: [
            //     _buildNewsFilter('All', active: true),
            //     const SizedBox(width: 10),
            //     _buildNewsFilter('Company News'),
            //     const SizedBox(width: 10),
            //     _buildNewsFilter('Products'),
            //     const SizedBox(width: 10),
            //     _buildNewsFilter('Engineering'),
            //     const SizedBox(width: 10),
            //     _buildNewsFilter('Events'),
            //   ],
            // ),
          ],
        ),
        const SizedBox(height: 25),
        SizedBox(
          width: double.infinity,
          height: 330,
          child: Container(
            decoration: BoxDecoration(
              color: tBlue1.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 11,
                  child: Image.asset('images/company.png', fit: BoxFit.cover),
                ),
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35, 25, 35, 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: tWhite,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: tOrange1.withOpacity(0.65),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  color: tOrange1,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 7),
                              Text(
                                'LATEST',
                                style: GoogleFonts.manrope(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: tOrange1,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            Text(
                              'Company News',
                              style: GoogleFonts.manrope(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: tBlue,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 1,
                              height: 14,
                              color: tBlue3.withOpacity(0.25),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '25 Sep 2026',
                              style: GoogleFonts.manrope(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: tBlue3.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'TrakMate Expands Its Engineering\nCapabilities with New Innovation Center',
                          style: GoogleFonts.manrope(
                            fontSize: 24,
                            height: 1.15,
                            fontWeight: FontWeight.w800,
                            color: tBlack,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'We are excited to announce the expansion of our engineering capabilities with a new state-of-the-art innovation center, strengthening our commitment to build smarter, connected products for a better tomorrow.',
                          style: GoogleFonts.manrope(
                            fontSize: 12,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            color: tBlue3.withOpacity(0.65),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildNewsOrangeButton('Read Story'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 25),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildNewsCard(
                category: 'Engineering',
                date: '18 Sep 2026',
                title: 'Advancing Embedded\nSystems for a Smarter Future',
                description:
                    'Exploring next-generation embedded solutions for connected mobility and IoT.',
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildNewsCard(
                category: 'Products',
                date: '12 Sep 2026',
                title: 'New Generation Vehicle\nTracker Launched',
                description:
                    'Our latest vehicle tracking solution delivers higher accuracy, advanced safety features.',
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildNewsCard(
                category: 'Company News',
                date: '05 Sep 2026',
                title: 'TrakMate Strengthens R&D\nwith New Talent',
                description:
                    'We are growing our engineering team to accelerate innovation in IoT, connected products.',
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildNewsCard(
                category: 'Events',
                date: '28 Aug 2026',
                title: 'TrakMate at Auto Expo 2026',
                description:
                    'Showcasing our latest innovations in connected mobility, intelligent vehicle solutions.',
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Align(
          alignment: Alignment.centerRight,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: tOrange1,
              side: BorderSide(color: tOrange1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View All News',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: tOrange1,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, size: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewsFilter(String label, {bool active = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
      decoration: BoxDecoration(
        color: active ? tBlue3 : tWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: active ? tBlue3 : tBlue.withOpacity(0.35)),
      ),
      child: Text(
        label,
        style: GoogleFonts.manrope(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: active ? tWhite : tBlue3,
        ),
      ),
    );
  }

  Widget _buildNewsOrangeButton(String label) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: tOrange1,
        foregroundColor: tWhite,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: tWhite,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.arrow_forward, size: 16),
        ],
      ),
    );
  }

  Widget _buildNewsCard({
    required String category,
    required String date,
    required String title,
    required String description,
  }) {
    return SizedBox(
      height: 350,
      child: Container(
        decoration: BoxDecoration(
          color: tWhite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: tBlue1.withOpacity(0.12)),
          boxShadow: [
            BoxShadow(
              color: tBlack.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 180,
              width: double.infinity,
              child: Image.asset('images/company.png', fit: BoxFit.cover),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            category,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.manrope(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: tOrange1,
                            ),
                          ),
                        ),

                        const SizedBox(width: 9),

                        Container(
                          width: 1,
                          height: 13,
                          color: tBlue3.withOpacity(0.2),
                        ),

                        const SizedBox(width: 9),

                        Text(
                          date,
                          style: GoogleFonts.manrope(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: tBlue3.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        height: 1.2,
                        fontWeight: FontWeight.w700,
                        color: tBlack,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.manrope(
                        fontSize: 11,
                        height: 1.45,
                        fontWeight: FontWeight.w500,
                        color: tBlue3.withOpacity(0.65),
                      ),
                    ),

                    // SAME SPACE ABOVE READ MORE
                    const Spacer(),

                    // SAME HEIGHT FOR READ MORE ON EVERY CARD
                    SizedBox(
                      height: 24,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Read More',
                            style: GoogleFonts.manrope(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: tOrange1,
                            ),
                          ),
                          const SizedBox(width: 7),
                          Icon(Icons.arrow_forward, size: 15, color: tOrange1),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificationsSection() {
    return Column(
      children: [
        Text(
          "CERTIFICATIONS",
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: tOrange1,
            letterSpacing: 1.2,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          "Committed to Quality, Safety & Excellence",
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: tBlue2,
          ),
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 140,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                _certs.map((cert) {
                  return SizedBox(
                    width: 200, //width
                    height: 110,
                    child: _buildCertificationCard(cert),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCertificationCard(_CertData cert) {
    final bool isSvg = cert.logo.toLowerCase().endsWith('.svg');

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Fixed-height slot: every logo is centered inside the SAME box,
        // so no matter how tall/short an individual SVG renders,
        // this box always ends at the same Y.
        SizedBox(
          height: 70, // pick a value >=  tallest logoHeight
          child: Center(
            child:
                isSvg
                    ? SvgPicture.asset(
                      cert.logo,
                      height: cert.logoHeight,
                      width: cert.logoWidth,
                      fit: BoxFit.contain,
                    )
                    : Image.asset(
                      cert.logo,
                      height: cert.logoHeight,
                      width: cert.logoWidth,
                      fit: BoxFit.contain,
                    ),
          ),
        ),

        // const SizedBox(height: 2),
        if (cert.code.isNotEmpty) ...[
          Text(
            cert.code,
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              color: tBlue3,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          // const SizedBox(height: 2),
        ],

        Text(
          cert.label,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.manrope(
            color: tBlue3,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Widget _certDivider() {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 15),
  //     width: 1,
  //     height: 70,
  //     color: tBlack1.withOpacity(0.1),
  //   );
  // }

  Widget _buildInfrastructureSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildInfrastructureCard()),
        const SizedBox(width: 25),
        Expanded(child: _buildProductionFacilityCard()),
      ],
    );
  }

  Widget _buildInfrastructureCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tBlue2, tBlue3],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 9,
            child: SizedBox(
              height: 260,
              child: Image.asset(
                'images/infrastructure.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 11,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Infrastructure',
                    style: GoogleFonts.manrope(
                      color: tWhite,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Our state-of-the-art infrastructure is built to support innovation, collaboration and high-performance engineering.',
                    style: GoogleFonts.manrope(
                      color: tWhite.withOpacity(0.75),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildFeatureItem('Modern Offices', textColor: tWhite),
                  _buildFeatureItem('Advanced R&D Labs', textColor: tWhite),
                  _buildFeatureItem(
                    'Design & Development Centers',
                    textColor: tWhite,
                  ),
                  _buildFeatureItem(
                    'Collaborative Workspaces',
                    textColor: tWhite,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductionFacilityCard() {
    return Container(
      decoration: BoxDecoration(
        color: tBlue1.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 11,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Production Facility',
                    style: GoogleFonts.manrope(
                      color: tBlack,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Our in-house manufacturing facility ensures precision, quality and scalability.',
                    style: GoogleFonts.manrope(
                      color: tBlue3,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildFeatureItem(
                    'SMT & PCB Assembly Lines',
                    textColor: tBlack,
                  ),
                  _buildFeatureItem(
                    'Product Assembly Lines',
                    textColor: tBlack,
                  ),
                  _buildFeatureItem(
                    'Testing & Validation Labs',
                    textColor: tBlack,
                  ),
                  _buildFeatureItem(
                    'Quality Control Systems',
                    textColor: tBlack,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: SizedBox(
              height: 265,
              child: Image.asset(
                'images/production_facilities.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text, {required Color textColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 16,
            height: 16,
            margin: const EdgeInsets.only(top: 1),
            decoration: const BoxDecoration(
              color: tOrange1,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, size: 10, color: tWhite),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.manrope(
                color: textColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CertData {
  final String logo;
  final String code;
  final String label;
  final double logoWidth;
  final double logoHeight;

  const _CertData({
    required this.logo,
    required this.code,
    required this.label,
    required this.logoWidth,
    required this.logoHeight,
  });
}
