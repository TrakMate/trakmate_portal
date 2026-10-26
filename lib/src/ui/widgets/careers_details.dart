import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmer_effect.dart';
import 'package:trakmate_portal/src/utils/responsive.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/colors.dart';

class _Svg {
  _Svg._();

  // Job icons (one per opening)
  static const String jobEmbeddedEngineer = 'icons/embedded1.svg';
  static const String jobSeniorEmbeddedEngineer = 'icons/embedded_systems.svg';
  static const String jobProductionManager = 'icons/product_engineering.svg';
  static const String jobAndroidHmiDeveloper = 'icons/android_developer2.svg';
  static const String jobHrManager = 'icons/hr_manager.svg';

  // Hero
  static const String heroErrorBlended = 'icons/image_remove.svg';
  static const String heroErrorMobile = 'icons/image_remove.svg';

  // Filter row
  static const String filterSearch = 'icons/search2.svg';
  static const String filterLocationPin = 'icons/location1.svg';

  // Job meta row
  static const String metaLocation = 'icons/location1.svg';
  static const String metaJobType = 'icons/clock.svg';
  static const String metaExperience = 'icons/calender.svg';

  // Apply button inside details panel
  static const String applyUpload = 'icons/cloud_upload.svg';

  // "Don't see a suitable role?" card
  static const String planeSend = 'icons/paper_plane.svg';
  static const String uploadBoxCloud = 'icons/cloud_upload.svg';

  // Why join cards
  static const String whyMeaningfulWork = 'icons/innovation.svg';
  static const String whySupportiveTeam = 'icons/team.svg';
  static const String whyContinuousGrowth = 'icons/growth2.svg';
  static const String whyWorkLifeBalance = 'icons/heart1.svg';

  // Follow us on LinkedIn card
  static const String linkedInMail = 'icons/linkedin2.svg';
  static const String linkedInOpenNew = 'icons/click_here.svg';
}

class _SvgIcon extends StatelessWidget {
  final String asset;
  final double size;
  final Color? color;
  const _SvgIcon(this.asset, {required this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: size,
      height: size,
      fit: BoxFit.contain,
      colorFilter:
          color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
    );
  }
}

class CareersPage extends StatefulWidget {
  final String heroImageAsset;
  final String secondaryImageAsset; // kept so existing callers don't break
  const CareersPage({
    super.key,
    this.heroImageAsset = 'images/career_hero.png',
    this.secondaryImageAsset = 'images/desk.png',
  });
  @override
  State<CareersPage> createState() => _CareersPageState();
}

class _Job {
  final String title;
  final String category;
  final String location;
  final String type;
  final String experience;
  final String description;
  final List<String> responsibilities;
  final List<String> requirements;
  final String iconAsset; // SVG asset path
  const _Job({
    required this.title,
    required this.category,
    required this.location,
    required this.type,
    required this.experience,
    required this.description,
    required this.responsibilities,
    required this.requirements,
    required this.iconAsset,
  });
}

class _CareersPageState extends State<CareersPage> {
  /// CVs are mailed to this address. Change it here whenever you like.
  static const String _careersEmail = 'keerthiprasad267@gmail.com';

  /// Company LinkedIn page opened by the "Click here" button.
  static const String _linkedInUrl =
      'https://www.linkedin.com/company/trakmate-design-solutions-private-limited/home/';

  // Breakpoints come from ResponsiveLayout:
  //   mobile  < 700   |   tablet 700 - 1099   |   desktop >= 1100
  bool get isMobile => ResponsiveLayout.isMobile(context);
  bool get isTablet => ResponsiveLayout.isTablet(context);

  // Horizontal page padding
  double get _pad => isMobile ? 16 : (isTablet ? 24 : 40);

  // Filter tabs – must match the `category` values used in _jobs below.
  static const List<String> _tabs = ['All Roles', 'Engineering', 'Operations'];

  static const List<String> _locations = ['All Locations', 'Bengaluru, India'];

  static const List<_Job> _jobs = [
    _Job(
      title: 'Embedded Engineer',
      category: 'Engineering',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '0 - 3 Yrs',
      description:
          'Build and test firmware for our telematics devices and learn hands-on with real connected-vehicle hardware.',
      responsibilities: [
        'Develop and test firmware for telematics devices in C / C++.',
        'Work with GPS, GSM / LTE and sensor modules.',
        'Debug hardware and firmware issues using lab tools.',
        'Support field testing and device validation.',
      ],
      requirements: [
        '0 - 3 years of experience in embedded systems development.',
        'Good knowledge of C / C++ and microcontroller fundamentals.',
        'Familiarity with UART, SPI, I2C protocols.',
        'Freshers with strong embedded projects are welcome.',
      ],
      iconAsset: _Svg.jobEmbeddedEngineer,
    ),
    _Job(
      title: 'Senior Embedded Engineer',
      category: 'Engineering',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '3 - 6 Yrs',
      description:
          'Lead the design and development of next-generation telematics firmware and contribute to innovative IoT solutions.',
      responsibilities: [
        'Own firmware architecture and development for telematics devices.',
        'Work with GPS, GSM / LTE, CAN and sensor modules.',
        'Review code and mentor junior embedded engineers.',
        'Support field testing and device certification.',
      ],
      requirements: [
        '3 - 6 years of experience in embedded systems development.',
        'Strong knowledge of ARM Cortex-M and RTOS.',
        'Experience with UART, SPI, I2C and CAN protocols.',
        'Telematics or automotive background is a plus.',
      ],
      iconAsset: _Svg.jobSeniorEmbeddedEngineer,
    ),
    _Job(
      title: 'Production Manager',
      category: 'Operations',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '4 - 7 Yrs',
      description:
          'Plan and manage day-to-day production so our devices are built on time, to quality and within cost.',
      responsibilities: [
        'Plan and oversee production schedules and daily output.',
        'Ensure quality standards and process compliance on the line.',
        'Coordinate with procurement, design and quality teams.',
        'Manage production staff, productivity and shop-floor safety.',
      ],
      requirements: [
        '4 - 7 years of experience in production or manufacturing management.',
        'Experience in electronics or automotive manufacturing is a plus.',
        'Strong leadership and problem-solving skills.',
        'Knowledge of lean manufacturing and quality systems.',
      ],
      iconAsset: _Svg.jobProductionManager,
    ),
    _Job(
      title: 'Android HMI Developer',
      category: 'Engineering',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '2 - 4 Yrs',
      description:
          'Build smooth, intuitive Android apps for our fleet management and vehicle tracking products.',
      responsibilities: [
        'Build and maintain Android applications using Kotlin / Java.',
        'Integrate REST APIs and real-time vehicle data.',
        'Write clean, testable code and take part in code reviews.',
        'Work with design and backend teams to ship features on time.',
      ],
      requirements: [
        '2 - 4 years of hands-on experience in Android development.',
        'Strong knowledge of Kotlin, Jetpack and MVVM architecture.',
        'Experience with maps, tracking or IoT applications is a plus.',
        'Apps published on the Play Store.',
      ],
      iconAsset: _Svg.jobAndroidHmiDeveloper,
    ),
    _Job(
      title: 'HR Manager',
      category: 'Operations',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '2 - 5 Yrs',
      description:
          'Lead hiring, onboarding and people practices to help our team grow and thrive.',
      responsibilities: [
        'Manage end-to-end recruitment and onboarding.',
        'Maintain HR policies, records and compliance.',
        'Handle employee engagement, performance and grievance processes.',
        'Partner with team leads on workforce planning.',
      ],
      requirements: [
        '2 - 5 years of experience in HR or talent management.',
        'Strong communication and interpersonal skills.',
        'Knowledge of HR policies and labour compliance.',
        'Experience in a technology or manufacturing company is a plus.',
      ],
      iconAsset: _Svg.jobHrManager,
    ),
  ];
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _openingsKey = GlobalKey();
  final GlobalKey _submitCvKey = GlobalKey();
  final TextEditingController _searchController = TextEditingController();
  int _selectedTab = 0;
  String _selectedLocation = _locations.first;
  String _query = '';

  /// Title of the opening whose details are currently expanded (null = none).
  String? _expandedJob;

  bool _uploadHovered = false;
  bool _heroImageLoading = true;

  // ── Location dropdown (custom overlay that opens BELOW the field) ──
  final LayerLink _locationLink = LayerLink();
  final GlobalKey _locationFieldKey = GlobalKey();
  OverlayEntry? _locationOverlay;
  bool _locationOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _preloadHeroImage());
  }

  Future<void> _preloadHeroImage() async {
    try {
      await precacheImage(
        AssetImage(widget.heroImageAsset), // uses the page's hero image
        context,
        onError: (e, s) => debugPrint('Failed to load careers hero: $e'),
      ).timeout(const Duration(seconds: 10)); // never stay stuck on shimmer
    } catch (e) {
      // debugPrint('Error preloading careers hero image: $e');
    }
    await Future.delayed(const Duration(seconds: 3)); //fr testing
    if (!mounted) return;
    setState(() => _heroImageLoading = false);
  }

  @override
  void dispose() {
    _locationOverlay?.remove();
    _locationOverlay = null;
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<_Job> get _filteredJobs {
    final q = _query.trim().toLowerCase();
    return _jobs.where((j) {
      final tabOk = _selectedTab == 0 || j.category == _tabs[_selectedTab];
      final locOk =
          _selectedLocation == _locations.first ||
          j.location == _selectedLocation;
      final qOk =
          q.isEmpty ||
          j.title.toLowerCase().contains(q) ||
          j.description.toLowerCase().contains(q) ||
          j.location.toLowerCase().contains(q) ||
          j.category.toLowerCase().contains(q);
      return tabOk && locOk && qOk;
    }).toList();
  }

  void _scrollToOpenings() {
    final ctx = _openingsKey.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToSubmitCv() {
    final ctx = _submitCvKey.currentContext;
    if (ctx == null) return;

    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      alignment: 0.1,
    );
  }

  void _toggleJob(_Job job) {
    setState(() {
      _expandedJob = _expandedJob == job.title ? null : job.title;
    });
  }

  // ───────────────────── LOCATION DROPDOWN LOGIC ─────────────────────
  void _toggleLocationMenu() {
    if (_locationOpen) {
      _closeLocationMenu();
    } else {
      _openLocationMenu();
    }
  }

  void _closeLocationMenu() {
    _locationOverlay?.remove();
    _locationOverlay = null;
    if (mounted && _locationOpen) {
      setState(() => _locationOpen = false);
    }
  }

  void _openLocationMenu() {
    final box = _locationFieldKey.currentContext?.findRenderObject();
    if (box is! RenderBox) return;
    final double width = box.size.width;

    _locationOverlay = OverlayEntry(
      builder: (overlayContext) {
        return Stack(
          children: [
            // Transparent barrier: tapping anywhere outside closes the menu.
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _closeLocationMenu,
              ),
            ),
            CompositedTransformFollower(
              link: _locationLink,
              showWhenUnlinked: false,
              targetAnchor: Alignment.bottomLeft,
              followerAnchor: Alignment.topLeft,
              offset: const Offset(0, 6), // gap below the field
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(width: width, child: _buildLocationMenu()),
              ),
            ),
          ],
        );
      },
    );
    Overlay.of(context).insert(_locationOverlay!);
    setState(() => _locationOpen = true);
  }

  /// The floating card (rounded, white, soft shadow) with the options.
  Widget _buildLocationMenu() {
    return Material(
      color: tTransparent,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: tWhite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: tBlueLight.withOpacity(0.55)),
          boxShadow: [
            BoxShadow(
              color: tBlack.withOpacity(0.12),
              blurRadius: 22,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:
              _locations.map((l) {
                return _LocationMenuItem(
                  label: l,
                  selected: l == _selectedLocation,
                  onTap: () {
                    setState(() => _selectedLocation = l);
                    _closeLocationMenu();
                  },
                );
              }).toList(),
        ),
      ),
    );
  }

  /// Opens the visitor's mail app / webmail straight away with the careers
  /// address, subject and body pre-filled (same approach as the Get in Touch
  /// dialog). A mailto link cannot carry attachments, so the visitor attaches
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

  /// Confirmation dialog (replaces the snack bar). Returns true when the
  /// visitor taps "Okay", false / null on Cancel or when dismissed.
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
          surfaceTintColor: Colors.transparent,
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

  /// Opens the company LinkedIn page in a new tab.
  Future<void> _openLinkedIn() async {
    final Uri url = Uri.parse(_linkedInUrl);
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (_) {
      _toast('Could not open LinkedIn. Please try again.');
    }
  }

  void _getJobAlerts() {
    // TODO: hook this up to your job-alerts / newsletter subscription flow.
    _toast('Job alerts will be available soon.');
  }

  void _toast(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: GoogleFonts.manrope(fontSize: 13)),
          backgroundColor: tBlue4,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  // ───────────────────────── BUILD ─────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tWhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            // back button
            padding: EdgeInsets.fromLTRB(_pad, isMobile ? 14 : 22, _pad, 0),
            child: _buildBackButton(context),
          ),
          SizedBox(height: isMobile ? 14 : 25),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Full-width hero (shimmer until the image is cached).
                  _heroImageLoading ? const HeroHeaderShimmer() : _buildHero(),
                  SizedBox(height: isMobile ? 24 : 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: _pad),
                    child: _buildBody(),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: tTransparent,
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
          borderRadius: BorderRadius.circular(7),
          onTap: () {
            if (context.canPop()) {
              context.pop(); // came from About Us: go back to it
            } else {
              // opened or refreshed directly on /about_us/careers
              context.go('/about');
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back_rounded, size: 18, color: tBlue3),
                const SizedBox(width: 7),
                Text(
                  'Back',
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: tBlue3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ───────────────────────── HERO ─────────────────────────
  // Same structure as the Manufacturing hero: full-width, same blue gradient,
  // same text colours. Mobile = image on top, text below.
  Widget _buildHero() {
    if (isMobile) return _buildMobileHero();

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
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
              isTablet
                  ? constraints.maxWidth * 0.5
                  : (constraints.maxWidth * 0.55).clamp(300.0, 900.0);
          final bool showImage = isTablet || constraints.maxWidth > 760;

          return Stack(
            children: [
              // ── 1) IMAGE LAYER (behind the text), blended into the blue ──
              if (showImage)
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  width: imageWidth,
                  child: _buildBlendedHeroImage(),
                ),

              // ── 2) CONTENT LAYER (text) on top ──
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 400),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 24 : 110,
                    vertical: 25,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: isTablet ? 8 : 1,
                        child: _buildHeroTextColumn(),
                      ),
                      if (showImage) ...[
                        SizedBox(width: isTablet ? 0 : 40),
                        // Empty half: the image is visible behind this space.
                        const Expanded(child: SizedBox()),
                      ],
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
      decoration: const BoxDecoration(
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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
            child: _buildHeroTextColumn(),
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
          colors: [Colors.black, Colors.black, Colors.transparent],
          stops: [0.0, 0.6, 1.0],
        ).createShader(rect);
      },
      child: Image.asset(
        widget.heroImageAsset,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: tBlue2,
            alignment: Alignment.center,
            child: _SvgIcon(
              _Svg.heroErrorMobile,
              size: 48,
              color: tWhite.withOpacity(0.55),
            ),
          );
        },
      ),
    );
  }

  /// The hero image with its LEFT edge (and a bit of the BOTTOM edge)
  /// faded to transparent, so it melts into the blue background.
  Widget _buildBlendedHeroImage() {
    // Horizontal fade: left = invisible → right = fully visible
    final Widget horizontallyFaded = ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.transparent, Colors.black54, Colors.black],
          // 0.00 → 0.55 is the blend zone. Make 0.55 bigger for a softer,
          // longer blend; smaller for a sharper edge.
          stops: [0.0, 0.30, 0.55],
        ).createShader(rect);
      },
      child: Image.asset(
        widget.heroImageAsset,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: tBlack.withOpacity(0.05),
            alignment: Alignment.center,
            child: _SvgIcon(
              _Svg.heroErrorBlended,
              size: 50,
              color: tWhite.withOpacity(0.6),
            ),
          );
        },
      ),
    );

    return horizontallyFaded;
  }

  /// Left side: label, title, description and button (Engineering styling).
  Widget _buildHeroTextColumn() {
    final double screenW = MediaQuery.of(context).size.width;
    final bool compact = screenW < 380; // medium phones
    final double headingSize =
        isMobile ? (compact ? 25 : 30) : (isTablet ? 34 : 48);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CAREERS AT TRAKMATE',
          style: GoogleFonts.manrope(
            fontSize: isMobile ? 12 : 13,
            fontWeight: FontWeight.w600,
            color: tOrange1,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: isMobile ? 12 : 20),
        RichText(
          text: TextSpan(
            style: GoogleFonts.manrope(
              fontSize: headingSize,
              fontWeight: FontWeight.w600,
              height: isMobile ? 1.2 : 1.15,
              color: tWhite,
            ),
            children: [
              const TextSpan(text: 'Be Part of Building the\n'),
              TextSpan(
                text: 'Future of Connected Mobility',
                style: TextStyle(color: tOrange1, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
        SizedBox(height: isMobile ? 14 : 20),
        Text(
          'Join a team that’s building smarter, safer and more connected mobility for tomorrow.',
          style: GoogleFonts.manrope(
            fontSize: isMobile ? 13.5 : 15,
            color: tWhite,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
        SizedBox(height: isMobile ? 22 : 28),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: _scrollToSubmitCv,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
              decoration: BoxDecoration(
                color: tOrange1,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Join Our Network',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: tWhite,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.arrow_downward_rounded,
                    size: 16,
                    color: tWhite,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ───────────────────────── BODY ─────────────────────────
  Widget _buildBody() {
    return Padding(
      key: _openingsKey,
      padding: EdgeInsets.symmetric(
        horizontal: (isTablet || isMobile) ? 0 : 62,
      ),
      child: LayoutBuilder(
        builder: (context, c) {
          final wide = !isTablet && !isMobile && c.maxWidth > 900;
          final jobs = _filteredJobs;
          if (wide) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildFilterRow(wide: true),
                const SizedBox(height: 28),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 62, child: _buildOpenings(jobs)),
                    const SizedBox(width: 40),
                    Expanded(flex: 38, child: _buildCvPanel()),
                  ],
                ),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildFilterRow(wide: false),
              const SizedBox(height: 24),
              _buildOpenings(jobs),
              const SizedBox(height: 30),
              _buildCvPanel(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilterRow({required bool wide}) {
    final tabs = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_tabs.length, (i) {
          final selected = i == _selectedTab;
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = i),
              child: Container(
                margin: EdgeInsets.only(right: isMobile ? 22 : 34),
                padding: const EdgeInsets.only(bottom: 12, top: 6),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: selected ? tBlueDark : tTransparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  _tabs[i],
                  style: GoogleFonts.manrope(
                    fontSize: 13.5,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: selected ? tBlueDark : tBlack,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
    final search = Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tBlueLight.withOpacity(0.8)),
      ),
      child: Row(
        children: [
          const _SvgIcon(_Svg.filterSearch, size: 20, color: tBlue4),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _query = v),
              style: GoogleFonts.manrope(fontSize: 13, color: tBlack),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: 'Search by role, skill or location...',
                hintStyle: GoogleFonts.manrope(fontSize: 13, color: tGrey),
              ),
            ),
          ),
        ],
      ),
    );

    // Location field: tapping it opens the custom menu right BELOW the field.
    final location = CompositedTransformTarget(
      link: _locationLink,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          key: _locationFieldKey,
          behavior: HitTestBehavior.opaque,
          onTap: _toggleLocationMenu,
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: tWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _locationOpen ? tBlueDark : tBlueLight.withOpacity(0.8),
              ),
            ),
            child: Row(
              children: [
                const _SvgIcon(_Svg.filterLocationPin, size: 19, color: tBlue4),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _selectedLocation,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: tBlack,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: _locationOpen ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 20,
                    color: tBlue4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (!wide) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          tabs,
          const SizedBox(height: 14),
          if (isTablet)
            Row(
              children: [
                Expanded(child: search),
                const SizedBox(width: 12),
                SizedBox(width: 190, child: location),
              ],
            )
          else ...[
            // mobile (and narrow desktop): stacked full-width
            search,
            const SizedBox(height: 12),
            location,
          ],
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: tBlueLight.withOpacity(0.6)),
              ),
            ),
            child: tabs,
          ),
        ),
        const SizedBox(width: 24),
        SizedBox(width: 345, child: search),
        const SizedBox(width: 14),
        SizedBox(width: 175, child: location),
      ],
    );
  }

  // ───────────────────────── OPENINGS ─────────────────────────
  Widget _buildOpenings(List<_Job> jobs) {
    final Widget titleBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current Openings',
          style: GoogleFonts.manrope(
            fontSize: isMobile ? 22 : 26,
            fontWeight: FontWeight.w800,
            color: tBlue4,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Find a role where you can grow, contribute and make an impact.',
          style: GoogleFonts.manrope(
            fontSize: isMobile ? 13 : 14,
            height: isMobile ? 1.45 : null,
            color: tBlue4.withOpacity(0.65),
          ),
        ),
      ],
    );
    final Widget count = Text(
      '${jobs.length} Open Positions',
      style: GoogleFonts.manrope(
        fontSize: 12.5,
        color: tBlue4.withOpacity(0.65),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isMobile) ...[
          titleBlock,
          const SizedBox(height: 10),
          count,
        ] else
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [Expanded(child: titleBlock), count],
          ),
        SizedBox(height: isMobile ? 22 : 28),
        if (jobs.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: Text(
                'No openings match your search.',
                style: GoogleFonts.manrope(fontSize: 14, color: tGrey1),
              ),
            ),
          )
        else
          ...List.generate(
            jobs.length,
            (i) => _buildJobRow(jobs[i], isLast: i == jobs.length - 1),
          ),
      ],
    );
  }

  Widget _iconCircle(_Job job, double size) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: tBlueDark.withOpacity(0.12),
      ),
      child: _SvgIcon(job.iconAsset, size: size * 0.45, color: tBlueDark),
    );
  }

  Widget _metaRow(_Job job) {
    Widget item(String asset, String text) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SvgIcon(asset, size: 15, color: tBlue4.withOpacity(0.6)),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.manrope(
            fontSize: 12.5,
            color: tBlue4.withOpacity(0.65),
          ),
        ),
      ],
    );
    return Wrap(
      spacing: isMobile ? 16 : 22,
      runSpacing: 6,
      children: [
        item(_Svg.metaLocation, job.location),
        item(_Svg.metaJobType, job.type),
        item(_Svg.metaExperience, job.experience),
      ],
    );
  }

  Widget _buildJobRow(_Job job, {required bool isLast}) {
    final expanded = _expandedJob == job.title;
    final double iconSize = isMobile ? 46 : 66;
    final double iconGap = isMobile ? 14 : 30;

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Timeline connector line (from this icon down to the next one).
          if (!isLast)
            Positioned(
              left: iconSize / 2 - 0.75,
              top: iconSize,
              bottom: -16,
              child: Container(width: 1.5, color: tBlueLight.withOpacity(0.7)),
            ),
          // Whole opening is clickable.
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _toggleJob(job),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _iconCircle(job, iconSize),
                  SizedBox(width: iconGap),
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(minHeight: iconSize),
                      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
                      decoration: BoxDecoration(
                        border:
                            isLast
                                ? null
                                : Border(
                                  bottom: BorderSide(
                                    color: tBlueLight.withOpacity(0.45),
                                  ),
                                ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  job.title,
                                  style: GoogleFonts.manrope(
                                    fontSize: isMobile ? 15 : 16,
                                    fontWeight: FontWeight.w800,
                                    color: tBlue4,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                _metaRow(job),
                                const SizedBox(height: 8),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 520,
                                  ),
                                  child: Text(
                                    job.description,
                                    style: GoogleFonts.manrope(
                                      fontSize: isMobile ? 12.5 : 13,
                                      height: 1.5,
                                      color: tBlue4.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                                // Expandable details – opens right below the opening.
                                AnimatedSize(
                                  duration: const Duration(milliseconds: 280),
                                  curve: Curves.easeInOut,
                                  alignment: Alignment.topCenter,
                                  child:
                                      expanded
                                          ? GestureDetector(
                                            // Absorb taps inside the panel so
                                            // clicking its text doesn't collapse it.
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {},
                                            child: MouseRegion(
                                              cursor: SystemMouseCursors.basic,
                                              child: _buildDetailsPanel(job),
                                            ),
                                          )
                                          : const SizedBox(
                                            width: double.infinity,
                                          ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: isMobile ? 10 : 16),
                          Padding(
                            padding: EdgeInsets.only(top: isMobile ? 2 : 14),
                            child: _viewDetails(job, expanded),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsPanel(_Job job) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: tBlueSky1,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tBlueLight.withOpacity(0.7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _detailSection('Responsibilities', job.responsibilities, tOrange1),
          const SizedBox(height: 18),
          _detailSection('Requirements', job.requirements, tOrange1),
          const SizedBox(height: 20),
          _buildApplyButton(job),
        ],
      ),
    );
  }

  /// "Apply with CV" – opens the mail app straight away (no file picker).
  Widget _buildApplyButton(_Job job) {
    return Align(
      key: const ValueKey('apply'),
      alignment: Alignment.centerLeft,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _openCvMail(jobTitle: job.title),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
            decoration: BoxDecoration(
              color: tBlueDark,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _SvgIcon(_Svg.applyUpload, size: 18, color: tWhite),
                const SizedBox(width: 10),
                Text(
                  'Apply with CV',
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: tWhite,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailSection(String title, List<String> items, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: tBlue4,
          ),
        ),
        const SizedBox(height: 10),
        ...items.map(
          (t) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    t,
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      height: 1.5,
                      color: tBlue4.withOpacity(0.75),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _viewDetails(_Job job, bool expanded) {
    final double circle = isMobile ? 34 : 42;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // The "View Details" label is hidden on mobile (only the arrow shows).
        if (!expanded && !isMobile) ...[
          Text(
            'View Details',
            style: GoogleFonts.manrope(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: tBlueDark,
            ),
          ),
          const SizedBox(width: 14),
        ],
        AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: circle,
          height: circle,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: expanded ? tOrange1 : tOrange1.withOpacity(0.12),
          ),
          child: Icon(
            expanded
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
            size: expanded ? 22 : 18,
            color: expanded ? tWhite : tOrange1,
          ),
        ),
      ],
    );
  }

  // ───────────────────────── RIGHT PANEL ─────────────────────────
  Widget _buildCvPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _heroImageLoading
            ? const ShimmerBox(
              height: 350,
              borderRadius: BorderRadius.all(Radius.circular(18)),
            )
            : _buildSubmitCvCard(),
        const SizedBox(height: 18),
        _buildWhyJoinCard(),
        const SizedBox(height: 18),
        _buildStayInformedCard(),
      ],
    );
  }

  /// Card 1 – "Don't see a suitable role?" + dashed upload box.
  Widget _buildSubmitCvCard() {
    final double planeW = isMobile ? 70 : 90;
    final double planeH = isMobile ? 50 : 60;

    return Container(
      key: _submitCvKey,
      padding: EdgeInsets.all(isMobile ? 18 : 22),
      decoration: BoxDecoration(
        color: tBlueSky1,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: tBlueLight.withOpacity(0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: EdgeInsets.only(right: isMobile ? 50 : 60),
                child: CustomPaint(
                  painter: _UnderlinePainter(color: tBlueDark),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 22),
                    child: Transform.rotate(
                      angle: -0.07,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Don’t see\n  a suitable role?',
                        style: GoogleFonts.caveat(
                          fontSize: isMobile ? 32 : 38,
                          height: 1.05,
                          fontWeight: FontWeight.w700,
                          color: tBlue4,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: -8,
                child: SizedBox(
                  width: planeW,
                  height: planeH,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Dashed flight path
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _PlanePathPainter(color: tOrange1),
                        ),
                      ),
                      // Plane (SVG) at the end of the path
                      Positioned(
                        left: planeW * 0.78,
                        top: 0,
                        child: Transform.rotate(
                          angle: 0.07,
                          child: const _SvgIcon(
                            _Svg.planeSend,
                            size: 28,
                            color: tOrange1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'We’re always excited to meet talented people. Share your CV and we’ll reach out when there’s a matching opportunity.',
            style: GoogleFonts.manrope(
              fontSize: isMobile ? 13 : 13.5,
              height: 1.55,
              color: tBlue4.withOpacity(0.85),
            ),
          ),
          const SizedBox(height: 18),
          _buildUploadBox(),
        ],
      ),
    );
  }

  /// "Upload Your CV" box – opens the mail app straight away (no file picker).
  Widget _buildUploadBox() {
    final bool active = _uploadHovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _uploadHovered = true),
      onExit: (_) => setState(() => _uploadHovered = false),
      child: GestureDetector(
        onTap: () => _openCvMail(),
        // Whole box grows slightly on hover.
        child: AnimatedScale(
          scale: active ? 1.02 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          // t goes 0 → 1 on hover and drives every colour / shadow change.
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: active ? 1 : 0),
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            builder: (context, t, _) {
              return CustomPaint(
                painter: _DashedRRectPainter(
                  color: tBlueDark.withOpacity(0.55 + 0.45 * t),
                  radius: 12,
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 14 : 18,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    color: tWhite.withOpacity(0.35 + 0.40 * t),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: tBlueDark.withOpacity(0.18 * t),
                        blurRadius: 18 * t,
                        offset: Offset(0, 6 * t),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Icon circle fills with blue and the icon floats up.
                      Container(
                        width: 52,
                        height: 52,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.lerp(
                            tBlueDark.withOpacity(0.12),
                            tBlueDark,
                            t,
                          ),
                        ),
                        child: Transform.translate(
                          offset: Offset(0, -3 * t),
                          child: _SvgIcon(
                            _Svg.uploadBoxCloud,
                            size: 26,
                            color: Color.lerp(tBlueDark, tWhite, t),
                          ),
                        ),
                      ),
                      SizedBox(width: isMobile ? 12 : 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Upload Your CV',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.manrope(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w800,
                                color: Color.lerp(tBlue4, tBlueDark, t),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Opens your mail – attach your CV there',
                              style: GoogleFonts.manrope(
                                fontSize: 11.5,
                                color: tBlue4.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Arrow slides in from the left on hover.
                      Opacity(
                        opacity: t,
                        child: Transform.translate(
                          offset: Offset(8 * (1 - t), 0),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 18,
                            color: tBlueDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Card 2 – "Why Join TrakMate?" 2x2 tiles (blue / orange only).
  /// On mobile the 4 tiles are stacked in a single column.
  Widget _buildWhyJoinCard() {
    final Widget meaningful = _whyTile(
      iconAsset: _Svg.whyMeaningfulWork,
      color: tOrange1,
      title: 'Meaningful Work',
      text: 'Solve real-world challenges in connected mobility.',
    );
    final Widget supportive = _whyTile(
      iconAsset: _Svg.whySupportiveTeam,
      color: tBlueDark,
      title: 'Supportive Team',
      text: 'Collaborative, inclusive and driven by growth.',
    );
    final Widget growth = _whyTile(
      iconAsset: _Svg.whyContinuousGrowth,
      color: tBlueDark,
      title: 'Continuous Growth',
      text: 'Learn, upskill and take on new challenges.',
    );
    final Widget balance = _whyTile(
      iconAsset: _Svg.whyWorkLifeBalance,
      color: tOrange1,
      title: 'Work-Life Balance',
      text: 'Flexibility and a healthy work environment.',
    );

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: tBlueSky1,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: tBlueLight.withOpacity(0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Why Join TrakMate?',
                style: GoogleFonts.manrope(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w800,
                  color: tBlue4,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 1.5,
                  color: tBlueDark.withOpacity(0.45),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (isMobile) ...[
            meaningful,
            const SizedBox(height: 10),
            supportive,
            const SizedBox(height: 10),
            growth,
            const SizedBox(height: 10),
            balance,
          ] else ...[
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: meaningful),
                  const SizedBox(width: 10),
                  Expanded(child: supportive),
                ],
              ),
            ),
            const SizedBox(height: 10),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: growth),
                  const SizedBox(width: 10),
                  Expanded(child: balance),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _whyTile({
    required String iconAsset,
    required Color color,
    required String title,
    required String text,
  }) {
    return Container(
      width: isMobile ? double.infinity : null,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tBlueLight.withOpacity(0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.13),
            ),
            child: _SvgIcon(iconAsset, size: 20, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: tBlue4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: GoogleFonts.manrope(
                    fontSize: 11,
                    height: 1.4,
                    color: tBlue4.withOpacity(0.65),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Card 3 – "Follow us on LinkedIn" (orange).
  /// On mobile the button drops below the text and goes full width.
  Widget _buildStayInformedCard() {
    final Widget iconBox = Container(
      width: 52,
      height: 52,
      alignment: Alignment.center,
      decoration: BoxDecoration(shape: BoxShape.circle, color: tWhite),
      child: const _SvgIcon(_Svg.linkedInMail, size: 26, color: tOrange1),
    );

    final Widget textBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Follow us on LinkedIn',
              style: GoogleFonts.manrope(
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
                color: tBlue4,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(height: 1, color: tOrange1.withOpacity(0.35)),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          'Get notified about new job openings that match your interests.',
          style: GoogleFonts.manrope(
            fontSize: 11,
            height: 1.4,
            color: tBlue4.withOpacity(0.65),
          ),
        ),
      ],
    );

    final Widget button = MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _openLinkedIn,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          decoration: BoxDecoration(
            color: tWhite,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: tOrange1, width: 1.4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _SvgIcon(_Svg.linkedInOpenNew, size: 16, color: tOrange1),
              const SizedBox(width: 6),
              Text(
                'Click here',
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: tOrange1,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tOrange1.withOpacity(0.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: tOrange1.withOpacity(0.18)),
      ),
      child:
          isMobile
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      iconBox,
                      const SizedBox(width: 14),
                      Expanded(child: textBlock),
                    ],
                  ),
                  const SizedBox(height: 14),
                  button,
                ],
              )
              : Row(
                children: [
                  iconBox,
                  const SizedBox(width: 14),
                  Expanded(child: textBlock),
                  const SizedBox(width: 12),
                  button,
                ],
              ),
    );
  }
}

/// One row inside the location dropdown (text only, no icons).
/// Highlights on hover; the selected row is bold + blue.
class _LocationMenuItem extends StatefulWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _LocationMenuItem({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  State<_LocationMenuItem> createState() => _LocationMenuItemState();
}

class _LocationMenuItemState extends State<_LocationMenuItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color:
                _hovered
                    ? tBlueSky1
                    : (widget.selected
                        ? tBlueDark.withOpacity(0.06)
                        : tTransparent),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Text(
            widget.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: widget.selected ? FontWeight.w700 : FontWeight.w500,
              color: widget.selected ? tBlueDark : tBlack,
            ),
          ),
        ),
      ),
    );
  }
}

/// Curved hand-drawn underline beneath "a suitable role?".
class _UnderlinePainter extends CustomPainter {
  final Color color;
  const _UnderlinePainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round;
    final path =
        Path()
          ..moveTo(size.width * 0.14, size.height - 2)
          ..quadraticBezierTo(
            size.width * 0.5,
            size.height - 20,
            size.width * 0.95,
            size.height - 26,
          );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _UnderlinePainter old) => old.color != color;
}

/// Rounded rectangle with a dashed border (used for the upload box).
class _DashedRRectPainter extends CustomPainter {
  final Color color;
  final double radius;
  const _DashedRRectPainter({required this.color, this.radius = 12});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.3;
    final path =
        Path()..addRRect(
          RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
        );
    for (final metric in path.computeMetrics()) {
      double d = 0;
      while (d < metric.length) {
        canvas.drawPath(metric.extractPath(d, d + 6), paint);
        d += 11;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter old) =>
      old.color != color || old.radius != radius;
}

/// Dashed flight path for the paper plane. The plane itself is now an SVG
/// widget (see _Svg.planeSend) placed on top of this painter.
class _PlanePathPainter extends CustomPainter {
  final Color color;
  const _PlanePathPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color.withOpacity(0.8)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2;
    final path =
        Path()
          ..moveTo(0, size.height)
          ..quadraticBezierTo(
            size.width * 0.15,
            size.height * 0.25,
            size.width * 0.55,
            size.height * 0.35,
          )
          ..quadraticBezierTo(
            size.width * 0.85,
            size.height * 0.45,
            size.width * 0.9,
            size.height * 0.1,
          );
    for (final metric in path.computeMetrics()) {
      double d = 0;
      while (d < metric.length) {
        canvas.drawPath(metric.extractPath(d, d + 5), paint);
        d += 10;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _PlanePathPainter old) => old.color != color;
}
