import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
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
// DATA MODELS
// =========================================================

class SolutionCardData {
  final String image;
  final String icon;
  final String title;
  final String description;

  const SolutionCardData(this.image, this.icon, this.title, this.description);
}

class SolutionDetailsData {
  final String backgroundImage;
  final String icon;
  final String eyebrow;
  final String title;
  final String description;
  final Color iconBackgroundColor;
  final List<SolutionCardData> cards;

  const SolutionDetailsData({
    required this.backgroundImage,
    required this.icon,
    required this.iconBackgroundColor,
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.cards,
  });
}

// =========================================================
// PAGE
// =========================================================

class SolutionsDetailsPage extends StatelessWidget {
  final SolutionDetailsData data;

  const SolutionsDetailsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final bool phone = _isPhone(context);
    final bool small = _isSmallPhone(context);

    return Scaffold(
      backgroundColor: tWhite,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding:
                      phone
                          ? EdgeInsets.fromLTRB(
                            small ? 14 : 18,
                            phone ? 22 : 34,
                            small ? 14 : 18,
                            36,
                          )
                          : const EdgeInsets.fromLTRB(34, 34, 34, 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeading(context),

                      SizedBox(height: phone ? 24 : 34),

                      _buildCards(),

                      SizedBox(height: phone ? 32 : 48),
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

  // ========================================================================
  // TOP BAR
  // ========================================================================

  Widget _buildTopBar(BuildContext context) {
    final bool phone = _isPhone(context);
    final bool small = _isSmallPhone(context);

    return Container(
      width: double.infinity,
      height: phone ? 56 : 64,
      decoration: BoxDecoration(
        color: tWhite,
        border: Border(bottom: BorderSide(color: tBlue2.withOpacity(0.07))),
        boxShadow: [
          BoxShadow(
            color: tBlack.withOpacity(0.025),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: phone ? (small ? 8 : 12) : 34),
      child: Row(
        children: [
          _HoverBackButton(onTap: () => Navigator.pop(context)),

          const SizedBox(width: 8),

          const Spacer(),

          // Flexible so a long title never overflows on narrow phones.
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: phone ? 11 : 13,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: tBlue2.withOpacity(0.045),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: tBlue2.withOpacity(0.07)),
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

                  Flexible(
                    child: Text(
                      data.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.manrope(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: tBlue2,
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

  // ========================================================================
  // HEADING
  // ========================================================================

  Widget _buildHeading(BuildContext context) {
    final bool phone = _isPhone(context);
    final bool small = _isSmallPhone(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: phone ? 0 : 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: phone ? 24 : 30,
                height: 3,
                decoration: BoxDecoration(
                  color: tOrange1,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              SizedBox(width: phone ? 8 : 10),

              Flexible(
                child: Text(
                  data.eyebrow,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(
                    fontSize: phone ? 10.5 : 11.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: phone ? 0.9 : 1.15,
                    color: tOrange1,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: phone ? 8 : 9),

          Text(
            data.title,
            style: GoogleFonts.manrope(
              fontSize: phone ? (small ? 23 : 26) : 31,
              fontWeight: FontWeight.w800,
              color: tBlue2,
              letterSpacing: phone ? -0.5 : -0.7,
            ),
          ),

          SizedBox(height: phone ? 8 : 9),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Text(
              data.description,
              style: GoogleFonts.manrope(
                fontSize: phone ? 12.5 : 13,
                fontWeight: FontWeight.w500,
                color: tBlack.withOpacity(0.53),
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ========================================================================
  // CARDS
  // ========================================================================

  Widget _buildCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool phone = _isPhone(context);

        final double spacing = phone ? 20 : 26;

        // Phones: one card per row (full width).
        // Tablet / desktop: two cards per row (unchanged).
        final double cardWidth =
            phone ? constraints.maxWidth : (constraints.maxWidth - spacing) / 2;

        return Wrap(
          spacing: spacing,
          runSpacing: phone ? 22 : 28,
          alignment: WrapAlignment.center,
          children:
              data.cards.asMap().entries.map((entry) {
                final int index = entry.key;

                final Color accentColor = index.isEven ? tBlue2 : tOrange1;

                return SizedBox(
                  width: cardWidth,
                  child: _DetailCard(
                    data: entry.value,
                    accentColor: accentColor,
                    cardNumber: index + 1,
                  ),
                );
              }).toList(),
        );
      },
    );
  }
}

// ============================================================================
// DETAIL CARD
// ============================================================================

class _DetailCard extends StatefulWidget {
  final SolutionCardData data;
  final Color accentColor;
  final int cardNumber;

  const _DetailCard({
    required this.data,
    required this.accentColor,
    required this.cardNumber,
  });

  @override
  State<_DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<_DetailCard> {
  bool _hover = false;

  // No hover effect on tablet / mobile layouts
  bool get _isTouch =>
      ResponsiveLayout.isMobile(context) || ResponsiveLayout.isTablet(context);

  bool get _hovering => _hover && !_isTouch;

  void _setHovering(bool value) {
    if (_isTouch || _hover == value) return;

    setState(() {
      _hover = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final SolutionCardData card = widget.data;
    final bool phone = _isPhone(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double cardWidth = constraints.maxWidth;

        // ================================================================
        // RESPONSIVE IMAGE HEIGHT
        // Phones: scales with card width. Tablet/desktop: fixed 350.
        // ================================================================

        final double imageHeight =
            phone ? (cardWidth / 1.5).clamp(170.0, 260.0) : 350.0;

        // How far the floating logo overlaps the image bottom.
        final double logoOverlap = phone ? 16 : 21;

        // ================================================================
        // RESPONSIVE LOGO
        // ================================================================

        final double logoWidth =
            phone
                ? (cardWidth * 0.30).clamp(92.0, 120.0)
                : (cardWidth * 0.17).clamp(120.0, 150.0);

        final double logoHeight =
            phone
                ? (logoWidth * 0.34).clamp(32.0, 40.0)
                : (logoWidth * 0.34).clamp(40.0, 50.0);

        final double logoRight = phone ? 14 : cardWidth * 0.055;

        // Very narrow cards: stack the two buttons vertically.
        final bool stackButtons = phone && cardWidth < 280;

        final double buttonHeight = phone ? 44 : 48;

        final Widget demoButton = _HoverButton(
          title: 'View Demo',
          icon: Icons.arrow_forward_rounded,
          backgroundColor: widget.accentColor,
          foregroundColor: tWhite,
          height: buttonHeight,
        );

        final Widget websiteButton = _HoverButton(
          title: 'View website',
          icon: Icons.north_east_rounded,
          backgroundColor: tWhite,
          foregroundColor: widget.accentColor,
          borderColor: widget.accentColor.withOpacity(0.25),
          height: buttonHeight,
        );

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => _setHovering(true),
          onExit: (_) => _setHovering(false),

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,

            transform:
                Matrix4.identity()..translate(0.0, _hovering ? -7.0 : 0.0),

            decoration: BoxDecoration(
              color: tWhite,

              borderRadius: BorderRadius.circular(phone ? 16 : 19),

              border: Border.all(
                color:
                    _hovering
                        ? widget.accentColor.withOpacity(0.20)
                        : tBlue2.withOpacity(0.055),
              ),

              boxShadow: [
                BoxShadow(
                  color: widget.accentColor.withOpacity(
                    _hovering ? 0.115 : 0.045,
                  ),
                  blurRadius: _hovering ? 32 : 23,
                  spreadRadius: _hovering ? 1 : 0,
                  offset: Offset(0, _hovering ? 15 : 9),
                ),
              ],
            ),

            // IMPORTANT:
            // Do NOT clip the card here.
            // The logo needs to overlap the image/content boundary.
            clipBehavior: Clip.none,

            child: ClipRRect(
              borderRadius: BorderRadius.circular(phone ? 16 : 19),

              child: Stack(
                clipBehavior: Clip.none,

                children: [
                  // ========================================================
                  // MAIN CARD CONTENT
                  // ========================================================
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ====================================================
                      // IMAGE
                      // ====================================================
                      SizedBox(
                        width: double.infinity,
                        height: imageHeight,

                        child: ClipRect(
                          child: AnimatedScale(
                            scale: _hovering ? 1.025 : 1.0,

                            duration: const Duration(milliseconds: 400),

                            curve: Curves.easeOutCubic,

                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  card.image,
                                  fit: BoxFit.cover,

                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: tBlue2,

                                      child: Center(
                                        child: Icon(
                                          Icons.image_outlined,
                                          size: phone ? 38 : 46,
                                          color: tWhite.withOpacity(0.8),
                                        ),
                                      ),
                                    );
                                  },
                                ),

                                // SUBTLE BOTTOM FADE
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        tTransparent,
                                        tBlue2.withOpacity(
                                          _hovering ? 0.20 : 0.09,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // ====================================================
                      // CONTENT
                      // ====================================================
                      Padding(
                        padding:
                            phone
                                ? const EdgeInsets.fromLTRB(18, 24, 18, 20)
                                : const EdgeInsets.fromLTRB(27, 20, 27, 27),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 200),

                              style: GoogleFonts.manrope(
                                fontSize: phone ? 18 : 20,
                                fontWeight: FontWeight.w800,
                                color: _hovering ? widget.accentColor : tBlue2,
                                letterSpacing: -0.25,
                              ),

                              child: Text(card.title),
                            ),

                            SizedBox(height: phone ? 6 : 4),

                            // Phones: description grows with its text.
                            // Tablet/desktop: fixed 35px height (unchanged).
                            if (phone)
                              Text(
                                card.description,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,

                                style: GoogleFonts.manrope(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w500,
                                  color: tBlack.withOpacity(0.55),
                                  height: 1.55,
                                ),
                              )
                            else
                              SizedBox(
                                height: 35,

                                child: Text(
                                  card.description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,

                                  style: GoogleFonts.manrope(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w500,
                                    color: tBlack.withOpacity(0.55),
                                    height: 1.55,
                                  ),
                                ),
                              ),

                            SizedBox(height: phone ? 16 : 0),

                            // =================================================
                            // BUTTONS
                            // =================================================
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

                                  SizedBox(width: phone ? 10 : 12),

                                  Expanded(child: websiteButton),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // ========================================================
                  // TRAKFLEET FLOATING LOGO
                  //
                  // Positioned relative to the WHOLE CARD, overlapping the
                  // image/content boundary.
                  // ========================================================
                  Positioned(
                    right: logoRight,

                    top: imageHeight - logoOverlap,

                    child: AnimatedScale(
                      scale: _hovering ? 1.075 : 1.0,

                      duration: const Duration(milliseconds: 230),

                      curve: Curves.easeOutCubic,

                      child: Container(
                        width: logoWidth,
                        height: logoHeight,

                        decoration: BoxDecoration(
                          color: tWhite,

                          borderRadius: BorderRadius.circular(phone ? 11 : 14),

                          boxShadow: [
                            // Main shadow
                            BoxShadow(
                              color: tBlack.withOpacity(
                                _hovering ? 0.18 : 0.10,
                              ),
                              blurRadius: _hovering ? 20 : 14,
                              spreadRadius: _hovering ? 1 : 0,
                              offset: const Offset(0, 6),
                            ),

                            // Accent glow
                            BoxShadow(
                              color: widget.accentColor.withOpacity(
                                _hovering ? 0.30 : 0.16,
                              ),
                              blurRadius: _hovering ? 18 : 12,
                              spreadRadius: _hovering ? 1 : 0,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),

                        alignment: Alignment.center,

                        child: SvgPicture.asset(
                          'icons/trakfleet_logo.svg',

                          width: logoWidth * 0.80,

                          height: logoHeight * 0.80,

                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ============================================================================
// HOVER BUTTON
// ============================================================================

class _HoverButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final double height;

  const _HoverButton({
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
    this.height = 48,
  });

  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool _hovering = false;

  void _setHovering(bool value) {
    if (_hovering == value) return;

    setState(() {
      _hovering = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool filled = widget.backgroundColor != tWhite;

    return MouseRegion(
      cursor: SystemMouseCursors.click,

      onEnter: (_) => _setHovering(true),

      onExit: (_) => _setHovering(false),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 190),

        curve: Curves.easeOutCubic,

        height: widget.height,

        transform: Matrix4.identity()..translate(0.0, _hovering ? -2.0 : 0.0),

        decoration: BoxDecoration(
          color:
              _hovering && filled
                  ? widget.backgroundColor.withOpacity(0.91)
                  : widget.backgroundColor,

          borderRadius: BorderRadius.circular(10),

          border: Border.all(
            color:
                widget.borderColor ??
                (filled ? widget.backgroundColor : tTransparent),

            width: 1.2,
          ),

          boxShadow:
              _hovering
                  ? [
                    BoxShadow(
                      color: widget.foregroundColor.withOpacity(0.12),
                      blurRadius: 13,
                      offset: const Offset(0, 5),
                    ),
                  ]
                  : [],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Flexible(
              child: Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,

                style: GoogleFonts.manrope(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: widget.foregroundColor,
                ),
              ),
            ),

            const SizedBox(width: 9),

            AnimatedSlide(
              duration: const Duration(milliseconds: 180),

              curve: Curves.easeOut,

              offset: _hovering ? const Offset(0.15, 0) : Offset.zero,

              child: Icon(widget.icon, size: 17, color: widget.foregroundColor),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// BACK BUTTON
// ============================================================================

class _HoverBackButton extends StatefulWidget {
  final VoidCallback onTap;

  const _HoverBackButton({required this.onTap});

  @override
  State<_HoverBackButton> createState() => _HoverBackButtonState();
}

class _HoverBackButtonState extends State<_HoverBackButton> {
  bool _hover = false;

  bool get _isTouch =>
      ResponsiveLayout.isMobile(context) || ResponsiveLayout.isTablet(context);

  bool get _hovering => _hover && !_isTouch;

  @override
  Widget build(BuildContext context) {
    final bool small = _isSmallPhone(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,

      onEnter: (_) {
        if (!_isTouch) setState(() => _hover = true);
      },

      onExit: (_) {
        if (!_isTouch) setState(() => _hover = false);
      },

      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),

          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),

          decoration: BoxDecoration(
            color: _hovering ? tBlue2.withOpacity(0.05) : tTransparent,

            borderRadius: BorderRadius.circular(8),
          ),

          child: Row(
            mainAxisSize: MainAxisSize.min,

            children: [
              AnimatedSlide(
                duration: const Duration(milliseconds: 180),

                offset: _hovering ? const Offset(-0.08, 0) : Offset.zero,

                child: const Icon(
                  Icons.arrow_back_rounded,
                  size: 18,
                  color: tBlue2,
                ),
              ),

              const SizedBox(width: 7),

              Text(
                'Back to Solutions',

                style: GoogleFonts.manrope(
                  fontSize: small ? 12 : 13,
                  fontWeight: FontWeight.w700,
                  color: tBlue2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
