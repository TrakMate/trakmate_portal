import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web/helpers.dart' as web;

import '../../utils/colors.dart';
import '../sections/aboutUs_section.dart';
import '../sections/engineering_section.dart';
import '../sections/home_section.dart';
import '../sections/industries_section.dart';
import '../sections/manufacturing_section.dart';
import '../sections/products_section.dart';
import '../sections/resources_section.dart';
import '../sections/solutions_section.dart';

class MainPage extends StatefulWidget {
  final int initialIndex;
  const MainPage({super.key, this.initialIndex = 0});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
  }

  final List<String> menus = [
    'Home',
    'Solutions',
    'Engineering',
    'Manufacturing',
    'Products',
    'Industries',
    'Resources',
    'About Us',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tWhite,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: IndexedStack(
              index: selectedIndex ?? 0,
              children: [
                HomeSection(
                  isActive: selectedIndex == 0,
                  onNavigate: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
                // SolutionsSection(
                //   onNavigate: (index) {
                //     setState(() {
                //       selectedIndex = index;
                //     });
                //   },
                // ),
                SolutionsSection(
                  isActive: selectedIndex == 1,
                  onNavigate: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
                EngineeringSection(isActive: selectedIndex == 2),
                ManufacturingSection(isActive: selectedIndex == 3),
                ProductsSection(isActive: selectedIndex == 4),
                IndustriesSection(isActive: selectedIndex == 5),
                ResourcesSection(),
                AboutusSection(isActive: selectedIndex == 7),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset('icons/trakmate_logo.svg', height: 60),

          Row(
            children: List.generate(
              menus.length,
              (index) => _navButton(menus[index], index),
            ),
          ),

          _buildGetInTouchButton(),
        ],
      ),
    );
  }

  Widget _buildGetInTouchButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = null;
          });

          _showGetInTouchDialog();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          decoration: BoxDecoration(
            gradient: tOrangeGradient2,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Text(
                'Get in Touch',
                style: GoogleFonts.manrope(
                  color: tWhite,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(width: 10),

              SvgPicture.asset(
                'icons/right_arrow.svg',
                width: 22,
                height: 22,
                colorFilter: const ColorFilter.mode(tWhite, BlendMode.srcIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // ============================================================
  // SHOW GET IN TOUCH DIALOG
  // ============================================================

  void _showGetInTouchDialog() {
    Future.delayed(const Duration(milliseconds: 180), () {
      if (!mounted) return;

      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: 'Get in touch',
        barrierColor: tBlack.withOpacity(0.58),
        transitionDuration: const Duration(milliseconds: 550),
        pageBuilder: (context, animation, secondaryAnimation) {
          return const _GetInTouchDialog();
        },
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          final Animation<double> scaleAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
            reverseCurve: Curves.easeInCubic,
          );

          final Animation<double> fadeAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          );

          return FadeTransition(
            opacity: fadeAnimation,
            child: ScaleTransition(
              scale: Tween<double>(
                begin: 0.72,
                end: 1.0,
              ).animate(scaleAnimation),
              child: child,
            ),
          );
        },
      );
    });
  }

  Widget _navButton(String text, int index) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? tOrange1 : tBlack,
                ),
                child: Text(text),
              ),

              const SizedBox(height: 5),

              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 2,
                width: isSelected ? 50 : 0,
                decoration: const BoxDecoration(color: tOrange1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PopupSvgIcon extends StatelessWidget {
  final String asset;
  final double size;
  final Color? color;

  const _PopupSvgIcon({required this.asset, this.size = 16, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: size,
      height: size,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

// ============================================================================
// GET IN TOUCH DIALOG
// ============================================================================

class _GetInTouchDialog extends StatefulWidget {
  const _GetInTouchDialog();

  @override
  State<_GetInTouchDialog> createState() => _GetInTouchDialogState();
}

class _GetInTouchDialogState extends State<_GetInTouchDialog>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _subjectController = TextEditingController();

  final TextEditingController _messageController = TextEditingController();

  late AnimationController _contentAnimationController;

  late Animation<double> _leftFadeAnimation;

  late Animation<Offset> _leftSlideAnimation;

  late Animation<double> _rightFadeAnimation;

  late Animation<Offset> _rightSlideAnimation;

  @override
  void initState() {
    super.initState();

    _contentAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _leftFadeAnimation = CurvedAnimation(
      parent: _contentAnimationController,
      curve: const Interval(0.10, 0.70, curve: Curves.easeOut),
    );

    _leftSlideAnimation = Tween<Offset>(
      begin: const Offset(-0.06, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentAnimationController,
        curve: const Interval(0.10, 0.70, curve: Curves.easeOutCubic),
      ),
    );

    _rightFadeAnimation = CurvedAnimation(
      parent: _contentAnimationController,
      curve: const Interval(0.25, 0.95, curve: Curves.easeOut),
    );

    _rightSlideAnimation = Tween<Offset>(
      begin: const Offset(0.06, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentAnimationController,
        curve: const Interval(0.25, 0.95, curve: Curves.easeOutCubic),
      ),
    );

    Future.delayed(const Duration(milliseconds: 80), () {
      if (mounted) {
        _contentAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _contentAnimationController.dispose();

    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _subjectController.dispose();
    _messageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final bool compact = screenSize.width < 900;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: compact ? screenSize.width * 0.92 : 1125,
          constraints: BoxConstraints(maxHeight: screenSize.height * 0.88),
          decoration: BoxDecoration(
            color: tWhite,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: tBlack.withOpacity(0.22),
                blurRadius: 35,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(34, 38, 34, 34),
                  child:
                      compact ? _buildCompactLayout() : _buildDesktopLayout(),
                ),
              ),

              // ==================================================
              // CLOSE BUTTON
              // ==================================================
              Positioned(
                top: 14,
                right: 14,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(
                        color: tBlue2,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: tWhite,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DESKTOP LAYOUT
  //
  // ONLY CHANGE:
  // The complete "Send us a message" section is moved down
  // by 105px so it aligns with the Phone details on the left.
  // ============================================================

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: FadeTransition(
            opacity: _leftFadeAnimation,
            child: SlideTransition(
              position: _leftSlideAnimation,
              child: _buildContactInformation(),
            ),
          ),
        ),

        const SizedBox(width: 48),

        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.only(top: 110),
            child: FadeTransition(
              opacity: _rightFadeAnimation,
              child: SlideTransition(
                position: _rightSlideAnimation,
                child: _buildContactForm(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // COMPACT LAYOUT
  // ============================================================

  Widget _buildCompactLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeTransition(
          opacity: _leftFadeAnimation,
          child: SlideTransition(
            position: _leftSlideAnimation,
            child: _buildContactInformation(),
          ),
        ),

        const SizedBox(height: 30),

        FadeTransition(
          opacity: _rightFadeAnimation,
          child: SlideTransition(
            position: _rightSlideAnimation,
            child: _buildContactForm(),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // CONTACT INFORMATION
  // ============================================================

  Widget _buildContactInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Let’s get in touch',
          style: GoogleFonts.manrope(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: tBlue2,
            height: 1.12,
          ),
        ),

        const SizedBox(height: 11),

        Text(
          'We’d love to hear from you. Reach out to our team and let’s discuss how we can help.',
          style: GoogleFonts.manrope(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: tBlack.withOpacity(0.55),
            height: 1.55,
          ),
        ),

        const SizedBox(height: 40),

        _buildContactInfoItem(
          icon: 'icons/phone.svg',
          title: 'Phone',
          content:
              '+91 80 41532112\n'
              '+91 99 00450640',
        ),

        const SizedBox(height: 19),

        _buildContactInfoItem(
          icon: 'icons/mail.svg',
          title: 'Email',
          content: 'info@trakmate.co.in',
        ),

        const SizedBox(height: 19),

        _buildContactInfoItem(
          icon: 'icons/location.svg',
          title: 'Office',
          content:
              '#1A, 3rd Cross, Raghavendra Extension\n'
              'Opp. of MEI, Off Tumkur Road\n'
              'Yeshwanthapura, Bangalore 560022\n'
              'Karnataka, India',
        ),

        const SizedBox(height: 40),

        /*
        const _AddressMapCard(),
        */
        const _GoogleMapCard(),
      ],
    );
  }

  // ============================================================
  // CONTACT INFO ITEM
  // ============================================================

  Widget _buildContactInfoItem({
    required String icon,
    required String title,
    required String content,
  }) {
    return _AnimatedContactInfoItem(icon: icon, title: title, content: content);
  }

  // ============================================================
  // CONTACT FORM
  // ============================================================

  Widget _buildContactForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Send us a message',
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: tBlue2,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          'Fill in the details below and our team will get in touch with you.',
          style: GoogleFonts.manrope(
            fontSize: 11.5,
            fontWeight: FontWeight.w500,
            color: tBlack.withOpacity(0.48),
          ),
        ),

        const SizedBox(height: 30),

        LayoutBuilder(
          builder: (context, constraints) {
            final bool compact = constraints.maxWidth < 450;

            if (compact) {
              return Column(
                children: [
                  _buildFormField(
                    controller: _nameController,
                    label: 'Name *',
                    hint: 'Your name',
                    icon: 'icons/person.svg',
                  ),

                  const SizedBox(height: 14),

                  _buildFormField(
                    controller: _emailController,
                    label: 'Email *',
                    hint: 'Your email',
                    icon: 'icons/mail.svg',
                  ),
                ],
              );
            }

            return Row(
              children: [
                Expanded(
                  child: _buildFormField(
                    controller: _nameController,
                    label: 'Name *',
                    hint: 'Your name',
                    icon: 'icons/person.svg',
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: _buildFormField(
                    controller: _emailController,
                    label: 'Email *',
                    hint: 'Your email',
                    icon: 'icons/mail.svg',
                  ),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 14),

        LayoutBuilder(
          builder: (context, constraints) {
            final bool compact = constraints.maxWidth < 450;

            if (compact) {
              return Column(
                children: [
                  _buildFormField(
                    controller: _phoneController,
                    label: 'Phone',
                    hint: 'Your phone number',
                    icon: 'icons/phone.svg',
                  ),

                  const SizedBox(height: 14),

                  _buildFormField(
                    controller: _subjectController,
                    label: 'Subject *',
                    hint: 'How can we help?',
                    icon: 'icons/subject.svg',
                  ),
                ],
              );
            }

            return Row(
              children: [
                Expanded(
                  child: _buildFormField(
                    controller: _phoneController,
                    label: 'Phone',
                    hint: 'Your phone number',
                    icon: 'icons/phone.svg',
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: _buildFormField(
                    controller: _subjectController,
                    label: 'Subject *',
                    hint: 'How can we help?',
                    icon: 'icons/subject.svg',
                  ),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 14),

        _buildMessageField(),

        const SizedBox(height: 24),

        Align(
          alignment: Alignment.bottomRight,
          child: _buildSendMessagesButton(),
        ),
      ],
    );
  }

  // ============================================================
  // FORM FIELD
  // ============================================================

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String icon,
  }) {
    return _HoverFormField(
      controller: controller,
      label: label,
      hint: hint,
      icon: icon,
    );
  }

  // ============================================================
  // MESSAGE FIELD
  // ============================================================

  Widget _buildMessageField() {
    return _HoverMessageField(controller: _messageController);
  }

  // ============================================================
  // SEND BUTTON
  // ============================================================

  Widget _buildSendMessagesButton() {
    return _AnimatedSendButton(
      onPressed: () {
        if (_nameController.text.trim().isEmpty ||
            _emailController.text.trim().isEmpty ||
            _subjectController.text.trim().isEmpty ||
            _messageController.text.trim().isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Please fill in all required fields.',
                style: GoogleFonts.manrope(fontSize: 12),
              ),
              behavior: SnackBarBehavior.floating,
            ),
          );

          return;
        }

        Navigator.of(context).pop();
      },
    );
  }
}

// ============================================================================
// GOOGLE MAP VIEW
// ============================================================================

class _GoogleMapView extends StatefulWidget {
  const _GoogleMapView();

  @override
  State<_GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<_GoogleMapView> {
  static const String _googleMapEmbedUrl =
      'https://www.google.com/maps?q=13.0249319,77.5431742&z=17&output=embed';

  late final String _viewType;

  @override
  void initState() {
    super.initState();

    _viewType = 'trakmate-google-map-${identityHashCode(this)}';

    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      final web.HTMLIFrameElement iframe = web.HTMLIFrameElement();

      iframe.src = _googleMapEmbedUrl;

      iframe.style.border = '0';

      iframe.style.width = '100%';

      iframe.style.height = '100%';

      iframe.style.display = 'block';

      iframe.setAttribute('allowfullscreen', 'true');

      iframe.setAttribute('loading', 'lazy');

      iframe.setAttribute('referrerpolicy', 'no-referrer-when-downgrade');

      return iframe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: _viewType);
  }
}

// ============================================================================
// GOOGLE MAP CARD
// ============================================================================

class _GoogleMapCard extends StatefulWidget {
  const _GoogleMapCard();

  @override
  State<_GoogleMapCard> createState() => _GoogleMapCardState();
}

class _GoogleMapCardState extends State<_GoogleMapCard> {
  bool _isHovered = false;

  static const String _googleMapsUrl =
      'https://www.google.com/maps/place/TrakMate/@13.0249319,77.5405993,17z/data=!3m1!4b1!4m6!3m5!1s0x3bae162b0c795555:0x932171032762f6da!8m2!3d13.0249319!4d77.5431742!16s%2Fg%2F11cjnp91m3?entry=ttu&g_ep=EgoyMDI2MDgyNi4wIKXMDSoASAFQAw%3D%3D';

  Future<void> _openGoogleMaps() async {
    final Uri url = Uri.parse(_googleMapsUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,

      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },

      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),

        transform: Matrix4.translationValues(0, _isHovered ? -3 : 0, 0),

        height: 180,

        decoration: BoxDecoration(
          color: tWhite,

          borderRadius: BorderRadius.circular(10),

          border: Border.all(
            color:
                _isHovered
                    ? tOrange1.withOpacity(0.60)
                    : tBlue3.withOpacity(0.12),
            width: _isHovered ? 1.2 : 1,
          ),

          boxShadow:
              _isHovered
                  ? [
                    BoxShadow(
                      color: tOrange1.withOpacity(0.10),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ]
                  : [],
        ),

        clipBehavior: Clip.antiAlias,

        child: Stack(
          children: [
            const Positioned.fill(child: _GoogleMapView()),

            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),

                decoration: BoxDecoration(
                  color: tWhite,

                  borderRadius: BorderRadius.circular(7),

                  boxShadow: [
                    BoxShadow(
                      color: tBlack.withOpacity(0.14),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),

                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _PopupSvgIcon(
                      asset: 'icons/location.svg',
                      size: 14,
                      color: tBlue2,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      'TrakMate',
                      style: GoogleFonts.manrope(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: tBlue2,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              right: 10,
              bottom: 10,
              child: GestureDetector(
                onTap: _openGoogleMaps,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),

                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 7,
                  ),

                  decoration: BoxDecoration(
                    color: tBlue2,

                    borderRadius: BorderRadius.circular(6),

                    boxShadow: [
                      BoxShadow(
                        color: tBlack.withOpacity(0.18),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'OPEN IN MAPS',
                        style: GoogleFonts.manrope(
                          fontSize: 8,
                          fontWeight: FontWeight.w800,
                          color: tWhite,
                        ),
                      ),

                      const SizedBox(width: 5),

                      const _PopupSvgIcon(
                        asset: 'icons/right_arrow.svg',
                        size: 12,
                        color: tWhite,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// OLD ADDRESS CARD
// ============================================================================

/*
class _AddressMapCard extends StatefulWidget {
  const _AddressMapCard();

  @override
  State<_AddressMapCard> createState() =>
      _AddressMapCardState();
}

class _AddressMapCardState
    extends State<_AddressMapCard> {
  bool _isHovered = false;

  static const String _googleMapsUrl =
      'https://www.google.com/maps/place/TrakMate/@13.0249319,77.5405993,17z/data=!3m1!4b1!4m6!3m5!1s0x3bae162b0c795555:0x932171032762f6da!8m2!3d13.0249319!4d77.5431742!16s%2Fg%2F11cjnp91m3?entry=ttu&g_ep=EgoyMDI2MDgyNi4wIKXMDSoASAFQAw%3D%3D';

  Future<void> _openGoogleMaps() async {
    final Uri url =
        Uri.parse(
      _googleMapsUrl,
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode:
            LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return MouseRegion(
      cursor:
          SystemMouseCursors.click,

      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },

      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },

      child: GestureDetector(
        onTap: _openGoogleMaps,

        child: AnimatedContainer(
          duration:
              const Duration(
            milliseconds: 250,
          ),

          curve: Curves.easeOut,

          transform:
              Matrix4.translationValues(
            0,
            _isHovered ? -3 : 0,
            0,
          ),

          padding:
              const EdgeInsets.all(14),

          decoration:
              BoxDecoration(
            color:
                tOrange1.withOpacity(
              0.025,
            ),

            border: Border.all(
              color:
                  _isHovered
                      ? tOrange1
                          .withOpacity(
                        0.20,
                      )
                      : tBlue3
                          .withOpacity(
                        0.12,
                      ),

              width:
                  _isHovered
                      ? 1.2
                      : 1,
            ),

            borderRadius:
                BorderRadius.circular(
              10,
            ),

            boxShadow:
                _isHovered
                    ? [
                      BoxShadow(
                        color:
                            tOrange1
                                .withOpacity(
                          0.035,
                        ),

                        blurRadius:
                            14,

                        offset:
                            const Offset(
                          0,
                          6,
                        ),
                      ),
                    ]
                    : [],
          ),

          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,

                decoration:
                    BoxDecoration(
                  color: tBlue2,

                  borderRadius:
                      BorderRadius
                          .circular(
                    9,
                  ),
                ),

                child: const Center(
                  child:
                      _PopupSvgIcon(
                    asset:
                        'icons/location.svg',

                    size: 16,

                    color: tWhite,
                  ),
                ),
              ),

              const SizedBox(
                width: 12,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [
                    Text(
                      'For address',

                      style:
                          GoogleFonts
                              .manrope(
                        fontSize: 11,
                        fontWeight:
                            FontWeight
                                .w800,
                        color:
                            tBlue2,
                      ),
                    ),

                    const SizedBox(
                      height: 3,
                    ),

                    Text(
                      'Click here to view our location on Google Maps.',

                      style:
                          GoogleFonts
                              .manrope(
                        fontSize: 9.5,
                        fontWeight:
                            FontWeight
                                .w500,
                        color:
                            tBlack
                                .withOpacity(
                          0.52,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                width: 10,
              ),

              AnimatedContainer(
                duration:
                    const Duration(
                  milliseconds: 250,
                ),

                transform:
                    Matrix4.translationValues(
                  _isHovered
                      ? 2
                      : 0,
                  0,
                  0,
                ),

                padding:
                    const EdgeInsets
                        .symmetric(
                  horizontal: 13,
                  vertical: 9,
                ),

                decoration:
                    BoxDecoration(
                  color: tBlue2,

                  borderRadius:
                      BorderRadius
                          .circular(
                    6,
                  ),
                ),

                child: Row(
                  mainAxisSize:
                      MainAxisSize.min,

                  children: [
                    Text(
                      'CLICK HERE',

                      style:
                          GoogleFonts
                              .manrope(
                        fontSize: 8.5,
                        fontWeight:
                            FontWeight.w800,
                        color: tWhite,
                      ),
                    ),

                    const SizedBox(
                      width: 5,
                    ),

                    const _PopupSvgIcon(
                      asset:
                          'icons/right_arrow.svg',

                      size: 14,

                      color: tWhite,
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
}
*/

// ============================================================================
// CONTACT INFO ANIMATION
// ============================================================================

class _AnimatedContactInfoItem extends StatefulWidget {
  final String icon;
  final String title;
  final String content;

  const _AnimatedContactInfoItem({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  State<_AnimatedContactInfoItem> createState() =>
      _AnimatedContactInfoItemState();
}

class _AnimatedContactInfoItemState extends State<_AnimatedContactInfoItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.basic,

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

        transform: Matrix4.translationValues(_hovered ? 3 : 0, 0, 0),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              width: 42,
              height: 42,

              decoration: BoxDecoration(
                color: tBlue3.withOpacity(0.08),

                borderRadius: BorderRadius.circular(10),
              ),

              child: Center(
                child: _PopupSvgIcon(
                  asset: widget.icon,
                  size: 16,
                  color: tBlue3,
                ),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.manrope(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: tBlack.withOpacity(0.52),
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    widget.content,
                    style: GoogleFonts.manrope(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: tBlue2,
                      height: 1.5,
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
}

// ============================================================================
// HOVER FORM FIELD
// ============================================================================

class _HoverFormField extends StatefulWidget {
  final TextEditingController controller;

  final String label;
  final String hint;
  final String icon;

  const _HoverFormField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
  });

  @override
  State<_HoverFormField> createState() => _HoverFormFieldState();
}

class _HoverFormFieldState extends State<_HoverFormField> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            widget.label,

            style: GoogleFonts.manrope(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: tBlack.withOpacity(0.70),
            ),
          ),

          const SizedBox(height: 6),

          AnimatedContainer(
            duration: const Duration(milliseconds: 180),

            height: 48,

            decoration: BoxDecoration(
              color: tWhite,

              borderRadius: BorderRadius.circular(9),

              border: Border.all(
                color:
                    _hovered
                        ? tOrange1.withOpacity(0.60)
                        : tBlack.withOpacity(0.12),

                width: _hovered ? 1.2 : 1,
              ),
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),

              child: TextField(
                controller: widget.controller,

                textAlignVertical: TextAlignVertical.center,

                style: GoogleFonts.manrope(fontSize: 11, color: tBlack),

                decoration: InputDecoration(
                  filled: true,

                  fillColor: tWhite,

                  border: InputBorder.none,

                  enabledBorder: InputBorder.none,

                  focusedBorder: InputBorder.none,

                  errorBorder: InputBorder.none,

                  focusedErrorBorder: InputBorder.none,

                  contentPadding: const EdgeInsets.only(
                    left: 4,
                    right: 12,
                    top: 0,
                    bottom: 0,
                  ),

                  prefixIcon: SizedBox(
                    width: 46,
                    height: 48,

                    child: Center(
                      child: _PopupSvgIcon(
                        asset: widget.icon,
                        size: 16,
                        color: tBlue3,
                      ),
                    ),
                  ),

                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 46,
                    maxWidth: 46,
                    minHeight: 48,
                    maxHeight: 48,
                  ),

                  hintText: widget.hint,

                  hintStyle: GoogleFonts.manrope(
                    fontSize: 11,
                    color: tBlack.withOpacity(0.30),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// HOVER MESSAGE FIELD
// ============================================================================

class _HoverMessageField extends StatefulWidget {
  final TextEditingController controller;

  const _HoverMessageField({required this.controller});

  @override
  State<_HoverMessageField> createState() => _HoverMessageFieldState();
}

class _HoverMessageFieldState extends State<_HoverMessageField> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            'Messages *',

            style: GoogleFonts.manrope(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: tBlack.withOpacity(0.70),
            ),
          ),

          const SizedBox(height: 6),

          AnimatedContainer(
            duration: const Duration(milliseconds: 180),

            height: 96,

            decoration: BoxDecoration(
              color: tWhite,

              borderRadius: BorderRadius.circular(9),

              border: Border.all(
                color:
                    _hovered
                        ? tOrange1.withOpacity(0.60)
                        : tBlack.withOpacity(0.12),

                width: _hovered ? 1.2 : 1,
              ),
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),

              child: TextField(
                controller: widget.controller,

                maxLines: null,
                expands: true,

                textAlignVertical: TextAlignVertical.top,

                style: GoogleFonts.manrope(fontSize: 11, color: tBlack),

                decoration: InputDecoration(
                  filled: true,

                  fillColor: tWhite,

                  border: InputBorder.none,

                  enabledBorder: InputBorder.none,

                  focusedBorder: InputBorder.none,

                  errorBorder: InputBorder.none,

                  focusedErrorBorder: InputBorder.none,

                  contentPadding: const EdgeInsets.all(14),

                  hintText: 'Write your message here...',

                  hintStyle: GoogleFonts.manrope(
                    fontSize: 11,
                    color: tBlack.withOpacity(0.30),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SEND BUTTON
// ============================================================================

class _AnimatedSendButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _AnimatedSendButton({required this.onPressed});

  @override
  State<_AnimatedSendButton> createState() => _AnimatedSendButtonState();
}

class _AnimatedSendButtonState extends State<_AnimatedSendButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
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

      child: GestureDetector(
        onTap: widget.onPressed,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),

          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),

          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),

          decoration: BoxDecoration(
            color: tOrange1,

            borderRadius: BorderRadius.circular(8),

            boxShadow: [
              BoxShadow(
                color: tOrange1.withOpacity(_hovered ? 0.30 : 0.16),

                blurRadius: _hovered ? 18 : 10,

                offset: const Offset(0, 6),
              ),
            ],
          ),

          child: Row(
            mainAxisSize: MainAxisSize.min,

            children: [
              Text(
                'SEND MESSAGE',

                style: GoogleFonts.manrope(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: tWhite,
                ),
              ),

              const SizedBox(width: 10),

              const _PopupSvgIcon(
                asset: 'icons/right_arrow.svg',
                size: 14,
                color: tWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
