import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:trakmate_portal/src/ui/widgets/heroanimation.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmereffect.dart';
import '../../utils/colors.dart';
import '../widgets/footer_section.dart';

class AboutusSection extends StatefulWidget {
  final bool isActive;
  const AboutusSection({super.key, required this.isActive});

  @override
  State<AboutusSection> createState() => _AboutusSectionState();
}

class _AboutusSectionState extends State<AboutusSection> {
  bool _heroImageLoading = true; // NEW

  late final PageController _certPageController;
  Timer? _certAutoScrollTimer;
  static const int _visibleCertCount = 4;
  static const int _certLoopMultiplier = 5000;

  final List<_CertData> _certs = const [
    _CertData(
      logo: 'icons/iso.svg',
      code: '9001:2015',
      label: 'Quality Management',
    ),
    _CertData(
      logo: 'icons/iso.svg',
      code: '14001:2015',
      label: 'Environmental Management',
    ),
    _CertData(
      logo: 'icons/iso.svg',
      code: '45001:2018',
      label: 'Occupational Health & Safety',
    ),
    _CertData(logo: 'icons/ce.svg', code: '', label: 'CE Certified'),
    _CertData(
      logo: 'icons/ais.svg',
      code: 'AIS 140',
      label: 'Vehicle Tracking & Telematics',
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadHeroImage();
    });
    _certPageController = PageController(
      viewportFraction: 1 / _visibleCertCount,
      initialPage: _certs.length * _certLoopMultiplier,
    );
    _startCertAutoScroll();
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

  @override
  void dispose() {
    _certAutoScrollTimer?.cancel();
    _certPageController.dispose();
    super.dispose();
  }

  void _startCertAutoScroll() {
    _certAutoScrollTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      _goToNextCertPage();
    });
  }

  void _goToNextCertPage() {
    if (!_certPageController.hasClients) return;
    _certPageController.nextPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.linear,
    );
  }

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
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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
          SizedBox(height: 25),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _storyContent()),

                const SizedBox(width: 40),

                Expanded(flex: 3, child: _storyImage()),

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
            child: _buildCertificationsSection(),
          ),

          SizedBox(height: 40),
          FooterSection(),
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
            Colors.white.withOpacity(0.0),
            Colors.white.withOpacity(0.25),
            tOrange1,
            Colors.white.withOpacity(0.25),
            Colors.white.withOpacity(0.0),
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
          "2014",
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
                          Colors.transparent,
                          tBlue.withOpacity(0.4),
                          tBlue,
                          tBlue.withOpacity(0.4),
                          Colors.transparent,
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

  Widget _buildCertificationsSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: tBlue.withOpacity(0.15),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Certifications & Partnership",
                  style: GoogleFonts.manrope(
                    color: tBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "We adhere to global standards to ensure quality, safety and environmental responsibility.",
                  style: GoogleFonts.manrope(
                    color: tBlue3,
                    fontSize: 13,
                    // fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          _certDivider(),

          Expanded(
            flex: 5,
            child: SizedBox(
              height: 100,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth = constraints.maxWidth / _visibleCertCount;
                  return PageView.builder(
                    controller: _certPageController,
                    padEnds: false,
                    onPageChanged: (index) {},
                    itemBuilder: (context, index) {
                      final cert = _certs[index % _certs.length];
                      return SizedBox(
                        width: itemWidth,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: buildCertificationCard(
                                logo: cert.logo,
                                code: cert.code,
                                label: cert.label,
                              ),
                            ),
                            _certDivider(),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCertificationCard({
    required String logo,
    required String code,
    required String label,
  }) {
    final bool isSvg = logo.toLowerCase().endsWith('.svg');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // SvgPicture.asset(logo, height: 42),
        isSvg
            ? SvgPicture.asset(logo, height: 42)
            : Image.asset(logo, height: 42, fit: BoxFit.contain),
        const SizedBox(height: 10),
        if (code.isNotEmpty) ...[
          Text(
            code,
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              color: tBlue3,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
        ],
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            color: tBlue3,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _certDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: 1,
      height: 70,
      color: tBlack1.withOpacity(0.1),
    );
  }

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
            child: const Icon(Icons.check, size: 10, color: Colors.white),
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

  const _CertData({
    required this.logo,
    required this.code,
    required this.label,
  });
}
