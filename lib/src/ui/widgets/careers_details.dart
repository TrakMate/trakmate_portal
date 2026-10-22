import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmer_effect.dart';
import 'package:trakmate_portal/src/utils/responsive.dart';
import '../../utils/colors.dart';

/// Careers page – hero, filters, current openings timeline and "Submit your CV".
///
/// Requires in pubspec.yaml:
///   file_picker: ^8.0.0
///   google_fonts: ^6.0.0
///   go_router
/// Assets should be registered in pubspec.yaml (for example, `images/`).
/// Configure images when creating this page:
/// CareersPage(heroImageAsset: 'images/careers_hero.png',
///             secondaryImageAsset: 'images/desk.png')

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
  final IconData icon;
  const _Job({
    required this.title,
    required this.category,
    required this.location,
    required this.type,
    required this.experience,
    required this.description,
    required this.responsibilities,
    required this.requirements,
    required this.icon,
  });
}

class _CareersPageState extends State<CareersPage> {
  static const int _maxCvBytes = 5 * 1024 * 1024;

  // Breakpoints come from ResponsiveLayout:
  //   mobile  < 700   |   tablet 700 - 1099   |   desktop >= 1100
  bool get isMobile => ResponsiveLayout.isMobile(context);
  bool get isTablet => ResponsiveLayout.isTablet(context);

  // Horizontal page padding
  double get _pad => isMobile ? 16 : (isTablet ? 24 : 40);

  static const List<String> _tabs = [
    'All Roles',
    'Engineering',
    'Product',
    'Design',
    'Operations',
    'Business',
    'Mechanical',
  ];
  static const List<String> _locations = ['All Locations', 'Bengaluru, India'];
  // NOTE: responsibilities / requirements below are placeholder content –
  // replace them with your real job descriptions.
  static const List<_Job> _jobs = [
    _Job(
      title: 'Flutter Developer',
      category: 'Engineering',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '2 - 5 Yrs',
      description:
          'Work on our cross-platform fleet management applications and help build scalable, high-performance mobile experiences.',
      responsibilities: [
        'Build and maintain cross-platform apps using Flutter and Dart.',
        'Integrate REST APIs, WebSockets and real-time vehicle data.',
        'Write clean, testable code and take part in code reviews.',
        'Work with design and backend teams to ship features on time.',
      ],
      requirements: [
        '2 - 5 years of hands-on experience with Flutter and Dart.',
        'Good understanding of state management (Provider, Bloc or Riverpod).',
        'Experience with maps, tracking or IoT applications is a plus.',
        'Apps published on the Play Store or App Store.',
      ],
      icon: Icons.code_rounded,
    ),
    _Job(
      title: 'Embedded Systems Engineer',
      category: 'Engineering',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '3 - 6 Yrs',
      description:
          'Design and develop next-generation telematics hardware and contribute to innovative IoT solutions.',
      responsibilities: [
        'Develop and maintain firmware for telematics devices in C / C++.',
        'Work with GPS, GSM / LTE, CAN and sensor modules.',
        'Debug hardware and firmware issues using lab tools.',
        'Support field testing and device certification.',
      ],
      requirements: [
        '3 - 6 years of experience in embedded systems development.',
        'Strong knowledge of ARM Cortex-M and RTOS.',
        'Experience with UART, SPI, I2C and CAN protocols.',
        'Telematics or automotive background is a plus.',
      ],
      icon: Icons.settings_outlined,
    ),
    _Job(
      title: 'Product Manager',
      category: 'Product',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '4 - 7 Yrs',
      description:
          'Drive product strategy and work closely with engineering, design and customers to build impactful solutions.',
      responsibilities: [
        'Define the product roadmap and write clear requirements.',
        'Work closely with engineering and design to deliver features.',
        'Analyse usage data and customer feedback to prioritise work.',
        'Coordinate releases and communicate with stakeholders.',
      ],
      requirements: [
        '4 - 7 years of experience in product management.',
        'Strong communication and stakeholder management skills.',
        'Data-driven approach to decision making.',
        'Experience with B2B, SaaS or IoT products is a plus.',
      ],
      icon: Icons.bar_chart_rounded,
    ),
    _Job(
      title: 'Backend Developer',
      category: 'Engineering',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '3 - 6 Yrs',
      description:
          'Build and maintain scalable backend services and data pipelines for our connected vehicle platform.',
      responsibilities: [
        'Design and build APIs and microservices.',
        'Develop data pipelines for high-volume telemetry data.',
        'Improve performance, reliability and security of services.',
        'Monitor and maintain production systems.',
      ],
      requirements: [
        '3 - 6 years of backend development experience.',
        'Proficiency in Node.js, Java, Python or Go.',
        'Experience with SQL / NoSQL databases and message queues.',
        'Working knowledge of AWS, GCP or Azure.',
      ],
      icon: Icons.storage_rounded,
    ),
    _Job(
      title: 'Hardware Design Engineer',
      category: 'Engineering',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '3 - 7 Yrs',
      description:
          'Work on hardware design, validation and certification for our telematics devices.',
      responsibilities: [
        'Create schematics and PCB layouts for telematics devices.',
        'Validate and test hardware designs in the lab.',
        'Support EMI / EMC and regulatory certification.',
        'Work with vendors and manufacturing partners.',
      ],
      requirements: [
        '3 - 7 years of hardware design experience.',
        'Hands-on with Altium, KiCad or similar EDA tools.',
        'Good understanding of power and RF design.',
        'Comfortable debugging with oscilloscopes and analysers.',
      ],
      icon: Icons.memory_rounded,
    ),
    _Job(
      title: 'UI / UX Designer',
      category: 'Design',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '2 - 5 Yrs',
      description:
          'Craft clear, intuitive interfaces for our fleet and vehicle tracking products across web and mobile.',
      responsibilities: [
        'Design user flows, wireframes and interactive prototypes.',
        'Maintain and grow our design system.',
        'Run user research and usability testing.',
        'Collaborate with developers to ship pixel-perfect UI.',
      ],
      requirements: [
        '2 - 5 years of UI / UX design experience.',
        'Strong command of Figma.',
        'A portfolio showing web and mobile work.',
        'Good eye for typography, spacing and colour.',
      ],
      icon: Icons.brush_outlined,
    ),

    // ───────────── MECHANICAL ─────────────
    _Job(
      title: 'Mechanical Design Engineer – Devices',
      category: 'Mechanical',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '3 - 6 Yrs',
      description:
          'Design robust, manufacturable enclosures and mechanical assemblies for our telematics and tracking devices.',
      responsibilities: [
        'Design device enclosures, brackets, seals and mounting mechanisms in 3D CAD.',
        'Run tolerance stack-ups, thermal and ingress-protection (IP) checks.',
        'Work with electronics teams on PCB fit, connector placement and heat dissipation.',
        'Support prototyping, DFM / DFA reviews and vendor tooling discussions.',
      ],
      requirements: [
        '3 - 6 years of experience in mechanical product design.',
        'Proficiency in SolidWorks, Creo, CATIA or similar CAD tools.',
        'Good knowledge of plastic injection moulding and sheet metal design.',
        'Experience with automotive or consumer electronics enclosures is a plus.',
      ],
      icon: Icons.precision_manufacturing_outlined,
    ),
    _Job(
      title: 'Instrument Cluster Mechanical Engineer',
      category: 'Mechanical',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '3 - 7 Yrs',
      description:
          'Own the mechanical design of vehicle instrument clusters, from housing and display assembly to dial and bezel integration.',
      responsibilities: [
        'Design cluster housings, bezels, lenses, light guides and display mounting.',
        'Handle stepper-motor gauge, pointer and dial mechanics.',
        'Ensure vibration, sealing and thermal performance in the vehicle environment.',
        'Coordinate with suppliers on tooling, materials and assembly processes.',
      ],
      requirements: [
        '3 - 7 years of experience in automotive or consumer product mechanical design.',
        'Strong command of 3D CAD and GD&T.',
        'Understanding of plastics, adhesives, gaskets and optical parts.',
        'Instrument cluster or dashboard component experience is a plus.',
      ],
      icon: Icons.speed_rounded,
    ),
    _Job(
      title: 'Mechanical Validation & Reliability Engineer',
      category: 'Mechanical',
      location: 'Bengaluru, India',
      type: 'Full Time',
      experience: '2 - 5 Yrs',
      description:
          'Plan and run mechanical and environmental validation so our devices and clusters survive real road conditions.',
      responsibilities: [
        'Prepare and execute vibration, shock, thermal cycling and ingress tests.',
        'Analyse failures and work with design teams on corrective actions.',
        'Create test plans and reports aligned with automotive standards.',
        'Maintain test fixtures and coordinate with external test labs.',
      ],
      requirements: [
        '2 - 5 years of experience in mechanical testing or reliability engineering.',
        'Familiarity with AIS / IEC / ISO environmental test standards.',
        'Hands-on with test chambers, shakers and measurement equipment.',
        'Basic CAD or FEA exposure is a plus.',
      ],
      icon: Icons.build_circle_outlined,
    ),
  ];
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _openingsKey = GlobalKey();
  final GlobalKey _submitCvKey = GlobalKey();
  final TextEditingController _searchController = TextEditingController();
  int _selectedTab = 0;
  String _selectedLocation = _locations.first;
  String _query = '';
  PlatformFile? _cvFile; // used by the "Don't see a suitable role?" card

  /// CV chosen for each specific opening (key = job title).
  final Map<String, PlatformFile> _jobCvFiles = {};

  /// Title of the opening whose details are currently expanded (null = none).
  String? _expandedJob;

  /// Which drop zone a file is currently being dragged over:
  /// 'general' for the "Don't see a suitable role?" box, or a job title.
  String? _draggingTarget;
  bool _uploadHovered = false;
  bool _heroImageLoading = true;
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

  Future<void> _pickCv({String? jobTitle}) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['pdf', 'doc', 'docx'],
        withData: true,
      );
      if (result == null || result.files.isEmpty) return;
      final file = result.files.first;
      if (file.size > _maxCvBytes) {
        _toast('File is too large. Maximum allowed size is 5 MB.');
        return;
      }
      setState(() {
        if (jobTitle != null) {
          _jobCvFiles[jobTitle] = file; // CV for a specific opening
        } else {
          _cvFile = file; // general CV card
        }
      });
      _toast('CV selected: ${file.name}');
      // TODO: upload file.bytes / file.path to your backend here
      // (send jobTitle along when it is not null).
    } catch (_) {
      _toast('Could not open the file picker. Please try again.');
    }
  }

  /// Handles a CV file dropped onto an upload area. Same rules as [_pickCv]:
  /// PDF, DOC or DOCX only, maximum 5 MB.
  Future<void> _handleDroppedCv(
    DropDoneDetails details, {
    String? jobTitle,
  }) async {
    if (details.files.isEmpty) return;
    try {
      final dropped = details.files.first;
      final String name = dropped.name;
      final String ext =
          name.contains('.') ? name.split('.').last.toLowerCase() : '';
      if (!['pdf', 'doc', 'docx'].contains(ext)) {
        _toast('Please select a PDF, DOC or DOCX file.');
        return;
      }
      final int size = await dropped.length();
      if (size > _maxCvBytes) {
        _toast('File is too large. Maximum allowed size is 5 MB.');
        return;
      }
      final bytes = await dropped.readAsBytes();
      if (!mounted) return;
      final file = PlatformFile(name: name, size: size, bytes: bytes);
      setState(() {
        if (jobTitle != null) {
          _jobCvFiles[jobTitle] = file; // CV for a specific opening
        } else {
          _cvFile = file; // general CV card
        }
      });
      _toast('CV selected: ${file.name}');
      // TODO: upload file.bytes to your backend here
      // (send jobTitle along when it is not null).
    } catch (_) {
      _toast('Could not read the dropped file. Please try again.');
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
            child: Icon(
              Icons.image_not_supported_outlined,
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
          const Icon(Icons.search_rounded, size: 20, color: tBlue4),
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
    final location = Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tBlueLight.withOpacity(0.8)),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, size: 19, color: tBlue4),
          const SizedBox(width: 10),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedLocation,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: tBlue4,
                ),
                dropdownColor: tWhite,
                style: GoogleFonts.manrope(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: tBlack,
                ),
                items:
                    _locations
                        .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                        .toList(),
                onChanged: (v) {
                  if (v != null) setState(() => _selectedLocation = v);
                },
              ),
            ),
          ),
        ],
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
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: tBlueDark.withOpacity(0.12),
      ),
      child: Icon(job.icon, size: size * 0.45, color: tBlueDark),
    );
  }

  Widget _metaRow(_Job job) {
    Widget item(IconData icon, String text) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: tBlue4.withOpacity(0.6)),
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
        item(Icons.location_on_outlined, job.location),
        item(Icons.work_outline_rounded, job.type),
        item(Icons.bar_chart_rounded, job.experience),
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
                                              child: DropTarget(
                                                onDragEntered:
                                                    (_) => setState(
                                                      () =>
                                                          _draggingTarget =
                                                              job.title,
                                                    ),
                                                onDragExited:
                                                    (_) => setState(
                                                      () =>
                                                          _draggingTarget =
                                                              null,
                                                    ),
                                                onDragDone: (details) {
                                                  setState(
                                                    () =>
                                                        _draggingTarget = null,
                                                  );
                                                  _handleDroppedCv(
                                                    details,
                                                    jobTitle: job.title,
                                                  );
                                                },
                                                child: _buildDetailsPanel(job),
                                              ),
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
    final PlatformFile? appliedFile = _jobCvFiles[job.title];
    final bool uploaded = appliedFile != null;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: tBlueSky1,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color:
              _draggingTarget == job.title
                  ? tBlueDark
                  : tBlueLight.withOpacity(0.7),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _detailSection('Responsibilities', job.responsibilities, tOrange1),
          const SizedBox(height: 18),
          _detailSection('Requirements', job.requirements, tOrange1),
          const SizedBox(height: 20),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child:
                uploaded
                    ? _buildUploadedButton(job, appliedFile)
                    : _buildApplyButton(job),
          ),
        ],
      ),
    );
  }

  /// Default state: "Apply with CV".
  Widget _buildApplyButton(_Job job) {
    return Align(
      key: const ValueKey('apply'),
      alignment: Alignment.centerLeft,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _pickCv(jobTitle: job.title),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
            decoration: BoxDecoration(
              color: tBlueDark,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.cloud_upload_outlined,
                  size: 18,
                  color: tWhite,
                ),
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

  /// After a file is picked: "CV Uploaded" + file name, with Change / Remove.
  Widget _buildUploadedButton(_Job job, PlatformFile file) {
    return Wrap(
      key: const ValueKey('uploaded'),
      spacing: 14,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 300),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          decoration: BoxDecoration(
            color: tBlueDark.withOpacity(0.10),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: tBlueDark, width: 1.4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_rounded,
                size: 20,
                color: tBlueDark,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CV Uploaded',
                      style: GoogleFonts.manrope(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: tBlueDark,
                      ),
                    ),
                    Text(
                      file.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.manrope(
                        fontSize: 11,
                        color: tBlue4.withOpacity(0.65),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => _pickCv(jobTitle: job.title),
            child: Text(
              'Change',
              style: GoogleFonts.manrope(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: tBlueDark,
              ),
            ),
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => setState(() => _jobCvFiles.remove(job.title)),
            child: Text(
              'Remove',
              style: GoogleFonts.manrope(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: tOrange1,
              ),
            ),
          ),
        ),
      ],
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
                  width: isMobile ? 70 : 90,
                  height: isMobile ? 50 : 60,
                  child: CustomPaint(
                    painter: _PlanePathPainter(color: tOrange1),
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
          DropTarget(
            onDragEntered: (_) => setState(() => _draggingTarget = 'general'),
            onDragExited: (_) => setState(() => _draggingTarget = null),
            onDragDone: (details) {
              setState(() => _draggingTarget = null);
              _handleDroppedCv(details);
            },
            child: _buildUploadBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadBox() {
    final hasFile = _cvFile != null;
    final bool dragging = _draggingTarget == 'general';
    final bool active = _uploadHovered || dragging;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _uploadHovered = true),
      onExit: (_) => setState(() => _uploadHovered = false),
      child: GestureDetector(
        onTap: () => _pickCv(),
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
                          child: Icon(
                            hasFile
                                ? Icons.description_outlined
                                : Icons.cloud_upload_outlined,
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
                              hasFile ? _cvFile!.name : 'Upload Your CV',
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
                              hasFile
                                  ? 'Tap to replace your CV'
                                  : (dragging
                                      ? 'Drop your file here'
                                      : 'PDF, DOC or DOCX (Max 5 MB)'),
                              style: GoogleFonts.manrope(
                                fontSize: 11.5,
                                color: tBlue4.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (hasFile)
                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => setState(() => _cvFile = null),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Icon(
                              Icons.close_rounded,
                              size: 18,
                              color: tOrange1,
                            ),
                          ),
                        ),
                      // Arrow slides in from the left on hover.
                      if (!hasFile)
                        Opacity(
                          opacity: t,
                          child: Transform.translate(
                            offset: Offset(8 * (1 - t), 0),
                            child: Icon(
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
      icon: Icons.lightbulb_outline_rounded,
      color: tOrange1,
      title: 'Meaningful Work',
      text: 'Solve real-world challenges in connected mobility.',
    );
    final Widget supportive = _whyTile(
      icon: Icons.groups_outlined,
      color: tBlueDark,
      title: 'Supportive Team',
      text: 'Collaborative, inclusive and driven by growth.',
    );
    final Widget growth = _whyTile(
      icon: Icons.bar_chart_rounded,
      color: tBlueDark,
      title: 'Continuous Growth',
      text: 'Learn, upskill and take on new challenges.',
    );
    final Widget balance = _whyTile(
      icon: Icons.favorite_border_rounded,
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
    required IconData icon,
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
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.13),
            ),
            child: Icon(icon, size: 20, color: color),
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

  /// Card 3 – "Stay Informed" with Get Job Alerts button (orange).
  /// On mobile the button drops below the text and goes full width.
  Widget _buildStayInformedCard() {
    final Widget iconBox = Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(shape: BoxShape.circle, color: tWhite),
      child: Icon(Icons.mail_outline_rounded, size: 26, color: tOrange1),
    );

    final Widget textBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Stay Informed',
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
        onTap: _getJobAlerts,
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
              Icon(Icons.notifications_none_rounded, size: 16, color: tOrange1),
              const SizedBox(width: 6),
              Text(
                'Get Job Alerts',
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

/// Paper plane with a dashed flight path.
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
    final tp = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(Icons.send_rounded.codePoint),
        style: TextStyle(
          fontSize: 30,
          fontFamily: Icons.send_rounded.fontFamily,
          package: Icons.send_rounded.fontPackage,
          color: color,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    canvas.save();
    canvas.translate(size.width * 0.78, size.height * 0.0);
    canvas.rotate(-0.6);
    tp.paint(canvas, Offset.zero);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _PlanePathPainter old) => old.color != color;
}
