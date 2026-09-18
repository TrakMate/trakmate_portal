import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/widgets/footer_section.dart';

import '../../utils/colors.dart';

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

                      //         // =================================================
                      //         // CARD 3
                      //         // =================================================
                      //         _WebServiceCardData(
                      //           image: 'images/trakfleet.png',
                      //           logo: 'icons/trakfleet_logo.svg',
                      //           title: 'IoT Integration',
                      //           description:
                      //               'Connect web applications with devices, vehicles and real-time IoT data.',
                      //         ),

                      //         // =================================================
                      //         // CARD 4
                      //         // =================================================
                      //         _WebServiceCardData(
                      //           image: 'images/trakfleet.png',
                      //           logo: 'icons/trakfleet_logo.svg',
                      //           title: 'Dashboards & Analytics',
                      //           description:
                      //               'Transform business and device data into clear dashboards, reports and actionable insights.',
                      //         ),

                      //         // =================================================
                      //         // CARD 5
                      //         // =================================================
                      //         _WebServiceCardData(
                      //           image: 'images/trakfleet.png',
                      //           logo: 'icons/trakfleet_logo.svg',
                      //           title: 'Custom Portals',
                      //           description:
                      //               'Tailored client and admin portals with role-based access and streamlined workflows.',
                      //         ),

                      //         // =================================================
                      //         // CARD 6
                      //         // =================================================
                      //         _WebServiceCardData(
                      //           image: 'images/trakfleet.png',
                      //           logo: 'icons/trakfleet_logo.svg',
                      //           title: 'API & Integrations',
                      //           description:
                      //               'Connect your web app to third-party services and internal systems through robust APIs.',
                      //         ),
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
      color: Colors.transparent,
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
                              // TODO:
                              // Launch website URL
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
