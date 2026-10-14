import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/widgets/footer_section.dart';

import '../../utils/colors.dart';

// =========================================================
// MOBILE APP PAGE  (same UI as WebApp)
// =========================================================

class MobileApp extends StatelessWidget {
  const MobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // MOBILE APPS SECTION
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
                    'Mobile Apps',
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
                      'Powerful and intuitive mobile applications that put your business operations in your pocket, anytime and anywhere.',
                      style: GoogleFonts.manrope(
                        fontSize: 15,
                        color: tBlack.withOpacity(.55),
                      ),
                    ),
                  ),

                  const SizedBox(height: 56),

                  _MobileCardGrid(
                    cards: const [
                      // CARD 1
                      _MobileServiceCardData(
                        image: 'images/mobile_app5.png',
                        logo: 'icons/trakfleet_web_logo.svg',
                        title: 'TrakFleet',
                        description:
                            'Track vehicles, trips and alerts on the go with a fast, simple mobile experience built for your fleet.',
                      ),

                      // CARD 2
                      _MobileServiceCardData(
                        image: 'images/mobile_appp1.png',
                        logo: 'icons/trakmate_logo.svg',
                        title: 'Fleet Management',
                        description:
                            'Secure cloud-connected mobile apps with centralized data and easy access from anywhere.',
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
  return Align(
    alignment: Alignment.centerLeft,
    child: Material(
      color: tTransparent,
      child: InkWell(
        mouseCursor: SystemMouseCursors.click,
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

class _MobileServiceCardData {
  final String image;
  final String logo;
  final String title;
  final String description;

  const _MobileServiceCardData({
    required this.image,
    required this.logo,
    required this.title,
    required this.description,
  });
}

// =========================================================
// CARD GRID
// =========================================================

class _MobileCardGrid extends StatelessWidget {
  final List<_MobileServiceCardData> cards;

  const _MobileCardGrid({required this.cards});

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

            return _MobileServiceCard(
              width: cardWidth,
              height: 500,
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

class _MobileServiceCard extends StatelessWidget {
  final double width;
  final double height;

  final _MobileServiceCardData data;
  final Color accentColor;

  const _MobileServiceCard({
    required this.width,
    required this.height,
    required this.data,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    // IMAGE CALCULATIONS

    const imageInset = 12.0;
    const imageAspectRatio = 2.5;

    final imageInnerWidth = width - imageInset * 2;

    final imageBottom = imageInset + imageInnerWidth / imageAspectRatio;

    // CARD

    return Container(
      width: width,
      height: height,

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
          // CARD CONTENT
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,

            children: [
              // PRODUCT IMAGE
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
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              // CARD FOOTER
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    // TITLE
                    Text(
                      data.title,

                      style: GoogleFonts.manrope(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: tBlue3,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // DESCRIPTION
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

                    // BUTTONS
                    Row(
                      children: [
                        // VIEW DEMO
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

                        // VIEW APP
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              _showAccessDialog(context);
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
                              'View App',

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

          // FLOATING LOGO
          Positioned(
            right: 28,
            top: imageBottom - 22,

            child: _MobileBadge(logo: data.logo),
          ),
        ],
      ),
    );
  }
}

// =========================================================
// FLOATING LOGO BADGE
// =========================================================

class _MobileBadge extends StatelessWidget {
  final String logo;

  const _MobileBadge({required this.logo});

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
// ACCESS DIALOG
// =========================================================

void _showAccessDialog(BuildContext context) {
  Future.delayed(const Duration(milliseconds: 180), () {
    if (!context.mounted) return;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Access App',
      barrierColor: tBlack.withOpacity(0.58),
      transitionDuration: const Duration(milliseconds: 500),

      pageBuilder: (context, animation, secondaryAnimation) {
        return const _AccessAppDialog();
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

class _AccessAppDialog extends StatefulWidget {
  const _AccessAppDialog();

  @override
  State<_AccessAppDialog> createState() => _AccessAppDialogState();
}

class _AccessAppDialogState extends State<_AccessAppDialog>
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
  bool _isAccessHovered = false;

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
              // FORM
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

              // CLOSE BUTTON
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

  // FORM CONTENT

  Widget _buildAccessForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        // TITLE
        Text(
          'Access App',

          style: GoogleFonts.manrope(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: tBlue2,
            height: 1.1,
          ),
        ),

        const SizedBox(height: 10),

        // ORANGE LINE
        Container(
          width: 80,
          height: 4,

          decoration: BoxDecoration(
            color: tOrange1,

            borderRadius: BorderRadius.circular(10),
          ),
        ),

        const SizedBox(height: 16),

        // DESCRIPTION
        Text(
          'Please fill out your details to access the app',

          style: GoogleFonts.manrope(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: tBlack.withOpacity(0.50),
          ),
        ),

        const SizedBox(height: 28),

        // FULL NAME
        _buildTextField(
          controller: _fullNameController,
          label: 'Full Name',
          hint: 'John Doe',
          icon: 'icons/person2.svg',
          isRequired: true,
        ),

        const SizedBox(height: 18),

        // COMPANY (not required)
        _buildTextField(
          controller: _companyController,
          label: 'Company',
          hint: 'Your company name',
          icon: 'icons/career1.svg',
          isRequired: false,
        ),

        const SizedBox(height: 18),

        // CITY
        _buildTextField(
          controller: _cityController,
          label: 'City',
          hint: 'Your city',
          icon: 'icons/location1.svg',
          isRequired: true,
        ),

        const SizedBox(height: 18),

        // EMAIL
        _buildTextField(
          controller: _emailController,
          label: 'Email',
          hint: 'you@example.com',
          icon: 'icons/mail.svg',
          keyboardType: TextInputType.emailAddress,
          isRequired: true,
        ),

        const SizedBox(height: 18),

        // PHONE
        _buildTextField(
          controller: _phoneController,
          label: 'Phone Number',
          hint: '+1 (555) 000-0000',
          icon: 'icons/phone.svg',
          keyboardType: TextInputType.phone,
          isRequired: true,
        ),

        const SizedBox(height: 8),

        // Fixed-height slot: always reserves space so the button never shifts
        SizedBox(
          height: 18,
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: _validationMessage != null ? 1.0 : 0.0,
              child: Text(
                _validationMessage ?? '',
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  color: tRed1,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // ACCESS BUTTON
        Align(
          alignment: Alignment.centerRight,

          child: MouseRegion(
            cursor: SystemMouseCursors.click,

            onEnter: (_) {
              setState(() {
                _isAccessHovered = true;
              });
            },

            onExit: (_) {
              setState(() {
                _isAccessHovered = false;
              });
            },

            child: GestureDetector(
              onTap: _handleAccessApp,

              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),

                transform: Matrix4.translationValues(
                  0,
                  _isAccessHovered ? -2 : 0,
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
                        _isAccessHovered ? 0.30 : 0.16,
                      ),

                      blurRadius: _isAccessHovered ? 20 : 12,

                      offset: const Offset(0, 7),
                    ),
                  ],
                ),

                child: Row(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Text(
                      'ACCESS',
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

  // TEXT FIELD

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String icon,
    bool isRequired = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
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

        // INPUT
        Container(
          height: 52,
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

                  child: Center(
                    child: SvgPicture.asset(
                      icon,
                      width: 21,
                      height: 21,
                      colorFilter: const ColorFilter.mode(
                        tBlue3,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
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
        ),
      ],
    );
  }

  // SUBMIT

  void _handleAccessApp() {
    if (_fullNameController.text.trim().isEmpty ||
        _cityController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty) {
      setState(() {
        _validationMessage = 'Please fill every required field.';
      });
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

    debugPrint('Full Name: $fullName');
    debugPrint('Company: $company');
    debugPrint('City: $city');
    debugPrint('Email: $email');
    debugPrint('Phone: $phone');

    Navigator.of(context).pop();

    // TODO: API call / navigation
  }
}
