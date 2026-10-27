import 'dart:ui' show PathMetric;
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:trakmate_portal/src/ui/widgets/all_news.dart';
import 'package:trakmate_portal/src/ui/widgets/careers_details.dart';
import 'package:trakmate_portal/src/ui/widgets/hero_animation.dart';
import 'package:trakmate_portal/src/ui/widgets/nav_footer.dart';
import 'package:trakmate_portal/src/ui/widgets/news_article.dart';
import 'package:trakmate_portal/src/ui/widgets/news_card.dart';
import 'package:trakmate_portal/src/ui/widgets/our_journey.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmer_effect.dart';
import 'package:trakmate_portal/src/utils/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool _teamImagesLoading = true;

  /// CVs are mailed to this address (same address as the Careers page).
  static const String _careersEmail = 'keerthiprasad267@gmail.com';

  // Breakpoints come from ResponsiveLayout:
  //   mobile  < 700   |   tablet 700 - 1099   |   desktop >= 1100
  bool get isMobile => ResponsiveLayout.isMobile(context);
  bool get isTablet => ResponsiveLayout.isTablet(context);

  // Horizontal page padding used by every block below the hero
  double get _pad => isMobile ? 16 : (isTablet ? 24 : 40);

  // Mobile only: how far the achievements card hangs into the hero (px), and
  // the space reserved below the hero for the rest of the card.
  // Card is ~200px tall: overlap 90 -> ~110 hangs below the hero + 30 gap.
  // If you change the card height, adjust these two numbers.
  static const double _mobileRibbonOverlap = 90;
  static const double _mobileRibbonSpace = 140;

  // ---------- Footer scroll-to-section ----------
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _journeyKey = GlobalKey();
  final GlobalKey _missionKey = GlobalKey();
  final GlobalKey _leadershipKey = GlobalKey();
  final GlobalKey _careersKey = GlobalKey();
  final GlobalKey _certificationsKey = GlobalKey();

  // Footer label -> section key. Labels must match the footer text exactly.
  late final Map<String, GlobalKey> _scrollTargets = {
    'Our Journey': _journeyKey,
    'Vision & Mission': _missionKey,
    'Leadership': _leadershipKey,
    'Careers': _careersKey,
    'Certifications': _certificationsKey,
  };

  String? _pendingScrollKey;

  // ---------- Careers data ----------
  // One colour (`accent`) per job: the light background of the icon box and of
  // the experience pill is derived from it automatically (see _JobData).
  final List<_JobData> _jobs = const [
    _JobData(
      title: 'Flutter Developer',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '2 - 5 Yrs',
      icon: Icons.code_rounded,
      accent: tBlue1,
    ),
    _JobData(
      title: 'Embedded Systems Engineer',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '3 - 6 Yrs',
      icon: Icons.settings_outlined,
      accent: tOrange1,
    ),
    _JobData(
      title: 'Product Manager',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '4 - 7 Yrs',
      icon: Icons.bar_chart_rounded,
      accent: newbadge,
    ),
  ];

  // Shown in the "View All Openings" pop up (the first 3 + more)
  final List<_JobData> _allJobs = const [
    _JobData(
      title: 'Flutter Developer',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '2 - 5 Yrs',
      icon: Icons.code_rounded,
      accent: tBlue1,
    ),
    _JobData(
      title: 'Embedded Systems Engineer',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '3 - 6 Yrs',
      icon: Icons.settings_outlined,
      accent: tOrange1,
    ),
    _JobData(
      title: 'Product Manager',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '4 - 7 Yrs',
      icon: Icons.bar_chart_rounded,
      accent: newbadge,
    ),
    _JobData(
      title: 'Backend Developer',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '3 - 6 Yrs',
      icon: Icons.storage_rounded,
      accent: ipbadge,
    ),
    _JobData(
      title: 'QA Engineer',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '2 - 4 Yrs',
      icon: Icons.verified_outlined,
      accent: tBlueSky,
    ),
    _JobData(
      title: 'Hardware Design Engineer',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '3 - 7 Yrs',
      icon: Icons.memory_rounded,
      accent: tPink1,
    ),
  ];

  final List<_CertData> _certs = const [
    _CertData(
      logo: 'icons/ais.svg',
      code: 'AIS 140',
      label: 'Vehicle Tracking & Telematics',
      logoHeight: 46,
      logoWidth: 46,
    ),
    _CertData(
      logo: 'icons/iso.svg',
      code: '9001:2015',
      label: 'Quality Management',
      logoHeight: 42,
      logoWidth: 42,
    ),
    // _CertData(
    //   logo: 'icons/iso.svg',
    //   code: '14001:2015',
    //   label: 'Environmental Management',
    //   logoHeight: 42,
    //   logoWidth: 42,
    // ),
    // _CertData(
    //   logo: 'icons/iso.svg',
    //   code: '45001:2018',
    //   label: 'Occupational Health & Safety',
    //   logoHeight: 42,
    //   logoWidth: 42,
    // ),
    _CertData(
      logo: 'icons/rohs2.svg',
      code: 'ROHS Products',
      label: 'Vehicle Tracking & Telematics',
      logoHeight: 46,
      logoWidth: 46,
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
    SectionScrollBus.instance.pendingKey.addListener(_onScrollRequest);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadHeroImage();
      _preloadTeamImages();
    });
  }

  void _onScrollRequest() {
    final ScrollRequest? request = SectionScrollBus.instance.pendingKey.value;
    if (request == null) return;

    // Ignore keys meant for other pages (e.g. "CAD Design").
    final bool isMine =
        request.key == 'About Us' || _scrollTargets.containsKey(request.key);
    if (!isMine) return;

    _pendingScrollKey = request.key;
    SectionScrollBus.instance.pendingKey.value = null; // consume it

    // Already visible: scroll now. Otherwise didUpdateWidget does it.
    if (widget.isActive) _runPendingScroll();
  }

  void _runPendingScroll() {
    final String? key = _pendingScrollKey;
    if (key == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;

      if (key == 'About Us') {
        _pendingScrollKey = null;
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOutCubic,
          );
        }
        return;
      }

      final BuildContext? ctx = _scrollTargets[key]?.currentContext;
      if (ctx == null) return; // still loading (shimmer): stay pending

      _pendingScrollKey = null;
      await Scrollable.ensureVisible(
        ctx,
        alignment: 0.0,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void didUpdateWidget(covariant AboutusSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    // About Us just became visible and a footer click is waiting.
    if (!oldWidget.isActive && widget.isActive && _pendingScrollKey != null) {
      Future.delayed(const Duration(milliseconds: 120), _runPendingScroll);
    }
  }

  Future<void> _preloadHeroImage() async {
    try {
      await precacheImage(
        const AssetImage('images/company.png'),
        context,
        onError: (e, s) => debugPrint('Failed to load about hero: $e'),
      ).timeout(const Duration(seconds: 10));
    } catch (e) {
      // debugPrint('Error preloading about hero image: $e');
    }
    if (!mounted) return;
    setState(() => _heroImageLoading = false);
    _runPendingScroll();
  }

  Future<void> _preloadTeamImages() async {
    try {
      await Future.wait(
        ['images/img1.jpg', 'images/img2.jpg'].map(
          (path) => precacheImage(
            AssetImage(path),
            context,
            onError: (e, s) => debugPrint('FAILED to load $path: $e'),
          ),
        ),
      ).timeout(const Duration(seconds: 10));
    } catch (e) {
      // debugPrint('Error preloading team images: $e');
    }
    if (!mounted) return;
    setState(() => _teamImagesLoading = false);
    _runPendingScroll();
  }

  @override
  void dispose() {
    SectionScrollBus.instance.pendingKey.removeListener(_onScrollRequest);
    _scrollController.dispose();
    super.dispose();
  }

  // =====================================================================
  //                 CV BY MAIL (same as the Careers page)
  // =====================================================================

  /// Opens the visitor's mail app / webmail straight away with the careers
  /// address, subject and body pre-filled (same approach as the Careers
  /// page). A mailto link cannot carry attachments, so the visitor attaches
  /// the CV in the mail window.
  Future<void> _openCvMail({String? jobTitle}) async {
    final String mailSubject =
        jobTitle != null ? 'Application for $jobTitle' : 'CV Submission';

    final String body =
        'Hi TrakMate,\n\n'
        '${jobTitle != null ? 'I would like to apply for the $jobTitle position.' : 'I would like to share my CV for future opportunities.'}\n\n'
        'Please find my CV attached.\n\n'
        // '(Please attach your CV in PDF, DOC or DOCX format to this mail before sending.)\n\n'
        'Thanks & Regards,\n';

    final Uri mailUri = Uri.parse(
      'mailto:$_careersEmail'
      '?subject=${Uri.encodeComponent(mailSubject)}'
      '&body=${Uri.encodeComponent(body)}',
    );

    // Ask first. The mail app only opens after the visitor taps "Okay".
    final bool? proceed = await _showCvDialog(
      title: 'Attach your CV',
      message:
          'Your email app will open with the details filled in. '
          'Please attach your CV (PDF, DOC or DOCX) to the email and send it to our careers team.',
    );
    if (proceed != true || !mounted) return;

    try {
      // '_self' keeps your website in the same tab; mailto never navigates away.
      await launchUrl(mailUri, webOnlyWindowName: '_self');
    } catch (_) {
      await _showCvDialog(
        title: 'Could not open mail',
        message:
            'We could not open your email app. Please email your CV to $_careersEmail.',
        showCancel: false,
      );
    }
  }

  /// Confirmation dialog. Returns true when the visitor taps "Okay",
  /// false / null on Cancel or when dismissed.
  Future<bool?> _showCvDialog({
    required String title,
    required String message,
    bool showCancel = true,
  }) async {
    if (!mounted) return null;
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: tWhite,
          surfaceTintColor: tTransparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titlePadding: const EdgeInsets.fromLTRB(24, 22, 24, 0),
          contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 4),
          actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          title: Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: tBlue4,
            ),
          ),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Text(
              message,
              style: GoogleFonts.manrope(
                fontSize: 13.5,
                height: 1.5,
                color: tBlue4.withOpacity(0.8),
              ),
            ),
          ),
          actions: [
            if (showCancel)
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: tBlue4.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: ElevatedButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: tBlueDark,
                  foregroundColor: tWhite,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Okay',
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: tWhite,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          // 1st: HERO + ACHIEVEMENTS
          if (isMobile) ...[
            // Mobile: the achievements card overlaps the bottom of the hero,
            // same effect as tablet / desktop.
            Stack(
              clipBehavior: Clip.none,
              children: [
                _heroImageLoading
                    ? const HeroHeaderShimmer()
                    : _buildAboutUsHeader(),
                Positioned(
                  left: _pad,
                  right: _pad,
                  bottom: -_mobileRibbonOverlap,
                  child: _buildAchievementsRibbon(),
                ),
              ],
            ),
            // Space taken by the part of the ribbon that hangs below the hero
            SizedBox(height: _mobileRibbonSpace),
          ] else ...[
            Stack(
              clipBehavior: Clip.none,
              children: [
                // HERO
                _heroImageLoading
                    ? const HeroHeaderShimmer()
                    : _buildAboutUsHeader(),

                // ACHIEVEMENTS CARD
                Positioned(
                  left: isTablet ? 24 : 80,
                  right: isTablet ? 24 : 80,
                  bottom: isTablet ? -100 : -65,
                  child: _buildAchievementsRibbon(),
                ),
              ],
            ),

            // Space occupied by the overlapping achievements ribbon
            SizedBox(height: isTablet ? 135 : 100),
          ],

          // 2nd: OUR JOURNEY
          Container(
            key: _journeyKey,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: _pad, vertical: 10),
            child: OurJourneySection(),
          ),
          SizedBox(height: isMobile ? 28 : 40),

          // 3rd: MISSION + VISION (side by side), then OUR STORY (full width)
          Padding(
            key: _missionKey,
            padding: EdgeInsets.symmetric(horizontal: _pad),
            child: Column(
              children: [
                _buildMissionVisionColumn(),
                SizedBox(height: isMobile ? 20 : 35),
              ],
            ),
          ),
          const SizedBox(height: 25),

          KeyedSubtree(
            key: _leadershipKey,
            child:
                _teamImagesLoading
                    ? const TeamSectionShimmer()
                    : _ourTeamSection(),
          ),
          const SizedBox(height: 25),

          // CAREERS (under Meet Our Leadership)
          Padding(
            key: _careersKey,
            padding: EdgeInsets.symmetric(horizontal: _pad),
            child:
                _heroImageLoading
                    ? const CareersSectionShimmer()
                    : _buildCareersSection(),
          ),
          const SizedBox(height: 25),

          SizedBox(height: isMobile ? 20 : 35),
          const SizedBox(height: 40),

          Padding(
            key: _certificationsKey,
            padding: EdgeInsets.symmetric(horizontal: _pad),
            child: _buildCertificationsSection(),
          ),
          SizedBox(height: isMobile ? 32 : 40),
          FooterSection(onNavigate: widget.onNavigate),
        ],
      ),
    );
  }

  // =====================================================================
  //                              CAREERS SECTION
  // =====================================================================

  Widget _buildCareersSection() {
    return Container(
      width: double.infinity,
      height: (isTablet || isMobile) ? null : 525,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isMobile ? 20 : 26),
        boxShadow: [
          BoxShadow(color: tBlue1.withOpacity(0.10), spreadRadius: 1),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isMobile ? 20 : 26),
        child:
            isMobile
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildCareersRightPanelMobile(),
                    _buildCareersLeftPanel(),
                  ],
                )
                : isTablet
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 470, child: _buildCareersRightPanel()),
                    SizedBox(height: 560, child: _buildCareersLeftPanel()),
                  ],
                )
                : Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(flex: 47, child: _buildCareersLeftPanel()),
                    Expanded(flex: 53, child: _buildCareersRightPanel()),
                  ],
                ),
      ),
    );
  }

  // ---------------------------- LEFT PANEL ----------------------------
  Widget _buildCareersLeftPanel() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [tWhite, tBlueSky1],
        ),
      ),
      padding:
          isMobile
              ? const EdgeInsets.fromLTRB(18, 28, 18, 24)
              : EdgeInsets.fromLTRB(
                isTablet ? 28 : 40,
                38,
                isTablet ? 28 : 40,
                22,
              ),
      child: Column(
        mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // eyebrow label with line
          Row(
            children: [
              Container(width: 28, height: 2, color: tBlue1),
              const SizedBox(width: 12),
              Text(
                'CURRENT OPENINGS',
                style: GoogleFonts.manrope(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: tBlackLight.withOpacity(0.7),
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          RichText(
            text: TextSpan(
              style: GoogleFonts.manrope(
                fontSize: isMobile ? 27 : 33,
                fontWeight: FontWeight.w800,
                height: 1.1,
                color: tBlue2,
              ),
              children: const [
                TextSpan(text: 'Be a part of '),
                TextSpan(
                  text: 'something bigger',
                  style: TextStyle(color: tOrange1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            isMobile
                ? 'Explore exciting career opportunities and help us build smarter, connected solutions for a better and safer tomorrow.'
                : 'Explore exciting career opportunities and help us build smarter,\nconnected solutions for a better and safer tomorrow.',
            style: GoogleFonts.manrope(
              fontSize: 13,
              height: 1.5,
              fontWeight: FontWeight.w500,
              color: tBlackLight.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 18),

          for (int i = 0; i < _jobs.length; i++) ...[
            _buildJobCard(_jobs[i]),
            if (i != _jobs.length - 1) const SizedBox(height: 10),
          ],

          if (isMobile) const SizedBox(height: 22) else const Spacer(),

          SizedBox(
            width: isMobile ? double.infinity : null,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const CareersPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: tBlue1,
                foregroundColor: tWhite,
                elevation: 0,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: isMobile ? 16 : 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'View All Openings',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: tWhite,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.arrow_forward_rounded, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(_JobData job, {VoidCallback? onTap}) {
    if (isMobile) return _buildJobCardMobile(job);

    return Material(
      color: tTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: tWhite,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: tBlue3.withOpacity(0.06),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: job.background,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(job.icon, size: 28, color: job.accent),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      job.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.manrope(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: tBlue2,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 15,
                          color: tBlackLight.withOpacity(0.7),
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            job.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.manrope(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: tBlackLight.withOpacity(0.7),
                            ),
                          ),
                        ),
                        const SizedBox(width: 9),
                        Container(
                          width: 1,
                          height: 12,
                          color: tBlackLight.withOpacity(0.7).withOpacity(0.5),
                        ),
                        const SizedBox(width: 9),
                        Icon(
                          Icons.work_outline_rounded,
                          size: 15,
                          color: tBlackLight.withOpacity(0.7),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          job.type,
                          style: GoogleFonts.manrope(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: tBlackLight.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: job.background,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  job.experience,
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: job.accent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Mobile job card: smaller icon, meta info wraps, experience pill sits
  /// under the details instead of squeezing the row.
  Widget _buildJobCardMobile(_JobData job) {
    Widget meta(IconData icon, String text) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: tBlackLight.withOpacity(0.7)),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.manrope(
            fontSize: 11.5,
            fontWeight: FontWeight.w500,
            color: tBlackLight.withOpacity(0.7),
          ),
        ),
      ],
    );

    return Material(
      color: tTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: tWhite,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: tBlue3.withOpacity(0.06),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: job.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(job.icon, size: 24, color: job.accent),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      job.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: tBlue2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 12,
                      runSpacing: 4,
                      children: [
                        meta(Icons.location_on_outlined, job.location),
                        meta(Icons.work_outline_rounded, job.type),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: job.background,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        job.experience,
                        style: GoogleFonts.manrope(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: job.accent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------- RIGHT PANEL ----------------------------
  Widget _buildCareersRightPanel() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double w = constraints.maxWidth;
        final double h = constraints.maxHeight;

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.alphaBlend(tBlue1.withOpacity(0.14), tWhite),
                Color.alphaBlend(tBlue1.withOpacity(0.24), tWhite),
              ],
            ),
          ),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              // big soft circle (back)
              Positioned(
                right: -w * 0.05,
                top: -h * 0.16,
                child: Container(
                  width: w * 0.62,
                  height: w * 0.62,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: tBlue1.withOpacity(0.16),
                  ),
                ),
              ),
              // brighter circle (front)
              Positioned(
                right: -w * 0.12,
                top: -h * 0.30,
                child: Container(
                  width: w * 0.55,
                  height: w * 0.55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        tBlue1.withOpacity(0.80),
                        tBlue1.withOpacity(0.30),
                      ],
                    ),
                  ),
                ),
              ),

              // IMAGE (company.png) - bottom right, curved top-left & blended
              Positioned(
                right: 0,
                bottom: 0,
                width: w * 0.58,
                height: h * 0.72,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(230),
                  ),
                  child: ShaderMask(
                    blendMode: BlendMode.dstIn,
                    shaderCallback: (Rect rect) {
                      return const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [tTransparent, tBlack1, tBlack],
                        stops: [0.0, 0.18, 0.40],
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
                  ),
                ),
              ),

              // CONTENT
              Padding(
                padding:
                    isTablet
                        ? const EdgeInsets.fromLTRB(28, 50, 20, 28)
                        : const EdgeInsets.fromLTRB(40, 70, 20, 36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(width: 28, height: 2, color: tBlue1),
                        const SizedBox(width: 12),
                        Text(
                          'CAREERS AT TRAKMATE',
                          style: GoogleFonts.manrope(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: tBlackLight.withOpacity(0.7),
                            letterSpacing: 3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.manrope(
                          fontSize: 62,
                          fontWeight: FontWeight.w800,
                          height: 0.95,
                          letterSpacing: -1.5,
                          color: tBlue2,
                        ),
                        children: const [
                          TextSpan(text: 'Join our\n'),
                          TextSpan(
                            text: 'team',
                            style: TextStyle(color: tBlue1),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: w * 0.46,
                      child: Text(
                        'Bring your skills, passion and ideas to a team that’s building the future of connected mobility. Let’s create smarter solutions together.',
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          height: 1.55,
                          fontWeight: FontWeight.w500,
                          color: tBlackLight.withOpacity(0.7),
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: w * 0.37,
                      child: _buildCvUploadBox(width: w * 0.37),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Mobile version of the "Join our team" panel: a banner image on top that
  /// fades into the tint, then the text and the upload box stacked below.
  Widget _buildCareersRightPanelMobile() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.alphaBlend(tBlue1.withOpacity(0.14), tWhite),
            Color.alphaBlend(tBlue1.withOpacity(0.24), tWhite),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 150,
            child: ShaderMask(
              blendMode: BlendMode.dstIn,
              shaderCallback: (Rect rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [tBlack, tBlack, tTransparent],
                  stops: [0.0, 0.6, 1.0],
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
                      size: 40,
                      color: tWhite.withOpacity(0.6),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(width: 24, height: 2, color: tBlue1),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        'CAREERS AT TRAKMATE',
                        style: GoogleFonts.manrope(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: tBlackLight.withOpacity(0.7),
                          letterSpacing: 2.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.manrope(
                      fontSize: 44,
                      fontWeight: FontWeight.w800,
                      height: 1.0,
                      letterSpacing: -1,
                      color: tBlue2,
                    ),
                    children: const [
                      TextSpan(text: 'Join our '),
                      TextSpan(text: 'team', style: TextStyle(color: tBlue1)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Bring your skills, passion and ideas to a team that’s building the future of connected mobility. Let’s create smarter solutions together.',
                  style: GoogleFonts.manrope(
                    fontSize: 13.5,
                    height: 1.55,
                    fontWeight: FontWeight.w500,
                    color: tBlackLight.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 20),
                _buildCvUploadBox(width: double.infinity),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// "Upload / Submit your CV" box – same behaviour as the Careers page:
  /// tapping it shows the "Attach your CV" dialog and then opens the mail app
  /// (no file picker / drag and drop).
  Widget _buildCvUploadBox({required double width}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: tBlue1.withOpacity(0.6),
          radius: 16,
          dashWidth: 5,
          dashGap: 4,
          strokeWidth: 1.2,
        ),
        child: Container(
          width: width,
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: tWhite.withOpacity(0.35),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Material(
            color: tTransparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => _openCvMail(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_upload_rounded,
                    size: 38,
                    color: tBlue1.withOpacity(0.8),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Upload / Submit your CV',
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: tBlue2,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Opens your mail – attach your CV there',
                    style: GoogleFonts.manrope(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w500,
                      color: tBlackLight.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------- VIEW ALL OPENINGS POP UP ----------------------
  void _showAllOpeningsDialog() {
    showDialog(
      context: context,
      barrierColor: tBlue2.withOpacity(0.45),
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: tWhite,
          insetPadding: EdgeInsets.symmetric(
            horizontal: isMobile ? 14 : 40,
            vertical: isMobile ? 24 : 40,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          clipBehavior: Clip.antiAlias,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760, maxHeight: 640),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // header
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(isMobile ? 20 : 32, 26, 20, 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        tBlueSky1,
                        Color.alphaBlend(tBlue1.withOpacity(0.14), tWhite),
                      ],
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(width: 28, height: 2, color: tBlue1),
                                const SizedBox(width: 12),
                                Text(
                                  'CURRENT OPENINGS',
                                  style: GoogleFonts.manrope(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: tBlackLight.withOpacity(0.7),
                                    letterSpacing: 3,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.manrope(
                                  fontSize: isMobile ? 22 : 26,
                                  fontWeight: FontWeight.w800,
                                  color: tBlue2,
                                ),
                                children: [
                                  const TextSpan(text: 'All open '),
                                  const TextSpan(
                                    text: 'positions',
                                    style: TextStyle(color: tBlue1),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${_allJobs.length} roles available at TrakMate',
                              style: GoogleFonts.manrope(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                                color: tBlackLight.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        icon: const Icon(Icons.close_rounded, color: tBlue2),
                        splashRadius: 20,
                      ),
                    ],
                  ),
                ),

                // list
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.fromLTRB(
                      isMobile ? 16 : 32,
                      22,
                      isMobile ? 16 : 32,
                      10,
                    ),
                    itemCount: _allJobs.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: tBlue1.withOpacity(0.10)),
                        ),
                        child: _buildJobCard(
                          _allJobs[index],
                          onTap: () {
                            // TODO: open the job details / apply page
                          },
                        ),
                      );
                    },
                  ),
                ),

                // footer
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    isMobile ? 16 : 32,
                    6,
                    isMobile ? 16 : 32,
                    24,
                  ),
                  child:
                      isMobile
                          ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Can’t find the right role? Send us your CV and we’ll get in touch.',
                                style: GoogleFonts.manrope(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: tBlackLight.withOpacity(0.7),
                                ),
                              ),
                              const SizedBox(height: 12),
                              _dialogCloseButton(dialogContext),
                            ],
                          )
                          : Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Can’t find the right role? Send us your CV and we’ll get in touch.',
                                  style: GoogleFonts.manrope(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: tBlackLight.withOpacity(0.7),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              _dialogCloseButton(dialogContext),
                            ],
                          ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _dialogCloseButton(BuildContext dialogContext) {
    return OutlinedButton(
      onPressed: () => Navigator.of(dialogContext).pop(),
      style: OutlinedButton.styleFrom(
        foregroundColor: tBlue1,
        side: const BorderSide(color: tBlue1),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        'Close',
        style: GoogleFonts.manrope(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: tBlue1,
        ),
      ),
    );
  }

  /// Desktop: one row with dividers.
  /// Tablet: 3 per row.  Mobile: 2 per row.
  Widget _achievementsLayout(List<Widget> children) {
    if (!isTablet && !isMobile) {
      return LayoutBuilder(
        builder: (context, constraints) {
          // Wide enough: the original desktop layout, completely untouched.
          if (constraints.maxWidth >= 1300) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: children,
            );
          }

          // Narrower desktop (e.g. Surface Pro landscape, ~1100-1500px):
          // each item gets an equal slot and scales down only if it needs to.
          final items = [
            for (int i = 0; i < children.length; i += 2) children[i],
          ];
          return Row(
            children: [
              for (int i = 0; i < items.length; i++) ...[
                if (i > 0) _divider(margin: 12),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    child: items[i],
                  ),
                ),
              ],
            ],
          );
        },
      );
    }
    // children = [item, divider, item, divider, ...] -> keep only the items
    final items = [for (int i = 0; i < children.length; i += 2) children[i]];
    final int columns = isMobile ? 2 : 3;
    return LayoutBuilder(
      builder: (context, constraints) {
        final double gap = isMobile ? 12 : 16;
        final w = ((constraints.maxWidth - gap * (columns - 1)) / columns)
            .clamp(0.0, double.infinity);
        return Wrap(
          spacing: gap,
          runSpacing: isMobile ? 18 : 14,
          children: [for (final i in items) SizedBox(width: w, child: i)],
        );
      },
    );
  }
  // =====================================================================
  //                           END CAREERS SECTION
  // =====================================================================

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
      padding:
          isMobile
              ? const EdgeInsets.symmetric(horizontal: 16, vertical: 18)
              : const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: _achievementsLayout([
        buildAchievementsCard(
          icon: 'icons/collaboration.svg',
          title: '110+',
          subtitle: 'Team Members',
        ),
        _divider(),
        buildAchievementsCard(
          icon: 'icons/badge.svg',
          title: '13+',
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
          title: '150+',
          subtitle: 'Products Delivered',
        ),
        _divider(),
        buildAchievementsCard(
          icon: 'icons/manufacture.svg',
          title: '6L+',
          subtitle: 'Units Manufactured',
        ),
        _divider(),
        buildAchievementsCard(
          icon: 'icons/handshake.svg',
          title: '25+',
          subtitle: 'Happy Clients',
        ),
      ]),
    );
  }

  // Mission and Vision as 2 separate cards (side by side on desktop,
  // stacked on tablet and mobile).
  Widget _buildMissionVisionColumn() {
    final Widget mission = _missionVisionBox(
      icon: 'icons/impact.svg',
      title: 'Our Mission',
      description:
          'To deliver innovative and reliable engineering solutions that empower businesses and improve lives through technology and excellence.',
    );
    final Widget vision = _missionVisionBox(
      icon: 'icons/vision.svg',
      title: 'Our Vision',
      description:
          'To become a global leader in engineering innovation, driving sustainable growth and creating lasting value for our customers.',
      iconRight: !isMobile, // on mobile the icon stays on the left
    );

    if (isTablet || isMobile) {
      return Column(
        children: [mission, SizedBox(height: isMobile ? 14 : 16), vision],
      );
    }

    return Row(
      children: [
        Expanded(child: mission),
        const SizedBox(width: 20),
        Expanded(child: vision),
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
      height: (isTablet || isMobile) ? null : 114,
      padding:
          isMobile
              ? const EdgeInsets.symmetric(horizontal: 16, vertical: 18)
              : const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
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

  /// Desktop: spaced row. Tablet: row of equal columns. Mobile: 2 x 2 grid.
  Widget _heroCardsLayout({required List<Widget> children}) {
    if (isMobile) {
      final double screenW = MediaQuery.of(context).size.width;
      const double hPad = 20;
      const double gap = 16;
      final double cardW = ((screenW - (hPad * 2) - gap) / 2).floorToDouble();
      return Wrap(
        spacing: gap,
        runSpacing: 22,
        children: [for (final c in children) SizedBox(width: cardW, child: c)],
      );
    }
    if (isTablet) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < children.length; i++) ...[
            if (i > 0) const SizedBox(width: 16),
            Expanded(child: children[i]),
          ],
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }

  Widget _buildHeaderIntroCard({
    required String icon,
    required String title,
    required String description,
  }) {
    return SizedBox(
      width: isMobile ? double.infinity : 150,
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
            maxLines: isMobile ? 3 : 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              color: tWhite.withOpacity(0.7),
              fontSize: isMobile ? 11.5 : 12,
              height: isMobile ? 1.35 : null,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HERO (same structure as the Manufacturing hero)
  // ---------------------------------------------------------------------------
  Widget _buildAboutUsHeader() {
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
                child: _buildBlendedAboutImage(),
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
                        child: _buildAboutHeroTextColumn(),
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
          // Extra bottom padding keeps the hero cards clear of the overlapping
          // achievements card.
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 28 + _mobileRibbonOverlap),
            child: _buildAboutHeroTextColumn(),
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
          colors: [tBlack, tBlack, tTransparent],
          stops: [0.0, 0.6, 1.0],
        ).createShader(rect);
      },
      child: Image.asset(
        'images/company.png',
        fit: BoxFit.cover,
        alignment: Alignment.centerRight,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: tBlue2,
            alignment: Alignment.center,
            child: Icon(
              Icons.image_not_supported_outlined,
              size: 48,
              color: tWhite.withOpacity(0.55),
            ),
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
          colors: [tTransparent, tBlack2, tBlack],
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
          colors: [tBlack, tBlack, tTransparent],
          stops: [0.0, 0.80, 1.0],
        ).createShader(rect);
      },
      child: horizontallyFaded,
    );
  }

  /// Left side: label, title, description and the 4 value cards.
  Widget _buildAboutHeroTextColumn() {
    final double screenW = MediaQuery.of(context).size.width;
    final bool compact = screenW < 380; // medium phones
    final double headingSize =
        isMobile ? (compact ? 25 : 30) : (isTablet ? 34 : 48);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroAnimatedText(
          isActive: widget.isActive,
          delay: 20,
          child: Text(
            'About TrakMate',
            style: GoogleFonts.manrope(
              fontSize: isMobile ? 12 : 13,
              fontWeight: FontWeight.w600,
              color: tOrange1,
            ),
          ),
        ),
        SizedBox(height: isMobile ? 12 : 20),
        HeroAnimatedText(
          isActive: widget.isActive,
          delay: 120,
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.manrope(
                fontSize: headingSize,
                fontWeight: FontWeight.w600,
                height: isMobile ? 1.2 : 1.15,
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
        SizedBox(height: isMobile ? 14 : 20),
        HeroAnimatedText(
          isActive: widget.isActive,
          delay: 320,
          child: Text(
            'TrakMate is a product engineering and manufacturing company delivering end-to-end solutions in IoT, Embedded Systems, Software, Hardware Design and Manufacturing.',
            style: GoogleFonts.manrope(
              fontSize: 13,
              color: tWhite,
              fontWeight: FontWeight.w400,
              height: isMobile ? 1.55 : null,
            ),
          ),
        ),
        SizedBox(height: isMobile ? 26 : 40),
        _heroCardsLayout(
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
    final double circle = isMobile ? 54 : 70;
    final Widget iconCircle = Container(
      width: circle,
      height: circle,
      decoration: const BoxDecoration(color: tBlue3, shape: BoxShape.circle),
      child: Center(
        child: SvgPicture.asset(
          icon,
          width: isMobile ? 28 : 35,
          height: isMobile ? 28 : 35,
          color: tWhite,
        ),
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
              fontSize: isMobile ? 12.5 : 13,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
        ],
      ),
    );

    final double gap = isMobile ? 14 : 15;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:
          iconRight
              ? [textBlock, SizedBox(width: gap), iconCircle]
              : [iconCircle, SizedBox(width: gap), textBlock],
    );
  }

  Widget buildAchievementsCard({
    required String icon,
    required String title,
    required String subtitle,
  }) {
    final double iconSize = isMobile ? 32 : 40;

    final Widget texts = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.manrope(
            color: tBlue2,
            fontSize: isMobile ? 17 : 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: GoogleFonts.manrope(
            color: tBlue2,
            fontSize: isMobile ? 11.5 : 12,
            fontWeight: FontWeight.w500,
            height: isMobile ? 1.3 : 1.5,
          ),
        ),
      ],
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          icon,
          width: iconSize,
          height: iconSize,
          color: tOrange1,
        ),
        SizedBox(width: isMobile ? 10 : 15),
        // On mobile the text may wrap instead of overflowing.
        if (isMobile) Expanded(child: texts) else texts,
      ],
    );
  }

  Widget _divider({double margin = 30}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin),
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

  // ===================== OUR STORY (arrow infographic) =====================
  Widget _infrastructureBrickLayout() {
    const steps = <_StoryStep>[
      _StoryStep(
        icon: 'icons/innovation.svg',
        title: 'Foundation & Vision',
        description: 'Where our journey began.',
        color: tStoryYellow,
        darkColor: tStoryYellowDark,
      ),
      _StoryStep(
        icon: 'icons/impact.svg',
        title: 'Innovation & Expansion',
        description: 'Growing our capabilities through new ideas.',
        color: tStoryGreen,
        darkColor: tStoryGreenDark,
      ),
      _StoryStep(
        icon: 'icons/collaboration.svg',
        title: 'Connected Growth',
        description: 'Building stronger solutions and partnerships.',
        color: tStoryTeal,
        darkColor: tStoryTealDark,
      ),
      _StoryStep(
        icon: 'icons/globe.svg',
        title: 'Global Reach',
        description: 'Expanding our presence across new markets.',
        color: tStoryRed,
        darkColor: tStoryRedDark,
      ),
      _StoryStep(
        icon: 'icons/manufacture.svg',
        title: 'Future & Evolution',
        description: 'Continuously shaping what comes next.',
        color: tStoryPurple,
        darkColor: tStoryPurpleDark,
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
    final Color base = Color.lerp(tOrange1, tWhite, t * maxFade)!;
    final Color shade = Color.lerp(base, tBlack, 0.10)!;

    return CustomPaint(
      painter: _StoryChevronPainter(top: base, bottom: shade, notch: notch),
      child: Padding(
        padding: EdgeInsets.fromLTRB(notch + 6, 14, notch + 6, 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(s.icon, width: 36, height: 36, color: tWhite),
            const SizedBox(height: 10),
            Text(
              s.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.manrope(
                color: tWhite,
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
                color: tWhite.withOpacity(0.92),
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

  // ---------------------------- LEADERSHIP ----------------------------
  Widget _ourTeamSection() {
    final Widget intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Meet Our Leadership",
          style: GoogleFonts.manrope(
            color: tBlack,
            fontSize: isMobile ? 24 : 30,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
        const SizedBox(height: 10),
        Container(width: 75, height: 2, color: tOrange1),
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
        SizedBox(height: (isTablet || isMobile) ? 0 : 15),
      ],
    );

    final double cardGap = isMobile ? 10 : (isTablet ? 16 : 20);

    // Smallest width a card may shrink to. Below this the row scrolls.
    // Chosen so the current 3 cards fit on every screen.
    final double minCardWidth = isMobile ? 88 : (isTablet ? 190 : 185);

    // To add a leader later, just add one more entry here.
    final List<Map<String, String>> leaders = [
      {
        'image': 'images/img2.jpg',
        'name': 'NL Srinivas',
        'designation': 'Co-Founder & CEO',
      },
      {
        'image': 'images/img1.jpg',
        'name': 'M Pramod',
        'designation': 'Co-Founder & COO',
      },
      {
        'image': 'images/img2.jpg',
        'name': 'S Srinivasa',
        'designation': 'Co-Founder & CTO',
      },
    ];

    final Widget cards = LayoutBuilder(
      builder: (context, constraints) {
        final int n = leaders.length;
        final double needed = n * minCardWidth + (n - 1) * cardGap;

        Widget card(Map<String, String> l) => buildTeamProfileCard(
          image: l['image']!,
          name: l['name']!,
          designation: l['designation']!,
        );

        // Fits: exactly the same layout as before, no scrolling.
        if (constraints.maxWidth >= needed) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (int i = 0; i < n; i++) ...[
                if (i > 0) SizedBox(width: cardGap),
                Expanded(child: card(leaders[i])),
              ],
            ],
          );
        }

        // Does not fit: cards keep the minimum width and the row scrolls.
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            children: [
              for (int i = 0; i < n; i++) ...[
                if (i > 0) SizedBox(width: cardGap),
                SizedBox(width: minCardWidth, child: card(leaders[i])),
              ],
            ],
          ),
        );
      },
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: _pad, vertical: 10),
      child:
          (isTablet || isMobile)
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [intro, SizedBox(height: isMobile ? 20 : 24), cards],
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 2, child: intro),
                  const SizedBox(width: 80),
                  Expanded(flex: 4, child: cards),
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
              height: isMobile ? 115 : 150,
              width: double.infinity,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
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
                    (context, error, stackTrace) => Container(
                      color: tBlack.withOpacity(0.04),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: tBlack.withOpacity(0.25),
                      ),
                    ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: isMobile ? 4 : 0,
              ),
              child: Column(
                children: [
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      fontSize: isMobile ? 12 : 14,
                      fontWeight: FontWeight.w700,
                      color: tBlack,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    designation,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      fontSize: isMobile ? 10.5 : 12,
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

                    const Spacer(),

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

  // ---------------------------- CERTIFICATIONS ----------------------------
  Widget _buildCertificationsSection() {
    return Column(
      children: [
        Text(
          "CERTIFICATIONS",
          style: GoogleFonts.manrope(
            fontSize: isMobile ? 12 : 13,
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
            fontSize: isMobile ? 20 : 25,
            fontWeight: FontWeight.w700,
            color: tBlue2,
            height: isMobile ? 1.2 : null,
          ),
        ),

        SizedBox(height: isMobile ? 18 : 10),
        if (isTablet || isMobile)
          LayoutBuilder(
            builder: (context, c) {
              const double gap = 16;
              final int columns = isMobile ? 2 : 4;
              final double w = ((c.maxWidth - gap * (columns - 1)) / columns)
                  .clamp(0.0, double.infinity);
              return Wrap(
                alignment: WrapAlignment.center,
                spacing: gap,
                runSpacing: 20,
                children: [
                  for (final cert in _certs)
                    SizedBox(width: w, child: _buildCertificationCard(cert)),
                ],
              );
            },
          )
        else
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
    this.fillColor = tTimelineCard,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint = Paint()..color = fillColor;

    final Paint borderPaint =
        Paint()
          ..color = tTimelinePointerBorder
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

// ---------- Careers helpers ----------
class _JobData {
  final String title;
  final String location;
  final String type;
  final String experience;
  final IconData icon;
  final Color accent;

  const _JobData({
    required this.title,
    required this.location,
    required this.type,
    required this.experience,
    required this.icon,
    required this.accent,
  });

  /// Soft tint of [accent] used behind the icon and in the experience pill.
  Color get background => accent.withOpacity(0.12);
}

/// Draws a dashed rounded-rectangle border (used by the CV upload box).
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double dashWidth;
  final double dashGap;
  final double strokeWidth;

  const _DashedBorderPainter({
    required this.color,
    this.radius = 16,
    this.dashWidth = 5,
    this.dashGap = 4,
    this.strokeWidth = 1.2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;

    final Path path =
        Path()..addRRect(
          RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
        );

    for (final PathMetric metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final double end = (distance + dashWidth).clamp(0, metric.length);
        canvas.drawPath(metric.extractPath(distance, end.toDouble()), paint);
        distance += dashWidth + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter old) =>
      old.color != color ||
      old.radius != radius ||
      old.dashWidth != dashWidth ||
      old.dashGap != dashGap ||
      old.strokeWidth != strokeWidth;
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
    canvas.drawShadow(path, tBlack.withOpacity(0.35), 6, false);

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
