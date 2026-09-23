import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/widgets/footer_section.dart';

import '../../utils/colors.dart';

void showLoginDialog(BuildContext context) {
  Future.delayed(const Duration(milliseconds: 180), () {
    if (!context.mounted) return;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Access Website',
      barrierColor: tBlack.withOpacity(0.58),
      transitionDuration: const Duration(milliseconds: 500),

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
            scale: Tween<double>(begin: 0.78, end: 1.0).animate(scaleAnimation),
            child: child,
          ),
        );
      },
    );
  });
}

// =========================================================
// ACCESS WEBSITE DIALOG
// =========================================================

class _AccessWebsiteDialog extends StatefulWidget {
  const _AccessWebsiteDialog();

  @override
  State<_AccessWebsiteDialog> createState() => _AccessWebsiteDialogState();
}

// =========================================================
// STATE
// =========================================================

class _AccessWebsiteDialogState extends State<_AccessWebsiteDialog>
    with SingleTickerProviderStateMixin {
  // =======================================================
  // CONTROLLERS
  // =======================================================

  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _companyController = TextEditingController();

  final TextEditingController _cityController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  // =======================================================
  // ANIMATION
  // =======================================================

  late AnimationController _animationController;

  late Animation<double> _fadeAnimation;

  late Animation<Offset> _slideAnimation;

  // =======================================================
  // BUTTON HOVER
  // =======================================================

  bool _isLoginHovered = false;

  // =======================================================
  // INIT
  // =======================================================

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

  // =======================================================
  // BUILD
  // =======================================================

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final bool isMobile = screenSize.width < 650;

    return Center(
      child: Material(
        color: tTransparent,

        child: Container(
          width: isMobile ? screenSize.width * 0.90 : 600,

          constraints: BoxConstraints(maxHeight: screenSize.height * 0.90),

          decoration: BoxDecoration(
            color: tWhite,

            borderRadius: BorderRadius.circular(24),

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
              // =================================================
              // FORM
              // =================================================
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    isMobile ? 24 : 42,
                    34,
                    isMobile ? 24 : 42,
                    34,
                  ),

                  child: FadeTransition(
                    opacity: _fadeAnimation,

                    child: SlideTransition(
                      position: _slideAnimation,

                      child: _buildAccessForm(),
                    ),
                  ),
                ),
              ),

              // =================================================
              // CLOSE BUTTON
              // =================================================
              Positioned(
                top: 16,
                right: 16,

                child: Material(
                  color: tTransparent,

                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),

                    onTap: () {
                      Navigator.of(context).pop();
                    },

                    child: Container(
                      width: 42,
                      height: 42,

                      decoration: const BoxDecoration(
                        color: tBlue2,
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.close_rounded,
                        color: tWhite,
                        size: 24,
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

  // =========================================================
  // FORM CONTENT
  // =========================================================

  Widget _buildAccessForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        // =====================================================
        // TITLE
        // =====================================================
        Text(
          'Access Website',

          style: GoogleFonts.manrope(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: tBlue2,
            height: 1.1,
          ),
        ),

        const SizedBox(height: 10),

        // =====================================================
        // ORANGE LINE
        // =====================================================
        Container(
          width: 80,
          height: 4,

          decoration: BoxDecoration(
            color: tOrange1,

            borderRadius: BorderRadius.circular(10),
          ),
        ),

        const SizedBox(height: 16),

        // =====================================================
        // DESCRIPTION
        // =====================================================
        Text(
          'Please fill out your details to access the website',

          style: GoogleFonts.manrope(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: tBlack.withOpacity(0.50),
          ),
        ),

        const SizedBox(height: 28),

        // =====================================================
        // FULL NAME
        // =====================================================
        _buildTextField(
          controller: _fullNameController,

          label: 'Full Name',

          hint: 'John Doe',

          icon: Icons.person_outline_rounded,

          isRequired: true,
        ),

        const SizedBox(height: 18),

        // =====================================================
        // COMPANY
        // =====================================================
        _buildTextField(
          controller: _companyController,

          label: 'Company',

          hint: 'Your company name',

          icon: Icons.business_outlined,

          // IMPORTANT:
          // Company is NOT required.
          isRequired: false,
        ),

        const SizedBox(height: 18),

        // =====================================================
        // CITY
        // =====================================================
        _buildTextField(
          controller: _cityController,

          label: 'City',

          hint: 'Your city',

          icon: Icons.location_on_outlined,

          isRequired: true,
        ),

        const SizedBox(height: 18),

        // =====================================================
        // EMAIL
        // =====================================================
        _buildTextField(
          controller: _emailController,

          label: 'Email',

          hint: 'you@example.com',

          icon: Icons.email_outlined,

          keyboardType: TextInputType.emailAddress,

          isRequired: true,
        ),

        const SizedBox(height: 18),

        // =====================================================
        // PHONE
        // =====================================================
        _buildTextField(
          controller: _phoneController,

          label: 'Phone Number',

          hint: '+1 (555) 000-0000',

          icon: Icons.phone_outlined,

          keyboardType: TextInputType.phone,

          isRequired: true,
        ),

        const SizedBox(height: 28),

        // =====================================================
        // LOGIN BUTTON
        // =====================================================
        Align(
          alignment: Alignment.centerRight,

          child: MouseRegion(
            cursor: SystemMouseCursors.click,

            onEnter: (_) {
              setState(() {
                _isLoginHovered = true;
              });
            },

            onExit: (_) {
              setState(() {
                _isLoginHovered = false;
              });
            },

            child: GestureDetector(
              onTap: _handleAccessWebsite,

              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),

                transform: Matrix4.translationValues(
                  0,
                  _isLoginHovered ? -2 : 0,
                  0,
                ),

                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 15,
                ),

                decoration: BoxDecoration(
                  color: tOrange1,

                  borderRadius: BorderRadius.circular(9),

                  boxShadow: [
                    BoxShadow(
                      color: tOrange1.withOpacity(
                        _isLoginHovered ? 0.30 : 0.16,
                      ),

                      blurRadius: _isLoginHovered ? 20 : 12,

                      offset: const Offset(0, 7),
                    ),
                  ],
                ),

                child: Row(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Text(
                      'LOGIN',

                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: tWhite,
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: tWhite,
                      size: 18,
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

  // =========================================================
  // TEXT FIELD
  // =========================================================

  Widget _buildTextField({
    required TextEditingController controller,

    required String label,

    required String hint,

    required IconData icon,

    bool isRequired = false,

    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        // =====================================================
        // LABEL
        // =====================================================
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label,

                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: tBlack.withOpacity(0.80),
                ),
              ),

              if (isRequired)
                TextSpan(
                  text: ' *',

                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: tRed1,
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 7),

        // =====================================================
        // INPUT
        // =====================================================
        Container(
          height: 52,

          decoration: BoxDecoration(
            color: tWhite,

            borderRadius: BorderRadius.circular(10),

            border: Border.all(color: tBlack.withOpacity(0.10), width: 1),
          ),

          child: TextField(
            controller: controller,

            keyboardType: keyboardType,

            textAlignVertical: TextAlignVertical.center,

            style: GoogleFonts.manrope(
              fontSize: 14,
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
                width: 50,

                child: Center(child: Icon(icon, size: 21, color: tBlue3)),
              ),

              prefixIconConstraints: const BoxConstraints(
                minWidth: 50,
                maxWidth: 50,
              ),

              hintText: hint,

              hintStyle: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: tBlack.withOpacity(0.30),
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
    // =======================================================
    // REQUIRED VALIDATION
    // =======================================================

    if (_fullNameController.text.trim().isEmpty) {
      _showValidationMessage('Please enter your full name.');

      return;
    }

    // Company intentionally NOT validated.
    // It is optional.

    if (_cityController.text.trim().isEmpty) {
      _showValidationMessage('Please enter your city.');

      return;
    }

    if (_emailController.text.trim().isEmpty) {
      _showValidationMessage('Please enter your email.');

      return;
    }

    if (_phoneController.text.trim().isEmpty) {
      _showValidationMessage('Please enter your phone number.');

      return;
    }

    // =======================================================
    // GET VALUES
    // =======================================================

    final String fullName = _fullNameController.text.trim();

    final String company = _companyController.text.trim();

    final String city = _cityController.text.trim();

    final String email = _emailController.text.trim();

    final String phone = _phoneController.text.trim();

    // =======================================================
    // TODO:
    // SEND THESE VALUES TO YOUR API
    // =======================================================

    print('Full Name: $fullName');
    print('Company: $company');
    print('City: $city');
    print('Email: $email');
    print('Phone: $phone');

    // =======================================================
    // CLOSE POPUP
    // =======================================================

    Navigator.of(context).pop();

    // =======================================================
    // AFTER SUCCESSFUL API CALL
    // NAVIGATE TO WEBSITE HERE
    // =======================================================

    // Example:
    //
    // launchUrl(
    //   Uri.parse(
    //     'https://yourwebsite.com',
    //   ),
    // );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Details submitted successfully.',
          style: GoogleFonts.manrope(fontSize: 12),
        ),

        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // =========================================================
  // VALIDATION MESSAGE
  // =========================================================

  void _showValidationMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.manrope(fontSize: 12)),

        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
// =========================================================
// WEB APP
// =========================================================

class WebApp extends StatelessWidget {
  const WebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // =====================================================
            // WEB APPS SECTION
            // =====================================================
            Container(
              width: double.infinity,
              color: tWhite,
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBackButton(context),

                  const SizedBox(height: 14),

                  Text(
                    'Web Apps',
                    style: GoogleFonts.manrope(
                      fontSize: 38,
                      fontWeight: FontWeight.w800,
                      color: tOrange1,
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: 560,
                    child: Text(
                      'Scalable and secure web applications that transform complex business processes into simple digital experiences.',
                      style: GoogleFonts.manrope(
                        fontSize: 15,
                        color: tBlack.withOpacity(.55),
                      ),
                    ),
                  ),

                  const SizedBox(height: 56),

                  _CardGrid(
                    cards: const [
                      // =================================================
                      // CARD 1
                      // =================================================
                      _WebServiceCardData(
                        image: 'images/trakfleet.png',
                        logo: 'icons/trakfleet_logo.svg',
                        title: 'TrakFleet',
                        description:
                            'Scalable web platforms built around your business workflows, users and operational requirements.',
                      ),

                      // =================================================
                      // CARD 2
                      // =================================================
                      _WebServiceCardData(
                        image: 'images/esync_login.png',
                        logo: 'icons/esync.svg',
                        title: 'Esync',
                        description:
                            'Secure cloud-connected applications with centralized data and easy access from anywhere.',
                      ),

                      // =================================================
                      // CARD 3
                      // =================================================
                      // _WebServiceCardData(
                      //   image: 'images/trakfleet.png',
                      //   logo: 'icons/trakfleet_logo.svg',
                      //   title: 'IoT Integration',
                      //   description:
                      //       'Connect web applications with devices, vehicles and real-time IoT data.',
                      // ),

                      // =================================================
                      // CARD 4
                      // =================================================
                      // _WebServiceCardData(
                      //   image: 'images/trakfleet.png',
                      //   logo: 'icons/trakfleet_logo.svg',
                      //   title: 'Dashboards & Analytics',
                      //   description:
                      //       'Transform business and device data into clear dashboards, reports and actionable insights.',
                      // ),

                      // =================================================
                      // CARD 5
                      // =================================================
                      // _WebServiceCardData(
                      //   image: 'images/trakfleet.png',
                      //   logo: 'icons/trakfleet_logo.svg',
                      //   title: 'Custom Portals',
                      //   description:
                      //       'Tailored client and admin portals with role-based access and streamlined workflows.',
                      // ),

                      // =================================================
                      // CARD 6
                      // =================================================
                      // _WebServiceCardData(
                      //   image: 'images/trakfleet.png',
                      //   logo: 'icons/trakfleet_logo.svg',
                      //   title: 'API & Integrations',
                      //   description:
                      //       'Connect your web app to third-party services and internal systems through robust APIs.',
                      // ),
                    ],
                  ),
                ],
              ),
            ),

            // =====================================================
            // FOOTER
            // =====================================================
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
  return Align(
    alignment: Alignment.centerLeft,
    child: Material(
      color: tTransparent,
      child: InkWell(
        mouseCursor: SystemMouseCursors.click,
        borderRadius: BorderRadius.circular(7),
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
// SECTION EYEBROW
// =========================================================

class _SectionEyebrow extends StatelessWidget {
  final String label;

  const _SectionEyebrow({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 22, height: 2.5, color: tOrange),

        const SizedBox(width: 10),

        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
            color: tOrange,
          ),
        ),
      ],
    );
  }
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
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 28.0;

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
  final _WebServiceCardData data;
  final Color accentColor;

  const _WebServiceCard({
    required this.width,
    required this.data,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    // =====================================================
    // IMAGE CALCULATIONS
    // =====================================================

    const imageInset = 12.0;
    const imageAspectRatio = 2.5;

    final imageInnerWidth = width - imageInset * 2;

    final imageBottom = imageInset + imageInnerWidth / imageAspectRatio;

    // =====================================================
    // CARD
    // =====================================================

    return Container(
      width: width,

      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: tBlack.withOpacity(.10),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),

      child: Stack(
        clipBehavior: Clip.none,

        children: [
          // =================================================
          // CARD CONTENT
          // =================================================
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,

            children: [
              // =================================================
              // PRODUCT IMAGE
              // =================================================
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  imageInset,
                  imageInset,
                  imageInset,
                  0,
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),

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

              // =================================================
              // CARD FOOTER
              // =================================================
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    // ===========================================
                    // TITLE
                    // ===========================================
                    Text(
                      data.title,

                      style: GoogleFonts.manrope(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: tBlue3,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // ===========================================
                    // DESCRIPTION
                    // ===========================================
                    Text(
                      data.description,

                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,

                      style: GoogleFonts.manrope(
                        fontSize: 12.5,
                        height: 1.45,
                        color: tBlack.withOpacity(.55),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ===========================================
                    // BUTTONS
                    // ===========================================
                    Row(
                      children: [
                        // =======================================
                        // VIEW DEMO
                        // =======================================
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // TODO:
                              // Launch demo URL
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: tOrange1.withOpacity(0.9),
                              foregroundColor: tWhite,
                              elevation: 0,

                              padding: const EdgeInsets.symmetric(vertical: 12),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),

                            icon: const Icon(Icons.arrow_forward, size: 15),

                            label: Text(
                              'View Demo',

                              style: GoogleFonts.manrope(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        // =======================================
                        // VIEW WEBSITE
                        // =======================================
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              showLoginDialog(context);
                            },

                            style: OutlinedButton.styleFrom(
                              foregroundColor: tBlue3,

                              side: BorderSide(color: tBlack.withOpacity(.15)),

                              padding: const EdgeInsets.symmetric(vertical: 12),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),

                            icon: const Icon(Icons.north_east, size: 14),

                            label: Text(
                              'View website',

                              style: GoogleFonts.manrope(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // =================================================
          // FLOATING LOGO
          // =================================================
          Positioned(
            right: 28,
            top: imageBottom - 22,

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

class _TrakmateBadge extends StatelessWidget {
  final String logo;

  const _TrakmateBadge({required this.logo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),

      decoration: BoxDecoration(
        color: tWhite,

        borderRadius: BorderRadius.circular(12),

        boxShadow: [
          BoxShadow(
            color: tBlack.withOpacity(.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: SvgPicture.asset(logo, height: 40, width: 60),
    );
  }
}

// =========================================================
// LOGIN DIALOG
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
    final Size screenSize = MediaQuery.of(context).size;

    final bool compact = screenSize.width < 650;

    return Center(
      child: Material(
        color: tTransparent,
        child: Container(
          width: compact ? screenSize.width * 0.88 : 480,

          constraints: BoxConstraints(maxHeight: screenSize.height * 0.80),

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

                  child: FadeTransition(
                    opacity: _fadeAnimation,

                    child: SlideTransition(
                      position: _slideAnimation,

                      child: _buildLoginContent(),
                    ),
                  ),
                ),
              ),

              // =================================================
              // CLOSE BUTTON
              // =================================================
              Positioned(
                top: 14,
                right: 14,

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
    );
  }

  // =========================================================
  // LOGIN CONTENT
  // =========================================================

  Widget _buildLoginContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        // =====================================================
        // TITLE
        // =====================================================
        Text(
          'Access Website',

          style: GoogleFonts.manrope(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: tBlue2,
            height: 1.12,
          ),
        ),

        const SizedBox(height: 7),

        // =====================================================
        // ORANGE LINE
        // =====================================================
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

        const SizedBox(height: 34),

        // =====================================================
        // EMAIL
        // =====================================================
        _buildLoginField(
          controller: _emailController,
          label: 'Email *',
          hint: 'Enter your email',
          icon: Icons.email_outlined,
        ),

        const SizedBox(height: 18),

        // =====================================================
        // PASSWORD
        // =====================================================
        _buildPasswordField(),

        const SizedBox(height: 28),

        // =====================================================
        // LOGIN BUTTON
        // =====================================================
        Align(
          alignment: Alignment.centerRight,

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
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Text(
                      'LOGIN',

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

  // =========================================================
  // EMAIL FIELD
  // =========================================================

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

  // =========================================================
  // PASSWORD FIELD
  // =========================================================

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

  // =========================================================
  // LOGIN HANDLER
  // =========================================================

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

    // =====================================================
    // TODO:
    // Connect your login API here.
    //
    // Example:
    //
    // final email =
    //     _emailController.text.trim();
    //
    // final password =
    //     _passwordController.text.trim();
    //
    // await yourLoginApi(
    //   email,
    //   password,
    // );
    // =====================================================

    Navigator.of(context).pop();

    // =====================================================
    // TODO:
    // After successful login, navigate to the website.
    //
    // Example:
    //
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) =>
    //         const YourWebsiteScreen(),
    //   ),
    // );
    // =====================================================
  }
}
