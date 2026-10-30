import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/widgets/footer_section.dart';
import 'package:trakmate_portal/src/utils/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/colors.dart';

// RESPONSIVE HELPERS (mobile only, tablet/desktop untouched)

/// Large + small phones.
bool _isPhone(BuildContext context) => MediaQuery.of(context).size.width < 600;

/// Small phones (e.g. iPhone SE, 320-359 wide).
bool _isSmallPhone(BuildContext context) =>
    MediaQuery.of(context).size.width < 360;

// MOBILE APP PAGE  (same UI as WebApp)

class MobileApp extends StatelessWidget {
  const MobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bool phone = _isPhone(context);
    final bool small = _isSmallPhone(context);

    return Scaffold(
      backgroundColor: tWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // MOBILE APPS SECTION
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
                    'Mobile Apps',
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
                      'Powerful and intuitive mobile applications that put your business operations in your pocket, anytime and anywhere.',
                      style: GoogleFonts.manrope(
                        fontSize: phone ? 13.5 : 15,
                        height: phone ? 1.5 : null,
                        color: tBlack.withOpacity(.55),
                      ),
                    ),
                  ),

                  SizedBox(height: phone ? 28 : 56),

                  _MobileCardGrid(
                    cards: const [
                      // CARD 1
                      _MobileServiceCardData(
                        image: 'images/trakFleet.png',
                        logo: 'icons/trakfleet_web_logo.svg',
                        title: 'TrakFleet',
                        description:
                            'Track vehicles, trips and alerts on the go with a fast, simple mobile experience built for your fleet.',
                        appStoreUrl:
                            'https://apps.apple.com/app/YOUR-TRAKFLEET-LINK',
                        playStoreUrl:
                            'https://play.google.com/store/apps/details?id=YOUR.TRAKFLEET.ID',
                      ),

                      // CARD 2
                      _MobileServiceCardData(
                        image: 'images/trakBlue.png',
                        logo: 'icons/trakmate_logo.svg',
                        title: 'TrakBlue',
                        description:
                            'Secure cloud-connected mobile apps with centralized data and easy access from anywhere.',
                        appStoreUrl:
                            'https://apps.apple.com/app/YOUR-TRAKBLUE-LINK',
                        playStoreUrl:
                            'https://play.google.com/store/apps/details?id=YOUR.TRAKBLUE.ID',
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

// BACK BUTTON

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

class _MobileServiceCardData {
  final String image;
  final String logo;
  final String title;
  final String description;
  final String appStoreUrl;
  final String playStoreUrl;

  const _MobileServiceCardData({
    required this.image,
    required this.logo,
    required this.title,
    required this.description,
    required this.appStoreUrl,
    required this.playStoreUrl,
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
    final bool phone = _isPhone(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final spacing = phone ? 22.0 : 28.0;

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
              // Height wraps the content on every screen size.
              height: null,
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
  final double? height;

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
        overlayColor: isTablet ? tTransparent : null,
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

    // INSTALL APP -> opens the QR dialog with this app's store links
    final Widget appButton = OutlinedButton.icon(
      onPressed:
          () => _showQrDialog(
            context,
            data.title,
            data.appStoreUrl,
            data.playStoreUrl,
          ),
      style: OutlinedButton.styleFrom(
        foregroundColor: tBlue3,
        overlayColor: isTablet ? tTransparent : null,
        side: BorderSide(color: tBlack.withOpacity(.15)),
        padding: EdgeInsets.symmetric(vertical: btnVPad),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      icon: const Icon(Icons.north_east, size: 14),
      label: Text(
        'Install App',
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
                      fit: BoxFit.contain,
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
                        fontSize: isMobile ? 12.5 : 12.5,
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
                          appButton,
                        ],
                      )
                    else
                      Row(
                        children: [
                          Expanded(child: demoButton),
                          const SizedBox(width: 10),
                          Expanded(child: appButton),
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

            child: _MobileBadge(logo: data.logo),
          ),
        ],
      ),
    );
  }
}

// =========================================================
// FLOATING LOGO BADGE
//
// The badge has a FIXED width + height for each screen size, and the logo is
// scaled to fit inside it. So every badge is exactly the same size, no matter
// which logo (or logo shape) is inside.
// =========================================================

class _MobileBadge extends StatelessWidget {
  final String logo;

  const _MobileBadge({required this.logo});

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
// QR INSTALL DIALOG  (QR card + App Store / Google Play cards)
// =========================================================

Future<void> _openStoreUrl(String url) async {
  final uri = Uri.parse(url);
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

void _showQrDialog(
  BuildContext context,
  String title,
  String appStoreUrl,
  String playStoreUrl,
) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Install App',
    barrierColor: tBlack.withOpacity(0.58),
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (context, animation, secondaryAnimation) {
      return _QrInstallDialog(
        title: title,
        appStoreUrl: appStoreUrl,
        playStoreUrl: playStoreUrl,
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final scale = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutBack,
        reverseCurve: Curves.easeInCubic,
      );
      final fade = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      );

      return FadeTransition(
        opacity: fade,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.85, end: 1.0).animate(scale),
          child: child,
        ),
      );
    },
  );
}

class _QrInstallDialog extends StatelessWidget {
  final String title;
  final String appStoreUrl;
  final String playStoreUrl;

  const _QrInstallDialog({
    required this.title,
    required this.appStoreUrl,
    required this.playStoreUrl,
  });

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    final bool isMobile = screen.width < 650;
    final bool isSmall = screen.width < 360;

    // Wider on desktop/tablet so the QR and the store cards sit side by side.
    final double dialogWidth =
        isMobile ? screen.width * (isSmall ? 0.92 : 0.88) : 640;

    return Center(
      child: Material(
        color: tTransparent,
        child: Container(
          width: dialogWidth,
          constraints: BoxConstraints(maxHeight: screen.height * 0.92),
          decoration: BoxDecoration(
            color: tWhite,
            borderRadius: BorderRadius.circular(isMobile ? 20 : 24),
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
                  padding: EdgeInsets.fromLTRB(
                    isMobile ? 22 : 36,
                    isMobile ? 28 : 34,
                    isMobile ? 22 : 36,
                    isMobile ? 26 : 32,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // TITLE
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 30 : 36,
                          ),
                          child: Text(
                            'Install $title',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.manrope(
                              fontSize: isMobile ? 22 : 26,
                              fontWeight: FontWeight.w800,
                              color: tBlue2,
                              height: 1.15,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // ORANGE LINE
                        Container(
                          width: 56,
                          height: 4,
                          decoration: BoxDecoration(
                            color: tOrange1,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // INSTRUCTION TEXT
                        Text(
                          'Scan the QR code or pick your store to get the app',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.manrope(
                            fontSize: isMobile ? 13.5 : 15,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            color: tBlack.withOpacity(0.55),
                          ),
                        ),

                        SizedBox(height: isMobile ? 20 : 24),

                        // QR + STORE CARDS PANEL
                        _InstallPanel(
                          isMobile: isMobile,
                          appStoreUrl: appStoreUrl,
                          playStoreUrl: playStoreUrl,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // CLOSE BUTTON
              Positioned(
                top: isMobile ? 12 : 16,
                right: isMobile ? 12 : 16,
                child: Material(
                  color: tTransparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: isMobile ? 36 : 42,
                      height: isMobile ? 36 : 42,
                      decoration: const BoxDecoration(
                        color: tBlue2,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        color: tWhite,
                        size: isMobile ? 20 : 24,
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
}

// =========================================================
// LIGHT GREY PANEL  (QR on the left, store cards on the right)
// Phones / narrow dialogs: the QR sits on top, cards below.
// =========================================================

class _InstallPanel extends StatelessWidget {
  final bool isMobile;
  final String appStoreUrl;
  final String playStoreUrl;

  const _InstallPanel({
    required this.isMobile,
    required this.appStoreUrl,
    required this.playStoreUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 14 : 20),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(18),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool sideBySide = constraints.maxWidth >= 380;

          final Widget qr = _QrCard(
            size: sideBySide ? 190 : constraints.maxWidth.clamp(150.0, 210.0),
          );

          final Widget cards = Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _StoreCard(
                url: appStoreUrl,
                smallText: 'Download on the',
                bigText: 'App Store',
                // Your SVG is black, so it is tinted white here.
                icon: SvgPicture.asset(
                  'icons/apple.svg',
                  width: 30,
                  height: 30,
                  colorFilter: const ColorFilter.mode(tWhite, BlendMode.srcIn),
                ),
              ),
              const SizedBox(height: 16),
              _StoreCard(
                url: playStoreUrl,
                smallText: 'GET IT ON',
                bigText: 'Google Play',
                // Keeps its original colors (no colorFilter).
                icon: SvgPicture.asset(
                  'icons/playstore.svg',
                  width: 28,
                  height: 28,
                ),
              ),
            ],
          );

          if (sideBySide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [qr, const SizedBox(width: 24), Expanded(child: cards)],
            );
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [qr, const SizedBox(height: 18), cards],
          );
        },
      ),
    );
  }
}

// QR CARD  (grey frame, white QR box, "Download App" label)

class _QrCard extends StatelessWidget {
  final double size;

  const _QrCard({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
      decoration: BoxDecoration(
        color: tOrange1.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: tWhite,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                'images/qr.png',
                fit: BoxFit.contain,
                filterQuality: FilterQuality.none,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Download App',
            style: GoogleFonts.manrope(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: tWhite,
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================
// STORE CARD  (black, clickable, opens the store URL)
// =========================================================

class _StoreCard extends StatefulWidget {
  final String url;
  final String smallText;
  final String bigText;
  final Widget icon;

  const _StoreCard({
    required this.url,
    required this.smallText,
    required this.bigText,
    required this.icon,
  });

  @override
  State<_StoreCard> createState() => _StoreCardState();
}

class _StoreCardState extends State<_StoreCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => _openStoreUrl(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 62,
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: tBlack,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: tWhite.withOpacity(0.25), width: 1),
            boxShadow: [
              BoxShadow(
                color: tBlack.withOpacity(_hovered ? 0.28 : 0.14),
                blurRadius: _hovered ? 16 : 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon,
              const SizedBox(width: 12),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.smallText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.manrope(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w500,
                        color: tWhite,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.bigText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.manrope(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        color: tWhite,
                        height: 1.1,
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

              borderRadius: BorderRadius.circular(isMobile ? 20 : 24),

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
                Positioned(
                  top: isMobile ? 12 : 16,
                  right: isMobile ? 12 : 16,

                  child: Material(
                    color: tTransparent,

                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),

                      onTap: () {
                        Navigator.of(context).pop();
                      },

                      child: Container(
                        width: isMobile ? 36 : 42,
                        height: isMobile ? 36 : 42,

                        decoration: const BoxDecoration(
                          color: tBlue2,
                          shape: BoxShape.circle,
                        ),

                        child: Icon(
                          Icons.close_rounded,
                          color: tWhite,
                          size: isMobile ? 20 : 24,
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

  // FORM CONTENT

  Widget _buildAccessForm(bool isMobile, bool isSmall) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        // TITLE
        Padding(
          // keeps the title clear of the close button on phones
          padding: EdgeInsets.only(right: isMobile ? 40 : 0),
          child: Text(
            'Access App',

            style: GoogleFonts.manrope(
              fontSize: isMobile ? (isSmall ? 26 : 30) : 36,
              fontWeight: FontWeight.w800,
              color: tBlue2,
              height: 1.1,
            ),
          ),
        ),

        SizedBox(height: isMobile ? 8 : 10),

        // ORANGE LINE
        Container(
          width: isMobile ? 64 : 80,
          height: 4,

          decoration: BoxDecoration(
            color: tOrange1,

            borderRadius: BorderRadius.circular(10),
          ),
        ),

        SizedBox(height: isMobile ? 12 : 16),

        // DESCRIPTION
        Text(
          'Please fill out your details to access the app',

          style: GoogleFonts.manrope(
            fontSize: isMobile ? 13.5 : 15,
            fontWeight: FontWeight.w500,
            color: tBlack.withOpacity(0.50),
          ),
        ),

        SizedBox(height: isMobile ? 20 : 28),

        // FULL NAME
        _buildTextField(
          controller: _fullNameController,
          label: 'Full Name',
          hint: 'John Doe',
          icon: 'icons/person2.svg',
          isRequired: true,
          isMobile: isMobile,
        ),

        SizedBox(height: isMobile ? 14 : 18),

        // COMPANY (not required)
        _buildTextField(
          controller: _companyController,
          label: 'Company',
          hint: 'Your company name',
          icon: 'icons/career1.svg',
          isRequired: false,
          isMobile: isMobile,
        ),

        SizedBox(height: isMobile ? 14 : 18),

        // CITY
        _buildTextField(
          controller: _cityController,
          label: 'City',
          hint: 'Your city',
          icon: 'icons/location1.svg',
          isRequired: true,
          isMobile: isMobile,
        ),

        SizedBox(height: isMobile ? 14 : 18),

        // EMAIL
        _buildTextField(
          controller: _emailController,
          label: 'Email',
          hint: 'you@example.com',
          icon: 'icons/mail.svg',
          keyboardType: TextInputType.emailAddress,
          isRequired: true,
          isMobile: isMobile,
        ),

        SizedBox(height: isMobile ? 14 : 18),

        // PHONE
        _buildTextField(
          controller: _phoneController,
          label: 'Phone Number',
          hint: '+1 (555) 000-0000',
          icon: 'icons/phone.svg',
          keyboardType: TextInputType.phone,
          isRequired: true,
          isMobile: isMobile,
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

        SizedBox(height: isMobile ? 8 : 12),

        // ACCESS BUTTON
        Align(
          alignment: isMobile ? Alignment.center : Alignment.centerRight,

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

                // Full width button on phones
                width: isMobile ? double.infinity : null,

                transform: Matrix4.translationValues(
                  0,
                  _isAccessHovered ? -2 : 0,
                  0,
                ),

                padding: EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: isMobile ? 14 : 15,
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
                  mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,

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
