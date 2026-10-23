import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/pages/main_page.dart';
import 'package:trakmate_portal/src/ui/widgets/footer_section.dart';
import 'package:trakmate_portal/src/utils/responsive.dart';

import '../../utils/colors.dart';

// =========================================================
// RESPONSIVE HELPERS (mobile only, tablet/desktop untouched)
// =========================================================

/// Large + small phones.
bool _isPhone(BuildContext context) => MediaQuery.of(context).size.width < 600;

/// Small phones (e.g. iPhone SE, 320-359 wide).
bool _isSmallPhone(BuildContext context) =>
    MediaQuery.of(context).size.width < 360;

// =========================================================
// ACCESS WEBSITE DIALOG (entry point)
// =========================================================

void showLoginDialog(BuildContext context) {
  Future.delayed(const Duration(milliseconds: 180), () {
    if (!context.mounted) return;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Access Website',
      barrierColor: tBlack.withOpacity(0.58),
      transitionDuration: const Duration(milliseconds: 550),

      pageBuilder: (context, animation, secondaryAnimation) {
        return const _AccessWebsiteDialog();
      },

      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final scaleAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
          reverseCurve: Curves.easeInCubic,
        );

        final fadeAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
          reverseCurve: Curves.easeIn,
        );

        return FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.72, end: 1.0).animate(scaleAnimation),
            child: child,
          ),
        );
      },
    );
  });
}

class _AccessWebsiteDialog extends StatefulWidget {
  const _AccessWebsiteDialog();

  @override
  State<_AccessWebsiteDialog> createState() => _AccessWebsiteDialogState();
}

// STATE
class _AccessWebsiteDialogState extends State<_AccessWebsiteDialog>
    with SingleTickerProviderStateMixin {
  // CONTROLLERS
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // ANIMATION
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // BUTTON HOVER
  bool _isLoginHovered = false; //this

  String? _validationMessage;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    Future.delayed(const Duration(milliseconds: 80), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  // =======================================================
  // DISPOSE
  // =======================================================

  @override
  void dispose() {
    _animationController.dispose();

    _fullNameController.dispose();
    _companyController.dispose();
    _cityController.dispose();
    _emailController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  void _clearError() {
    if (_validationMessage != null) setState(() => _validationMessage = null);
  }
  // =======================================================
  // BUILD
  // =======================================================

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final screenSize = mq.size;

    final bool isMobile = screenSize.width < 650;
    final bool isSmall = screenSize.width < 360;

    // Available height once the keyboard is open.
    final double availableHeight =
        screenSize.height - mq.viewInsets.bottom - mq.padding.top;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      // Lifts the dialog above the keyboard on phones.
      padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
      child: Center(
        child: Material(
          color: tTransparent,

          child: Container(
            width: isMobile ? screenSize.width * (isSmall ? 0.94 : 0.92) : 600,

            constraints: BoxConstraints(
              maxHeight: availableHeight * (isMobile ? 0.94 : 0.90),
            ),

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
                // FORM
                SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      isMobile ? (isSmall ? 18 : 22) : 42,
                      isMobile ? 26 : 34,
                      isMobile ? (isSmall ? 18 : 22) : 42,
                      isMobile ? 24 : 34,
                    ),

                    child: FadeTransition(
                      opacity: _fadeAnimation,

                      child: SlideTransition(
                        position: _slideAnimation,

                        child: _buildAccessForm(isMobile, isSmall),
                      ),
                    ),
                  ),
                ),

                // CLOSE BUTTON
                // CLOSE BUTTON
                Positioned(
                  top: 14,
                  right: 14,
                  child: Material(
                    color: tTransparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () => Navigator.of(context).pop(),
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
      ),
    );
  }

  // =========================================================
  // FORM CONTENT
  // =========================================================

  Widget _buildAccessForm(bool isMobile, bool isSmall) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: isMobile ? 40 : 0),
          child: Text(
            'Access Website',
            style: GoogleFonts.manrope(
              fontSize: isMobile ? (isSmall ? 24 : 26) : 30,
              fontWeight: FontWeight.w800,
              color: tBlue2,
              height: 1.12,
            ),
          ),
        ),

        const SizedBox(height: 7),

        Container(
          height: 3,
          width: 65,
          decoration: BoxDecoration(
            color: tOrange1,
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        const SizedBox(height: 22),

        Text(
          'Please fill out your details to access the website',
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: tBlack.withOpacity(0.48),
            height: 1.55,
          ),
        ),

        const SizedBox(height: 30),

        HoverFormField(
          controller: _fullNameController,
          label: 'Full Name *',
          hint: 'John Doe',
          icon: 'icons/person2.svg',
          onChanged: _clearError,
        ),
        const SizedBox(height: 14),
        HoverFormField(
          controller: _companyController,
          label: 'Company',
          hint: 'Your company name',
          icon: 'icons/career1.svg',
          onChanged: _clearError,
        ),
        const SizedBox(height: 14),
        HoverFormField(
          controller: _cityController,
          label: 'City *',
          hint: 'Your city',
          icon: 'icons/location1.svg',
          onChanged: _clearError,
        ),
        const SizedBox(height: 14),
        HoverFormField(
          controller: _emailController,
          label: 'Email *',
          hint: 'you@example.com',
          icon: 'icons/mail.svg',
          // keyboardType: TextInputType.emailAddress,
          onChanged: _clearError,
        ),
        const SizedBox(height: 14),
        HoverFormField(
          controller: _phoneController,
          label: 'Phone Number *',
          hint: '+1 (555) 000-0000',
          icon: 'icons/phone.svg',
          // keyboardType: TextInputType.phone,
          onChanged: _clearError,
        ),

        // Error slot (same as Contact popup)
        SizedBox(
          height: 28,
          child: Align(
            alignment: Alignment.centerLeft,
            child:
                _validationMessage == null
                    ? null
                    : Text(
                      _validationMessage!,
                      style: GoogleFonts.manrope(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
          ),
        ),

        const SizedBox(height: 24),

        Align(
          alignment: Alignment.bottomRight,
          child: AnimatedSendButton(
            label: 'ACCESS',
            onPressed: _handleAccessWebsite,
          ),
        ),
      ],
    );
  }
  // TEXT FIELD

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String icon,
    bool isRequired = false,
    bool isMobile = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final double iconBox = isMobile ? 44 : 50;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        // LABEL
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label,

                style: GoogleFonts.manrope(
                  fontSize: isMobile ? 13 : 14,
                  fontWeight: FontWeight.w600,
                  color: tBlack.withOpacity(0.80),
                ),
              ),

              if (isRequired)
                TextSpan(
                  text: ' *',

                  style: GoogleFonts.manrope(
                    fontSize: isMobile ? 13 : 14,
                    fontWeight: FontWeight.w700,
                    color: tRed1,
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 7),

        // INPUT
        Container(
          height: isMobile ? 48 : 52,
          decoration: BoxDecoration(
            color: tWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: tBlack.withOpacity(0.10), width: 1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TextField(
              controller: controller,

              keyboardType: keyboardType,
              onChanged: (_) {
                if (_validationMessage != null) {
                  setState(() => _validationMessage = null);
                }
              },

              textAlignVertical: TextAlignVertical.center,

              style: GoogleFonts.manrope(
                fontSize: isMobile ? 13.5 : 14,
                fontWeight: FontWeight.w500,
                color: tBlack,
              ),

              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,

                filled: true,
                fillColor: tWhite,

                contentPadding: const EdgeInsets.only(right: 14),

                prefixIcon: SizedBox(
                  width: iconBox,

                  child: Center(
                    child: SvgPicture.asset(
                      icon,
                      width: isMobile ? 19 : 21,
                      height: isMobile ? 19 : 21,
                      colorFilter: const ColorFilter.mode(
                        tBlue3,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),

                prefixIconConstraints: BoxConstraints(
                  minWidth: iconBox,
                  maxWidth: iconBox,
                ),

                hintText: hint,

                hintStyle: GoogleFonts.manrope(
                  fontSize: isMobile ? 13.5 : 14,
                  fontWeight: FontWeight.w400,
                  color: tBlack.withOpacity(0.30),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // SUBMIT / LOGIN
  // =========================================================

  void _handleAccessWebsite() {
    if (_fullNameController.text.trim().isEmpty ||
        _cityController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty) {
      _showValidationMessage();
      return;
    }

    setState(() {
      _validationMessage = null;
    });

    final fullName = _fullNameController.text.trim();
    final company = _companyController.text.trim();
    final city = _cityController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();

    print('Full Name: $fullName');
    print('Company: $company');
    print('City: $city');
    print('Email: $email');
    print('Phone: $phone');

    Navigator.of(context).pop();

    // TODO: API call / navigation
  }

  // VALIDATION MESSAGE

  void _showValidationMessage() {
    setState(() {
      _validationMessage = 'Please fill every required field.';
    });
  }
}

// =========================================================
// WEB APP PAGE
// =========================================================

class WebApp extends StatelessWidget {
  const WebApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bool phone = _isPhone(context);
    final bool small = _isSmallPhone(context);

    return Scaffold(
      backgroundColor: tWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // WEB APPS SECTION
            Container(
              width: double.infinity,
              color: tWhite,
              padding: EdgeInsets.symmetric(
                horizontal: phone ? (small ? 14 : 18) : 60,
                vertical: phone ? 20 : 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBackButton(context),

                  SizedBox(height: phone ? 10 : 14),

                  Text(
                    'Web Apps',
                    style: GoogleFonts.manrope(
                      fontSize: phone ? (small ? 26 : 30) : 38,
                      fontWeight: FontWeight.w800,
                      color: tOrange1,
                    ),
                  ),

                  SizedBox(height: phone ? 8 : 10),

                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Text(
                      'Scalable and secure web applications that transform complex business processes into simple digital experiences.',
                      style: GoogleFonts.manrope(
                        fontSize: phone ? 13.5 : 15,
                        height: phone ? 1.5 : null,
                        color: tBlack.withOpacity(.55),
                      ),
                    ),
                  ),

                  SizedBox(height: phone ? 28 : 56),

                  _CardGrid(
                    cards: const [
                      // CARD 1
                      _WebServiceCardData(
                        image: 'images/trakfleet6.png',
                        logo: 'icons/trakfleet_web_logo.svg',
                        title: 'TrakFleet',
                        description:
                            'Scalable web platforms built around your business workflows, users and operational requirements.',
                      ),

                      // CARD 2
                      _WebServiceCardData(
                        image: 'images/fleet_management2.png',
                        logo: 'icons/trakmate_logo.svg',
                        title: 'Fleet Management',
                        description:
                            'Secure cloud-connected applications with centralized data and easy access from anywhere.',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // FOOTER
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}

// =========================================================
// BACK BUTTON
// =========================================================

Widget _buildBackButton(BuildContext context) {
  final bool isTablet = ResponsiveLayout.isTablet(context);

  return Align(
    alignment: Alignment.centerLeft,
    child: Material(
      color: tTransparent,
      child: InkWell(
        mouseCursor:
            isTablet ? SystemMouseCursors.basic : SystemMouseCursors.click,
        hoverColor: isTablet ? tTransparent : null,
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.arrow_back_rounded, size: 18, color: tBlue3),

              const SizedBox(width: 7),

              Text(
                'Back to Solutions',
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

// =========================================================
// DATA MODEL
// =========================================================

class _WebServiceCardData {
  final String image;
  final String logo;
  final String title;
  final String description;

  const _WebServiceCardData({
    required this.image,
    required this.logo,
    required this.title,
    required this.description,
  });
}

// =========================================================
// CARD GRID
// =========================================================

class _CardGrid extends StatelessWidget {
  final List<_WebServiceCardData> cards;

  const _CardGrid({required this.cards});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final spacing = isMobile ? 22.0 : 28.0;

        final twoCol = constraints.maxWidth > 820;

        final cardWidth =
            twoCol
                ? (constraints.maxWidth - spacing) / 2
                : constraints.maxWidth;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: List.generate(cards.length, (index) {
            // Alternates blue / orange CTA.
            final accent = index.isEven ? tBlue3 : tOrange;

            return _WebServiceCard(
              width: cardWidth,
              // Phones: height wraps the content. Tablet/desktop: fixed 500.
              height: isMobile ? null : 500,
              data: cards[index],
              accentColor: accent,
            );
          }),
        );
      },
    );
  }
}

// =========================================================
// CARD
// =========================================================

class _WebServiceCard extends StatelessWidget {
  final double width;
  final double? height;

  final _WebServiceCardData data;
  final Color accentColor;

  const _WebServiceCard({
    required this.width,
    required this.height,
    required this.data,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = ResponsiveLayout.isTablet(context);
    final bool isMobile = ResponsiveLayout.isMobile(context);

    // Very narrow cards: stack the two buttons vertically.
    final bool stackButtons = isMobile && width < 300;

    // IMAGE CALCULATIONS

    final imageInset = isMobile ? 10.0 : 12.0;
    const imageAspectRatio = 2.5;

    final imageInnerWidth = width - imageInset * 2;

    final imageBottom = imageInset + imageInnerWidth / imageAspectRatio;

    // Badge overlap (phones use a smaller badge)
    final double badgeOverlap = isMobile ? 18 : 22;

    // BUTTONS

    final double btnFont = isMobile ? 12 : 12.5;
    final double btnVPad = isMobile ? 11 : 12;

    final Widget demoButton = ElevatedButton.icon(
      onPressed: () {
        // TODO:
        // Launch demo URL
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: tOrange1.withOpacity(0.9),
        foregroundColor: tWhite,
        overlayColor: isTablet ? Colors.transparent : null,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: btnVPad),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      icon: const Icon(Icons.arrow_forward, size: 15),
      label: Text(
        'View Demo',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.manrope(
          fontSize: btnFont,
          fontWeight: FontWeight.w700,
        ),
      ),
    );

    final Widget websiteButton = OutlinedButton.icon(
      onPressed: () {
        showLoginDialog(context);
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: tBlue3,
        overlayColor: isTablet ? Colors.transparent : null,
        side: BorderSide(color: tBlack.withOpacity(.15)),
        padding: EdgeInsets.symmetric(vertical: btnVPad),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      icon: const Icon(Icons.north_east, size: 14),
      label: Text(
        'View website',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.manrope(
          fontSize: btnFont,
          fontWeight: FontWeight.w700,
        ),
      ),
    );

    // CARD

    return Container(
      width: width,
      height: height,

      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(isMobile ? 16 : 18),

        boxShadow: [
          BoxShadow(
            color: tBlack.withOpacity(.10),
            blurRadius: isMobile ? 20 : 26,
            offset: Offset(0, isMobile ? 8 : 12),
          ),
        ],
      ),

      child: Stack(
        clipBehavior: Clip.none,

        children: [
          // CARD CONTENT
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,

            children: [
              // PRODUCT IMAGE
              Padding(
                padding: EdgeInsets.fromLTRB(
                  imageInset,
                  imageInset,
                  imageInset,
                  0,
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(isMobile ? 12 : 14),

                  child: AspectRatio(
                    aspectRatio: imageAspectRatio,

                    child: Image.asset(
                      data.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // CARD FOOTER
              Padding(
                // On phones, extra top space keeps the title below the badge.
                padding:
                    isMobile
                        ? const EdgeInsets.fromLTRB(16, 34, 16, 18)
                        : const EdgeInsets.fromLTRB(20, 14, 20, 20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    // TITLE
                    Text(
                      data.title,

                      style: GoogleFonts.manrope(
                        fontSize: isMobile ? 18 : 19,
                        fontWeight: FontWeight.w800,
                        color: tBlue3,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // DESCRIPTION
                    Text(
                      data.description,

                      maxLines: isMobile ? 4 : 2,
                      overflow: TextOverflow.ellipsis,

                      style: GoogleFonts.manrope(
                        fontSize: 12.5,
                        height: 1.45,
                        color: tBlack.withOpacity(.55),
                      ),
                    ),

                    SizedBox(height: isMobile ? 14 : 16),

                    // BUTTONS
                    if (stackButtons)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          demoButton,
                          const SizedBox(height: 10),
                          websiteButton,
                        ],
                      )
                    else
                      Row(
                        children: [
                          Expanded(child: demoButton),
                          const SizedBox(width: 10),
                          Expanded(child: websiteButton),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),

          // FLOATING LOGO
          Positioned(
            right: isMobile ? 16 : 28,
            top: imageBottom - badgeOverlap,

            child: _TrakmateBadge(logo: data.logo),
          ),
        ],
      ),
    );
  }
}

// =========================================================
// FLOATING LOGO BADGE
// =========================================================

// =========================================================
// FLOATING LOGO BADGE
//
// The badge has a FIXED width + height for each screen size, and the logo is
// scaled to fit inside it. So every badge is exactly the same size, no matter
// which logo (or logo shape) is inside.
// =========================================================

class _TrakmateBadge extends StatelessWidget {
  final String logo;

  const _TrakmateBadge({required this.logo});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool small = _isSmallPhone(context);

    // Fixed badge size per screen size.
    final double badgeWidth = isMobile ? (small ? 104 : 116) : 140;
    final double badgeHeight = isMobile ? 40 : 52;

    return Container(
      width: badgeWidth,
      height: badgeHeight,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 16,
        vertical: isMobile ? 6 : 8,
      ),

      decoration: BoxDecoration(
        color: tWhite,

        borderRadius: BorderRadius.circular(isMobile ? 10 : 12),

        boxShadow: [
          BoxShadow(
            color: tBlack.withOpacity(.18),
            blurRadius: isMobile ? 14 : 20,
            offset: Offset(0, isMobile ? 6 : 8),
          ),
        ],
      ),

      // SizedBox.expand forces the logo to fill the badge's inner area and
      // BoxFit.contain scales it down to fit without distortion.
      child: SizedBox.expand(
        child: SvgPicture.asset(logo, fit: BoxFit.contain),
      ),
    );
  }
}
// =========================================================
// LOGIN DIALOG (email + password)
// =========================================================

class _LoginDialog extends StatefulWidget {
  const _LoginDialog();

  @override
  State<_LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<_LoginDialog>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _obscurePassword = true;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final Size screenSize = mq.size;

    final bool compact = screenSize.width < 650;
    final bool isSmall = screenSize.width < 360;

    final double availableHeight =
        screenSize.height - mq.viewInsets.bottom - mq.padding.top;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
      child: Center(
        child: Material(
          color: tTransparent,
          child: Container(
            width: compact ? screenSize.width * (isSmall ? 0.94 : 0.90) : 480,

            constraints: BoxConstraints(
              maxHeight: availableHeight * (compact ? 0.92 : 0.80),
            ),

            decoration: BoxDecoration(
              color: tWhite,

              borderRadius: BorderRadius.circular(compact ? 20 : 22),

              boxShadow: [
                BoxShadow(
                  color: tBlack.withOpacity(0.22),
                  blurRadius: 40,
                  offset: const Offset(0, 18),
                ),
              ],
            ),

            clipBehavior: Clip.antiAlias,

            child: Stack(
              children: [
                SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Padding(
                    padding:
                        compact
                            ? EdgeInsets.fromLTRB(
                              isSmall ? 18 : 22,
                              30,
                              isSmall ? 18 : 22,
                              24,
                            )
                            : const EdgeInsets.fromLTRB(34, 38, 34, 34),

                    child: FadeTransition(
                      opacity: _fadeAnimation,

                      child: SlideTransition(
                        position: _slideAnimation,

                        child: _buildLoginContent(compact, isSmall),
                      ),
                    ),
                  ),
                ),

                // CLOSE BUTTON
                Positioned(
                  top: compact ? 12 : 14,
                  right: compact ? 12 : 14,

                  child: Material(
                    color: tTransparent,

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
      ),
    );
  }

  // LOGIN CONTENT

  Widget _buildLoginContent(bool compact, bool isSmall) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        // TITLE
        Padding(
          padding: EdgeInsets.only(right: compact ? 38 : 0),
          child: Text(
            'Access Website',

            style: GoogleFonts.manrope(
              fontSize: compact ? (isSmall ? 24 : 26) : 30,
              fontWeight: FontWeight.w800,
              color: tBlue2,
              height: 1.12,
            ),
          ),
        ),

        const SizedBox(height: 7),

        // ORANGE LINE
        Container(
          height: 3,
          width: 65,

          decoration: BoxDecoration(
            color: tOrange1,
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        const SizedBox(height: 13),

        Text(
          'Please fill out your details to access the website',

          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: tBlack.withOpacity(0.55),
            height: 1.55,
          ),
        ),

        SizedBox(height: compact ? 24 : 34),

        // EMAIL
        _buildLoginField(
          controller: _emailController,
          label: 'Email *',
          hint: 'Enter your email',
          icon: Icons.email_outlined,
        ),

        const SizedBox(height: 18),

        // PASSWORD
        _buildPasswordField(),

        SizedBox(height: compact ? 22 : 28),

        // LOGIN BUTTON
        Align(
          alignment: compact ? Alignment.center : Alignment.centerRight,

          child: MouseRegion(
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

            child: GestureDetector(
              onTap: _handleLogin,

              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),

                // Full width button on phones
                width: compact ? double.infinity : null,

                transform: Matrix4.translationValues(0, _isHovered ? -2 : 0, 0),

                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 13,
                ),

                decoration: BoxDecoration(
                  color: tOrange1,

                  borderRadius: BorderRadius.circular(8),

                  boxShadow: [
                    BoxShadow(
                      color: tOrange1.withOpacity(_isHovered ? 0.30 : 0.16),

                      blurRadius: _isHovered ? 18 : 10,

                      offset: const Offset(0, 6),
                    ),
                  ],
                ),

                child: Row(
                  mainAxisSize: compact ? MainAxisSize.max : MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ACCESS',
                      style: GoogleFonts.manrope(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: tWhite,
                      ),
                    ),

                    const SizedBox(width: 10),

                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: tWhite,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // EMAIL FIELD

  Widget _buildLoginField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          label,

          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: tBlack.withOpacity(0.70),
          ),
        ),

        const SizedBox(height: 6),

        Container(
          height: 48,

          decoration: BoxDecoration(
            color: tWhite,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: tBlack.withOpacity(0.12)),
          ),

          child: TextField(
            controller: controller,

            keyboardType: TextInputType.emailAddress,

            textAlignVertical: TextAlignVertical.center,

            style: GoogleFonts.manrope(fontSize: 11, color: tBlack),

            decoration: InputDecoration(
              filled: true,
              fillColor: tWhite,

              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,

              contentPadding: const EdgeInsets.only(left: 4, right: 12),

              prefixIcon: SizedBox(
                width: 46,
                height: 48,

                child: Center(child: Icon(icon, size: 21, color: tBlue3)),
              ),

              prefixIconConstraints: const BoxConstraints(
                minWidth: 46,
                maxWidth: 46,
                minHeight: 48,
                maxHeight: 48,
              ),

              hintText: hint,

              hintStyle: GoogleFonts.manrope(
                fontSize: 13,
                color: tBlack.withOpacity(0.30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // PASSWORD FIELD

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          'Password *',

          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: tBlack.withOpacity(0.70),
          ),
        ),

        const SizedBox(height: 6),

        Container(
          height: 48,

          decoration: BoxDecoration(
            color: tWhite,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: tBlack.withOpacity(0.12)),
          ),

          child: TextField(
            controller: _passwordController,

            obscureText: _obscurePassword,

            textAlignVertical: TextAlignVertical.center,

            style: GoogleFonts.manrope(fontSize: 11, color: tBlack),

            decoration: InputDecoration(
              filled: true,
              fillColor: tWhite,

              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,

              contentPadding: const EdgeInsets.only(left: 4, right: 4),

              prefixIcon: const SizedBox(
                width: 46,
                height: 48,

                child: Center(
                  child: Icon(
                    Icons.lock_outline_rounded,
                    size: 21,
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

              suffixIcon: IconButton(
                splashRadius: 20,

                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },

                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 19,
                  color: tBlue3,
                ),
              ),

              hintText: 'Enter your password',

              hintStyle: GoogleFonts.manrope(
                fontSize: 13,
                color: tBlack.withOpacity(0.30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // LOGIN HANDLER

  void _handleLogin() {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter your email and password.',

            style: GoogleFonts.manrope(fontSize: 12),
          ),

          behavior: SnackBarBehavior.floating,
        ),
      );

      return;
    }

    // TODO:
    // Connect your login API here.
    //
    // final email = _emailController.text.trim();
    // final password = _passwordController.text.trim();
    // await yourLoginApi(email, password);

    Navigator.of(context).pop();

    // TODO:
    // After successful login, navigate to the website.
    //
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (_) => const YourWebsiteScreen()),
    // );
  }
}
