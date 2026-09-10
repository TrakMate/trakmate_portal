import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';

import '../../utils/colors.dart';

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

class SolutionsDetailsPage extends StatelessWidget {
  final SolutionDetailsData data;

  const SolutionsDetailsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.fromLTRB(34, 34, 34, 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeading(),
                      const SizedBox(height: 34),
                      _buildCards(),
                      const SizedBox(height: 48),
                      // _buildBottomStrip(),
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
    return Container(
      width: double.infinity,
      height: 64,
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
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: Row(
        children: [
          _HoverBackButton(onTap: () => Navigator.pop(context)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
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
                Text(
                  data.title,
                  style: GoogleFonts.manrope(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: tBlue2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ========================================================================
  // HEADING
  // ========================================================================

  Widget _buildHeading() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 3,
                decoration: BoxDecoration(
                  color: tOrange1,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                data.eyebrow,
                style: GoogleFonts.manrope(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.15,
                  color: tOrange1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          Text(
            data.title,
            style: GoogleFonts.manrope(
              fontSize: 31,
              fontWeight: FontWeight.w800,
              color: tBlue2,
              letterSpacing: -0.7,
            ),
          ),
          const SizedBox(height: 9),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Text(
              data.description,
              style: GoogleFonts.manrope(
                fontSize: 13,
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
        const double spacing = 26;

        final double cardWidth = (constraints.maxWidth - spacing) / 2;

        return Wrap(
          spacing: spacing,
          runSpacing: 28,
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

  // ========================================================================
  // BOTTOM STRIP
  // =========================a===============================================

  // Widget _buildBottomStrip() {
  // return Container(
  //   width: double.infinity,
  //   padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 21),
  //   decoration: BoxDecoration(
  //     color: tWhite,
  //     borderRadius: BorderRadius.circular(15),
  //     border: Border.all(color: tBlue2.withOpacity(0.07)),
  //     boxShadow: [
  //       BoxShadow(
  //         color: tBlue2.withOpacity(0.045),
  //         blurRadius: 20,
  //         offset: const Offset(0, 8),
  //       ),
  //     ],
  //   ),
  //   child: Row(
  //     children: [
  //       Container(
  //         width: 34,
  //         height: 34,
  //         decoration: BoxDecoration(
  //           color: tOrange1.withOpacity(0.09),
  //           borderRadius: BorderRadius.circular(9),
  //         ),
  //         child: const Icon(
  //           Icons.auto_awesome_rounded,
  //           size: 17,
  //           color: tOrange1,
  //         ),
  //       ),
  //       const SizedBox(width: 13),
  //       Expanded(
  //         child: Text(
  //           'Built around your business requirements.',
  //           style: GoogleFonts.manrope(
  //             fontSize: 12,
  //             fontWeight: FontWeight.w700,
  //             color: tBlue2,
  //           ),
  //         ),
  //       ),
  //       Text(
  //         'Trakmate Design Solutions',
  //         style: GoogleFonts.manrope(
  //           fontSize: 11,
  //           fontWeight: FontWeight.w600,
  //           color: tBlack.withOpacity(0.42),
  //         ),
  //       ),
  //     ],
  //   ),
  // );
}
// }

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
  bool _hovering = false;

  void _setHovering(bool value) {
    if (_hovering == value) return;

    setState(() {
      _hovering = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final SolutionCardData card = widget.data;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _setHovering(true),
      onExit: (_) => _setHovering(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..translate(0.0, _hovering ? -7.0 : 0.0),
        decoration: BoxDecoration(
          color: tWhite,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(
            color:
                _hovering
                    ? widget.accentColor.withOpacity(0.20)
                    : tBlue2.withOpacity(0.055),
          ),
          boxShadow: [
            BoxShadow(
              color: widget.accentColor.withOpacity(_hovering ? 0.115 : 0.045),
              blurRadius: _hovering ? 32 : 23,
              spreadRadius: _hovering ? 1 : 0,
              offset: Offset(0, _hovering ? 15 : 9),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==============================================================
            // IMAGE
            // ==============================================================
            Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 350,
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
                                    size: 46,
                                    color: tWhite.withOpacity(0.8),
                                  ),
                                ),
                              );
                            },
                          ),

                          // Subtle bottom fade.
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  tBlue2.withOpacity(_hovering ? 0.20 : 0.09),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // // ==========================================================
                // // TOP-RIGHT NUMBER
                // // ==========================================================
                // Positioned(
                //   top: 15,
                //   right: 15,
                //   child: AnimatedContainer(
                //     duration: const Duration(milliseconds: 220),
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: 9,
                //       vertical: 6,
                //     ),
                //     decoration: BoxDecoration(
                //       color: tWhite.withOpacity(_hovering ? 0.97 : 0.90),
                //       borderRadius: BorderRadius.circular(8),
                //       border: Border.all(
                //         color: widget.accentColor.withOpacity(0.10),
                //       ),
                //     ),
                //     child: Text(
                //       '0${widget.cardNumber}',
                //       style: GoogleFonts.manrope(
                //         fontSize: 10,
                //         fontWeight: FontWeight.w800,
                //         color: widget.accentColor,
                //       ),
                //     ),
                //   ),
                // ),

                // ==========================================================
                // FLOATING ICON
                // ==============================================================
                Positioned(
                  left: 700,
                  bottom: -29,
                  child: AnimatedScale(
                    scale: _hovering ? 1.075 : 1.0,
                    duration: const Duration(milliseconds: 230),
                    curve: Curves.easeOutCubic,
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        // Always white — never the alternating accent color,
                        // in hover or non-hover states.
                        color: tWhite,
                        borderRadius: BorderRadius.circular(14),

                        boxShadow: [
                          // Main shadow around the container
                          BoxShadow(
                            color: tBlack.withOpacity(_hovering ? 0.18 : 0.10),
                            blurRadius: _hovering ? 20 : 14,
                            spreadRadius: _hovering ? 1 : 0,
                            offset: const Offset(0, 6),
                          ),

                          // Soft accent glow around the border — this can
                          // stay tied to accentColor since it's a shadow,
                          // not the container's own background fill.
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
                        'icons/trakfleet_logo.svg', // <-- your SVG icon
                        width: 200,
                        height: 50,
                        // color: tWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ==============================================================
            // CONTENT
            // ==============================================================
            Padding(
              padding: const EdgeInsets.fromLTRB(27, 20, 27, 27),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: GoogleFonts.manrope(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: _hovering ? widget.accentColor : tBlue2,
                      letterSpacing: -0.25,
                    ),
                    child: Text(card.title),
                  ),

                  const SizedBox(height: 4),

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

                  // const SizedBox(height: ),
                  Row(
                    children: [
                      Expanded(
                        child: _HoverButton(
                          title: 'View Demo',
                          icon: Icons.arrow_forward_rounded,
                          backgroundColor: widget.accentColor,
                          foregroundColor: tWhite,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _HoverButton(
                          title: 'View website',
                          icon: Icons.north_east_rounded,
                          backgroundColor: tWhite,
                          foregroundColor: widget.accentColor,
                          borderColor: widget.accentColor.withOpacity(0.25),
                        ),
                      ),
                    ],
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
// HOVER BUTTON
// ============================================================================

class _HoverButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;

  const _HoverButton({
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
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
        height: 48,
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
                (filled ? widget.backgroundColor : Colors.transparent),
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
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _hovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          _hovering = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          decoration: BoxDecoration(
            color: _hovering ? tBlue2.withOpacity(0.05) : Colors.transparent,
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
                  fontSize: 13,
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
