import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:trakmate_portal/src/ui/widgets/all_news.dart';
import 'package:trakmate_portal/src/ui/widgets/heroanimation.dart';
import 'package:trakmate_portal/src/ui/widgets/news_article.dart';
import 'package:trakmate_portal/src/ui/widgets/news_card.dart';
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

class _AboutusSectionState extends State<AboutusSection> {
  bool _heroImageLoading = true;

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
  final List<NewsArticle> _news = [
    NewsArticle(
      category: 'Company News',
      date: '25 Sep 2026',
      publishedAt: DateTime(2026, 9, 25),
      title:
          'TrakMate Expands Its Engineering Capabilities with New Innovation Center',
      summary:
          'We are excited to announce the expansion of our engineering capabilities with a new state-of-the-art innovation center, strengthening our commitment to build smarter, connected products for a better tomorrow.',
      image: 'images/innovation_center.png',
      author: 'TrakMate Communications',
      readTime: '3 min read',
      content: [
        'Write paragraph 1 of the full article here.',
        'Write paragraph 2 here.',
        'Write paragraph 3 here.',
      ],
    ),

    NewsArticle(
      category: 'Engineering',
      date: '18 Sep 2026',
      publishedAt: DateTime(2026, 9, 18),
      title: 'Advancing Embedded Systems for a Smarter Future',
      summary:
          'Exploring next-generation embedded solutions for connected mobility and IoT.',
      image: 'images/embedded_systems.png',
      content: ['Full article paragraph 1...', 'Paragraph 2...'],
    ),
    NewsArticle(
      category: 'Products',
      date: '12 Sep 2026',
      publishedAt: DateTime(2026, 9, 12),
      title: 'New Generation Vehicle Tracker Launched',
      summary:
          'Our latest vehicle tracking solution delivers higher accuracy, advanced safety features.',
      image: 'images/tracker_launch.png',
      content: ['Full article paragraph 1...', 'Paragraph 2...'],
    ),
    NewsArticle(
      category: 'Company News',
      date: '05 Sep 2026',
      publishedAt: DateTime(2026, 9, 5),
      title: 'TrakMate Strengthens R&D with New Talent',
      summary:
          'We are growing our engineering team to accelerate innovation in IoT, connected products.',
      image: 'images/R&D_Team.png',
      content: ['Full article paragraph 1...', 'Paragraph 2...'],
    ),
    NewsArticle(
      category: 'Events',
      date: '28 Aug 2026',
      publishedAt: DateTime(2026, 8, 28),
      title: 'TrakMate at Auto Expo 2026',
      summary:
          'Showcasing our latest innovations in connected mobility, intelligent vehicle solutions.',
      image: 'images/auto_expo.png',
      content: [
        'We deliver innovative technology solutions designed to meet evolving business needs.'
            'Our approach combines engineering expertise, smart technology, and reliable processes.'
            'We focus on building scalable, efficient, and high-quality solutions for our customers.'
            'With a commitment to excellence, we turn ideas into practical, connected products.',
        // 'Paragraph 2...',
      ],
    ),
  ];
  List<NewsArticle> get _sortedNews {
    final list = [..._news];
    list.sort((a, b) => b.publishedAt.compareTo(a.publishedAt)); // newest first
    return list;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadHeroImage();
    });
  }

  Future<void> _preloadHeroImage() async {
    try {
      await precacheImage(const AssetImage('images/sol3.jpg'), context);
    } catch (e) {
      debugPrint('Error preloading solutions hero image: $e');
    }

    if (!mounted) return;
    setState(() {
      _heroImageLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 1st: HERO + ACHIEVEMENTS OVERLAP
          Stack(
            clipBehavior: Clip.none,
            children: [
              // HERO
              _heroImageLoading
                  ? const HeroHeaderShimmer()
                  : _buildAboutUsHeader(),

              // ACHIEVEMENTS CARD
              Positioned(
                left: 80,
                right: 80,
                bottom: -65,
                child: _buildAchievementsRibbon(),
              ),
            ],
          ),

          // Space occupied by the overlapping achievements ribbon
          const SizedBox(height: 100),

          // 2nd: OUR JOURNEY
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: _buildStoryTimelineSection(),
          ),
          const SizedBox(height: 40),

          // 3rd: MISSION + VISION (side by side), then OUR STORY (full width)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              children: [
                _buildMissionVisionColumn(),
                const SizedBox(height: 35),
                // _infrastructureBrickLayout(),
              ],
            ),
          ),
          const SizedBox(height: 25),

          _ourTeamSection(),
          const SizedBox(height: 25),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 40.0),
          //   child: _buildInfrastructureSection(),
          // ),
          const SizedBox(height: 35),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 40.0),
          //   child: _buildNewsMediaSection(),
          // ),
          // const SizedBox(height: 40),
          const SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: _buildCertificationsSection(),
          ),
          const SizedBox(height: 40),
          FooterSection(onNavigate: widget.onNavigate),
        ],
      ),
    );
  }

  Widget _buildAchievementsRibbon() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tWhite, tWhite],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tOrange1, width: 1),
        boxShadow: [
          BoxShadow(
            color: tBlack.withOpacity(0.15),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
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
    );
  }

  // Mission and Vision as 2 separate cards, side by side.
  Widget _buildMissionVisionColumn() {
    return Row(
      children: [
        Expanded(
          child: _missionVisionBox(
            icon: 'icons/impact.svg',
            title: 'Our Mission',
            description:
                'To deliver innovative and reliable engineering solutions that empower businesses and improve lives through technology and excellence.',
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _missionVisionBox(
            icon: 'icons/vision.svg',
            title: 'Our Vision',
            description:
                'To become a global leader in engineering innovation, driving sustainable growth and creating lasting value for our customers.',
            iconRight: true,
          ),
        ),
      ],
    );
  }

  Widget _missionVisionBox({
    required String icon,
    required String title,
    required String description,
    bool iconRight = false,
  }) {
    return Container(
      width: double.infinity,
      height: 114,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      decoration: BoxDecoration(
        color: tBlue1.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: buildMissionVisionCard(
        icon: icon,
        title: title,
        description: description,
        iconRight: iconRight,
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          // How much of the hero width the image covers (from the right).
          // Increase for a bigger image / longer blend, decrease for smaller.
          final double imageWidth = constraints.maxWidth * 0.62;

          return Stack(
            children: [
              // 1) IMAGE LAYER (behind the text), blended into the blue
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                width: imageWidth,
                child: _buildBlendedAboutImage(),
              ),

              // 2) CONTENT LAYER (text + cards) on top
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 400),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 25,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: _buildAboutHeroTextColumn()),
                      const SizedBox(width: 40),
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

  /// Hero image with its LEFT edge (and a bit of the BOTTOM edge)
  /// faded to transparent, so it melts into the blue background.
  Widget _buildBlendedAboutImage() {
    // Horizontal fade: left = invisible -> right = fully visible
    final Widget horizontallyFaded = ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.transparent, Colors.black54, Colors.black],
          // 0.00 -> 0.55 is the blend zone. Bigger last value = softer,
          // longer blend. Smaller = sharper edge.
          stops: [0.0, 0.30, 0.55],
        ).createShader(rect);
      },
      child: Image.asset(
        'images/company.png',
        fit: BoxFit.cover,
        alignment: Alignment.centerRight,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: tBlack.withOpacity(0.05),
            alignment: Alignment.center,
            child: Icon(
              Icons.image_not_supported_outlined,
              size: 50,
              color: tWhite.withOpacity(0.6),
            ),
          );
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
          // Fully visible until 80% height, then fades out.
          stops: [0.0, 0.80, 1.0],
        ).createShader(rect);
      },
      child: horizontallyFaded,
    );
  }

  /// Left side: label, title, description and the 4 value cards.
  /// (Same content as before, just moved into its own method.)
  Widget _buildAboutHeroTextColumn() {
    return Column(
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
                const TextSpan(text: 'Engineering Innovation.\n'),
                TextSpan(
                  text: 'Building a Smarter Tomorrow.',
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
    );
  }

  Widget buildMissionVisionCard({
    required String icon,
    required String title,
    required String description,
    bool iconRight = false,
  }) {
    final Widget iconCircle = Container(
      width: 70,
      height: 70,
      decoration: const BoxDecoration(color: tBlue3, shape: BoxShape.circle),
      child: Center(
        child: SvgPicture.asset(icon, width: 35, height: 35, color: tWhite),
      ),
    );

    final Widget textBlock = Expanded(
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
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center, // was .start
      children:
          iconRight
              ? [textBlock, const SizedBox(width: 15), iconCircle]
              : [iconCircle, const SizedBox(width: 15), textBlock],
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
                color: tBlue2,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.manrope(
                color: tBlue2,
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

  // ===================== OUR STORY (arrow infographic) =====================
  Widget _infrastructureBrickLayout() {
    const steps = <_StoryStep>[
      _StoryStep(
        icon: 'icons/innovation.svg',
        title: 'Foundation & Vision',
        description: 'Where our journey began.',
        color: Color(0xFFFFCF48),
        darkColor: Color(0xFFF4BE3F),
      ),
      _StoryStep(
        icon: 'icons/impact.svg',
        title: 'Innovation & Expansion',
        description: 'Growing our capabilities through new ideas.',
        color: Color(0xFF99CC33),
        darkColor: Color(0xFF98C230),
      ),
      _StoryStep(
        icon: 'icons/collaboration.svg',
        title: 'Connected Growth',
        description: 'Building stronger solutions and partnerships.',
        color: Color(0xFF30B5C8),
        darkColor: Color(0xFF24A8B5),
      ),
      _StoryStep(
        icon: 'icons/globe.svg',
        title: 'Global Reach',
        description: 'Expanding our presence across new markets.',
        color: Color(0xFFE84C47),
        darkColor: Color(0xFFD93533),
      ),
      _StoryStep(
        icon: 'icons/manufacture.svg',
        title: 'Future & Evolution',
        description: 'Continuously shaping what comes next.',
        color: Color(0xFFA33572),
        darkColor: Color(0xFF962D6C),
      ),
    ];

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

        const SizedBox(height: 25),

        // 5 arrows nested one after another, content inside each arrow
        LayoutBuilder(
          builder: (context, constraints) {
            const double arrowH = 190; // arrow height
            const double notch = 38; // depth of the arrow point / notch
            const double gap = 6; // space between arrows
            final double w = constraints.maxWidth;
            final double arrowW =
                (w + (steps.length - 1) * (notch - gap)) / steps.length;
            final double stepX = arrowW - notch + gap;

            return SizedBox(
              width: w,
              height: arrowH,
              child: Stack(
                children: [
                  for (int i = 0; i < steps.length; i++)
                    Positioned(
                      left: stepX * i,
                      top: 0,
                      width: arrowW,
                      height: arrowH,
                      child: _buildStoryArrow(steps[i], notch, i, steps.length),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildStoryArrow(_StoryStep s, double notch, int index, int count) {
    // tOrange1 on the first arrow, fading gradually towards the last one.
    const double maxFade = 0.50; // 0 = no fade, higher = lighter last arrow
    final double t = count > 1 ? index / (count - 1) : 0.0;
    final Color base = Color.lerp(tOrange1, Colors.white, t * maxFade)!;
    final Color shade = Color.lerp(base, Colors.black, 0.10)!;

    return CustomPaint(
      painter: _StoryChevronPainter(top: base, bottom: shade, notch: notch),
      child: Padding(
        padding: EdgeInsets.fromLTRB(notch + 6, 14, notch + 6, 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              s.icon,
              width: 36,
              height: 36,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              s.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.manrope(
                color: Colors.white,
                fontSize: 14,
                height: 1.2,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              s.description,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.manrope(
                color: Colors.white.withOpacity(0.92),
                fontSize: 11,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
  // =================== END OUR STORY (arrow infographic) ===================

  Widget _buildStoryTimelineSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'OUR JOURNEY',
          style: GoogleFonts.manrope(
            color: tOrange1,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),

        const SizedBox(height: 7),

        Text(
          'Milestones That Shaped Our Journey.',
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            color: tBlue2,
            fontSize: 25,
            fontWeight: FontWeight.w700,
            height: 1.05,
          ),
        ),

        const SizedBox(height: 25),

        SizedBox(
          width: double.infinity,
          height: 250,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double w = constraints.maxWidth;

              // ---- layout constants (tweak these) ----
              const double cardH = 104; // card height
              const double pointerH = 10; // arrow height
              const double nodeSize = 30; // timeline dot size
              const double cardWidthFactor = 0.27; // card width (fraction)
              const double stepFactor =
                  0.17; // distance between cards (was 0.23)
              // total width taken by all 4 cards together
              const double totalSpan = stepFactor * 3 + cardWidthFactor;
              // auto-centers the whole timeline (was 0.02)
              const double startFactor = (1 - totalSpan) / 2;

              // vertical center of the timeline line
              const double lineY = cardH + pointerH + nodeSize / 2;

              final items = [
                (
                  '2013',
                  'The Beginning',
                  'TrakMate was founded with a vision to innovate',
                  'icons/innovation.svg',
                ),
                (
                  '2016',
                  'Expanding Solutions',
                  'Launched IoT products and embedded solutions',
                  'icons/manufacture.svg',
                ),
                (
                  '2019',
                  'Global Growth',
                  'Expanded into international markets and built strong partnerships',
                  'icons/globe.svg',
                ),
                (
                  'Today',
                  'Shaping the Future',
                  'Continuously innovating to build a smarter, connected world',
                  'icons/collaboration.svg',
                ),
              ];

              final List<Widget> children = [
                // timeline line
                Positioned(
                  left: 150,
                  right: 150,
                  top: lineY - 2.5,
                  child: Container(
                    // width: 600,
                    height: 5,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [tWhite, tBlue1, tBlue, tBlue1, tWhite],
                        stops: [0.0, 0.18, 0.50, 0.82, 1.0],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: tBlue.withOpacity(0.35),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ];

              // cards
              for (int i = 0; i < items.length; i++) {
                final bool isAbove = i.isEven;
                final double left = w * (startFactor + stepFactor * i);
                final item = items[i];

                children.add(
                  Positioned(
                    left: left,
                    width: w * cardWidthFactor,
                    top: isAbove ? 0 : lineY + nodeSize / 2 + pointerH,
                    child: _buildStoryTimelineCard(
                      year: item.$1,
                      title: item.$2,
                      description: item.$3,
                      icon: item.$4,
                      isAbove: isAbove,
                      cardHeight: cardH,
                      pointerHeight: pointerH,
                    ),
                  ),
                );
              }

              // nodes (drawn last, centered under/over each card's arrow)
              for (int i = 0; i < items.length; i++) {
                final double centerX =
                    w * (startFactor + stepFactor * i + cardWidthFactor / 2);
                children.add(
                  Positioned(
                    left: centerX - nodeSize / 2,
                    top: lineY - nodeSize / 2,
                    child: _buildStoryTimelineNode(size: nodeSize),
                  ),
                );
              }

              return Stack(clipBehavior: Clip.none, children: children);
            },
          ),
        ),

        const SizedBox(height: 5),
      ],
    );
  }

  Widget _buildStoryTimelineCard({
    required String year,
    required String title,
    required String description,
    required String icon,
    required bool isAbove,
    required double cardHeight,
    required double pointerHeight,
  }) {
    const Color cardColor = Color(0xFFF8FBFF);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: cardHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFB9D9FF).withOpacity(0.65),
              width: 1.4,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF66AFFF).withOpacity(0.18),
                blurRadius: 20,
                spreadRadius: 1,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                color: const Color(0xFF4C9AFF).withOpacity(0.10),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const RadialGradient(
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFF1F7FF),
                      Color(0xFFE6F1FF),
                    ],
                    stops: [0.0, 0.65, 1.0],
                  ),
                  border: Border.all(
                    color: const Color(0xFFD4E9FF),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5B9CFF).withOpacity(0.16),
                      blurRadius: 15,
                      spreadRadius: 3,
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.9),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFF7FBFF),
                    border: Border.all(
                      color: const Color(0xFFE0EEFF),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      icon,
                      width: 36,
                      height: 36,
                      fit: BoxFit.contain,
                      color: const Color(0xFF2474EA),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        year,
                        style: GoogleFonts.manrope(
                          color: const Color(0xFF1263E8),
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.manrope(
                          color: const Color(0xFF10284E),
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.manrope(
                          color: const Color(0xFF617797),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Arrow: overlaps the card border by 1.5px so it merges with the card
        Positioned(
          left: 0,
          right: 0,
          top: isAbove ? null : -(pointerHeight - 1.5),
          bottom: isAbove ? -(pointerHeight - 1.5) : null,
          child: Center(
            child: CustomPaint(
              size: Size(30, pointerHeight),
              painter: _StoryTimelinePointerPainter(
                isAbove: isAbove,
                fillColor: cardColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStoryTimelineNode({double size = 34}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFF7FBFF),
        border: Border.all(color: const Color(0xFFA8CFFF), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3C8DFF).withOpacity(0.25),
            blurRadius: 14,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: size - 12,
          height: size - 12,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [Color(0xFF3488FF), Color(0xFF1263E8)],
            ),
          ),
        ),
      ),
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
          // LEFT ICON
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
    final news = _sortedNews;
    final latest = news[0];

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
        RichText(
          text: TextSpan(
            style: GoogleFonts.manrope(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: tBlue2,
            ),
            children: const [TextSpan(text: 'Stay Connected With TrakMate')],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'The latest updates, milestones and stories from our engineering journey.',
          style: GoogleFonts.manrope(
            fontSize: 13,
            color: tBlack.withOpacity(0.75),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 25),

        // ---------- LATEST BANNER ----------
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
                  child: Image.asset(latest.image, fit: BoxFit.cover),
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
                              latest.category,
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
                              latest.date,
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
                          latest.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.manrope(
                            fontSize: 24,
                            height: 1.15,
                            fontWeight: FontWeight.w800,
                            color: tBlack,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          latest.summary,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.manrope(
                            fontSize: 12,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            color: tBlue3.withOpacity(0.65),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildNewsOrangeButton(
                          'Read Story',
                          onPressed:
                              () => showNewsArticleDialog(context, latest),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 25),

        // ---------- 4 NEWS CARDS ----------
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 1; i < news.length; i++) ...[
              Expanded(child: NewsCard(article: news[i])),
              if (i != news.length - 1) const SizedBox(width: 20),
            ],
          ],
        ),
        const SizedBox(height: 15),
        Align(
          alignment: Alignment.centerRight,
          child: OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AllNewsPage(articles: news)),
              );
            },
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

  Widget _buildNewsOrangeButton(
    String label, {
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
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

class _StoryTimelinePointerPainter extends CustomPainter {
  final bool isAbove;
  final Color fillColor;

  _StoryTimelinePointerPainter({
    required this.isAbove,
    this.fillColor = const Color(0xFFF8FBFF),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint = Paint()..color = fillColor;

    final Paint borderPaint =
        Paint()
          ..color = const Color(0xFF8FC0FF)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.6
          ..strokeJoin = StrokeJoin.round;

    final Path fill = Path();
    final Path edge = Path();

    if (isAbove) {
      // card is above -> arrow points DOWN
      fill
        ..moveTo(0, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width / 2, size.height)
        ..close();
      edge
        ..moveTo(0, 0)
        ..lineTo(size.width / 2, size.height)
        ..lineTo(size.width, 0);
    } else {
      // card is below -> arrow points UP
      fill
        ..moveTo(0, size.height)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width / 2, 0)
        ..close();
      edge
        ..moveTo(0, size.height)
        ..lineTo(size.width / 2, 0)
        ..lineTo(size.width, size.height);
    }

    canvas.drawPath(fill, fillPaint);
    canvas.drawPath(edge, borderPaint); // only the two slanted sides
  }

  @override
  bool shouldRepaint(covariant _StoryTimelinePointerPainter old) =>
      old.isAbove != isAbove || old.fillColor != fillColor;
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

// ---------- Our Story (infographic) helpers ----------
class _StoryStep {
  final String icon;
  final String title;
  final String description;
  final Color color;
  final Color darkColor;

  const _StoryStep({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.darkColor,
  });
}

class _StoryChevronPainter extends CustomPainter {
  final Color top;
  final Color bottom;
  final double notch;

  const _StoryChevronPainter({
    required this.top,
    required this.bottom,
    required this.notch,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final Path path =
        Path()
          ..moveTo(0, 0)
          ..lineTo(w - notch, 0)
          ..lineTo(w, h / 2)
          ..lineTo(w - notch, h)
          ..lineTo(0, h)
          ..lineTo(notch, h / 2)
          ..close();

    // soft shadow
    canvas.drawShadow(path, Colors.black.withOpacity(0.35), 6, false);

    // vertical gradient: lighter top, darker bottom
    final Paint fill =
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [top, bottom],
          ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(path, fill);
  }

  @override
  bool shouldRepaint(covariant _StoryChevronPainter old) =>
      old.top != top || old.bottom != bottom || old.notch != notch;
}
