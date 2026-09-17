import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/widgets/footer_section.dart';

import '../../utils/colors.dart';

// If colors.dart already defines a brand orange (tOrange, tAccent, etc.)
// delete this line and use that instead — this is just a stand-in so the
// file compiles on its own.
const Color tOrange = Color(0xFFF7931E);

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
            // White background, left-aligned eyebrow + heading,
            // 2-column grid of straight (non-tilted) image-forward cards.
            // =====================================================
            Container(
              width: double.infinity,
              color: tWhite,
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBackButton(context),
                  // const SizedBox(height: 25),
                  // const _SectionEyebrow(label: 'WEB APPLICATIONS'),
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
                      _WebServiceCardData(
                        image: 'images/trakfleet.png',
                        title: 'TrakFleet',
                        description:
                            'Scalable web platforms built around your business workflows, users and operational requirements.',
                      ),
                      _WebServiceCardData(
                        image: 'images/trakfleet.png',
                        title: 'Trakblue',
                        description:
                            'Secure cloud-connected applications with centralized data and easy access from anywhere.',
                      ),
                      _WebServiceCardData(
                        image: 'images/trakfleet.png',
                        title: 'IoT Integration',
                        description:
                            'Connect web applications with devices, vehicles and real-time IoT data.',
                      ),
                      _WebServiceCardData(
                        image: 'images/trakfleet.png',
                        title: 'Dashboards & Analytics',
                        description:
                            'Transform business and device data into clear dashboards, reports and actionable insights.',
                      ),
                      _WebServiceCardData(
                        image: 'images/trakfleet.png',
                        title: 'Custom Portals',
                        description:
                            'Tailored client and admin portals with role-based access and streamlined workflows.',
                      ),
                      _WebServiceCardData(
                        image: 'images/trakfleet.png',
                        title: 'API & Integrations',
                        description:
                            'Connect your web app to third-party services and internal systems through robust APIs.',
                      ),
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
// SECTION EYEBROW  ("— WEB APPLICATIONS")
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
// (icon field removed — the target design has no separate icon
// chip, just the big screenshot image)
// =========================================================

class _WebServiceCardData {
  final String image;
  final String title;
  final String description;

  const _WebServiceCardData({
    required this.image,
    required this.title,
    required this.description,
  });
}

// =========================================================
// CARD GRID
// Straight cards (no rotation/tilt). 2 columns on wide screens,
// 1 column on narrow screens.
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
            // Alternates blue / orange CTA, matching the reference.
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
// Big image on top (most of the card), small footer below with
// title + description + two CTA buttons.
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
    // The image sits inside a 12px inset with a 2.5 aspect ratio — used
    // here to work out where its bottom edge lands, so the floating logo
    // badge can straddle that edge exactly like in the reference shot.
    const imageInset = 12.0;
    const imageAspectRatio = 2.5;
    final imageInnerWidth = width - imageInset * 2;
    final imageBottom = imageInset + imageInnerWidth / imageAspectRatio;

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Big image — dominant part of the card now.
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

              // Small footer.
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      data.title,
                      style: GoogleFonts.manrope(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: tBlue3,
                      ),
                    ),
                    const SizedBox(height: 6),
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
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // TODO: launch demo URL (e.g. via url_launcher)
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentColor,
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
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // TODO: launch website URL (e.g. via url_launcher)
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

          // Floating Trakmate logo badge, straddling the image's bottom
          // edge — matches the reference screenshot.
          Positioned(
            right: 28,
            top: imageBottom - 22,
            child: const _TrakmateBadge(),
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
  const _TrakmateBadge();

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
      child: SvgPicture.asset(
        'icons/trakmate_logo.svg', // update the path if yours lives elsewhere
        height: 40,
        width: 60,
      ),
    );
  }
}
