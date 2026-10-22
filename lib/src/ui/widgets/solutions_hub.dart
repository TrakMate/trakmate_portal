import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/widgets/mobile_app.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmer_effect.dart'; // NEW: for SolutionCardShimmer
import 'package:trakmate_portal/src/ui/widgets/web_app.dart';
import 'package:trakmate_portal/src/utils/responsive.dart';

import '../../utils/colors.dart';
import 'solutions_detail.dart';
// import 'mobile_app.dart';
// import 'web_app.dart';

// =========================================================
// RESPONSIVE HELPERS (mobile only, tablet/desktop untouched)
// =========================================================

/// Large + small phones.
bool _isPhone(BuildContext context) => MediaQuery.of(context).size.width < 600;

/// Small phones (e.g. iPhone SE, 320-359 wide).
bool _isSmallPhone(BuildContext context) =>
    MediaQuery.of(context).size.width < 360;

// =========================================================
// SOLUTIONS HUB PAGE
// =========================================================

class SolutionsHubPage extends StatefulWidget {
  const SolutionsHubPage({super.key});

  @override
  State<SolutionsHubPage> createState() => _SolutionsHubPageState();
}

class _SolutionsHubPageState extends State<SolutionsHubPage> {
  // NEW: mirrors _imagesLoading in BuildProductSection.
  bool _imagesLoading = true;

  final List<SolutionDetailsData> _solutions = <SolutionDetailsData>[
    // MOBILE APPS
    SolutionDetailsData(
      backgroundImage: 'images/mobileapps1.png',
      icon: 'icons/mobile.svg',
      iconBackgroundColor: tOrange1,
      eyebrow: 'MOBILE APPLICATIONS',
      title: 'Mobile Apps',
      description:
          'Powerful and intuitive mobile applications designed to connect users, devices and businesses on the go.',
      cards: const [
        SolutionCardData(
          'images/mobileapps.jpg',
          'icons/phone.svg',
          'Mobile App Development',
          'Custom mobile applications designed for smooth, intuitive and reliable user experiences.',
        ),
        SolutionCardData(
          'images/mobileapps.jpg',
          'icons/globe.svg',
          'Cloud Integration',
          'Connect mobile applications with cloud platforms, APIs and real-time business data.',
        ),
        SolutionCardData(
          'images/mobileapps.jpg',
          'icons/iot.svg',
          'Device Connectivity',
          'Connect mobile applications with connected devices, vehicles and IoT ecosystems.',
        ),
        SolutionCardData(
          'images/mobileapps.jpg',
          'icons/globe.svg',
          'Data & Analytics',
          'Present meaningful business information through dashboards, reports and analytics.',
        ),
      ],
    ),

    // WEB APPS
    SolutionDetailsData(
      backgroundImage: 'images/webapps1.png',
      icon: 'icons/laptop.svg',
      iconBackgroundColor: tBlue3,
      eyebrow: 'WEB APPLICATIONS',
      title: 'Web Apps',
      description:
          'Scalable and secure web applications that transform complex business processes into simple digital experiences.',
      cards: const [
        SolutionCardData(
          'images/trakfleet.png',
          'icons/laptop.svg',
          'TrakFleet',
          'Scalable web platforms built around your business workflows, users and operational requirements.',
        ),
        SolutionCardData(
          'images/trakfleet.png',
          'icons/globe.svg',
          'Trakblue',
          'Secure cloud-connected applications with centralized data and easy access from anywhere.',
        ),
        SolutionCardData(
          'images/trakfleet.png',
          'icons/iot.svg',
          'IoT Integration',
          'Connect web applications with devices, vehicles and real-time IoT data.',
        ),
        SolutionCardData(
          'images/trakfleet.png',
          'icons/globe.svg',
          'Dashboards & Analytics',
          'Transform business and device data into clear dashboards, reports and actionable insights.',
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadSolutionImages();
    });
  }

  // NEW
  Future<void> _preloadSolutionImages() async {
    try {
      final imagePaths = _solutions.map((s) => s.backgroundImage).toSet();

      await Future.wait([
        Future.wait(
          imagePaths.map((path) => precacheImage(AssetImage(path), context)),
        ),

        Future.delayed(const Duration(seconds: 2)),
      ]);
    } catch (e) {
      // debugPrint('Error preloading solution images: $e');
    }

    if (!mounted) return;

    setState(() {
      _imagesLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool phone = _isPhone(context);
    final bool small = _isSmallPhone(context);

    return Container(
      width: double.infinity,
      color: tWhite,
      padding:
          phone
              ? EdgeInsets.fromLTRB(small ? 14 : 18, 10, small ? 14 : 18, 40)
              : const EdgeInsets.fromLTRB(40, 10, 40, 55),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Phones: card fills the available width (never overflows).
          // Tablet / desktop: fixed 420 (unchanged).
          final double cardWidth = phone ? constraints.maxWidth : 420;

          return Column(
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                spacing: phone ? 0 : 25,
                runSpacing: phone ? 22 : 25,

                children:
                    _imagesLoading
                        ? List.generate(
                          _solutions.length,
                          (_) => SizedBox(
                            width: cardWidth, // same card width as real cards
                            child: const SolutionCardShimmer(),
                          ),
                        )
                        : _solutions.asMap().entries.map((entry) {
                          final index = entry.key;
                          final solution = entry.value;

                          return SizedBox(
                            width: cardWidth, // card width
                            child: _SolutionCard(
                              backgroundImage: solution.backgroundImage,
                              icon: solution.icon,
                              iconBackgroundColor: solution.iconBackgroundColor,
                              eyebrow: solution.eyebrow,
                              title: solution.title,
                              description: solution.description,

                              // NAVIGATION
                              onTap: () {
                                if (index == 0) {
                                  // MOBILE APPS
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const MobileApp(),
                                    ),
                                  );
                                } else if (index == 1) {
                                  // WEB APPS
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const WebApp(),
                                    ),
                                  );
                                }
                              },
                            ),
                          );
                        }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}

// =========================================================
// SOLUTION CARD
// =========================================================

class _SolutionCard extends StatefulWidget {
  final String backgroundImage, icon, eyebrow, title, description;
  final Color iconBackgroundColor;
  final VoidCallback onTap;

  const _SolutionCard({
    required this.backgroundImage,
    required this.icon,
    required this.iconBackgroundColor,
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  State<_SolutionCard> createState() => _SolutionCardState();
}

class _SolutionCardState extends State<_SolutionCard> {
  bool _hover = false;

  // No hover effect on tablet / mobile layouts
  bool get _isTouch =>
      ResponsiveLayout.isMobile(context) || ResponsiveLayout.isTablet(context);

  // Every existing `hovering` reference below now reads this getter.
  bool get hovering => _hover && !_isTouch;

  @override
  Widget build(BuildContext context) {
    final bool phone = _isPhone(context);
    final bool small = _isSmallPhone(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double cardWidth = constraints.maxWidth;

        // ================================================================
        // RESPONSIVE SIZES
        // Phones: image scales with card width (same 420:250 ratio),
        // card height wraps its content.
        // Tablet / desktop: image 250, card 390 (unchanged).
        // ================================================================

        final double imageHeight =
            phone ? (cardWidth * 250 / 420).clamp(150.0, 250.0) : 250.0;

        final double iconSize = phone ? 44 : 50;
        final double iconGlyph = phone ? 22 : 26;

        // Icon overlaps the image bottom by 25 (same as 225 vs 250).
        final double iconTop = imageHeight - 25;

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) {
            if (!_isTouch) setState(() => _hover = true);
          },
          onExit: (_) {
            if (!_isTouch) setState(() => _hover = false);
          },
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              transform:
                  Matrix4.identity()..translate(0.0, hovering ? -7.0 : 0.0),
              height: phone ? null : 390, // card height
              decoration: BoxDecoration(
                color: tWhite,
                borderRadius: BorderRadius.circular(phone ? 16 : 18),
                boxShadow: [
                  BoxShadow(
                    color: tBlack.withOpacity(hovering ? .14 : .10),
                    blurRadius: hovering ? 24 : (phone ? 16 : 20),
                    offset: Offset(0, hovering ? 10 : (phone ? 6 : 8)),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: imageHeight,
                        child: Image.asset(
                          widget.backgroundImage,
                          fit: BoxFit.cover,
                          frameBuilder: (
                            context,
                            child,
                            frame,
                            wasSynchronouslyLoaded,
                          ) {
                            // Already decoded/cached -> show immediately, no shimmer flash.
                            if (wasSynchronouslyLoaded) return child;

                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              // Force non-positioned children to fill the Stack with TIGHT
                              // constraints (StackFit.expand), matching what the parent SizedBox
                              // gives us. Without this, Stack hands the child LOOSE constraints
                              // and Image sizes itself to the asset's own aspect ratio instead
                              // of filling the card width x image height.
                              layoutBuilder: (currentChild, previousChildren) {
                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    ...previousChildren,
                                    if (currentChild != null) currentChild,
                                  ],
                                );
                              },
                              child:
                                  frame != null
                                      ? SizedBox.expand(
                                        key: const ValueKey('image'),
                                        child: child,
                                      )
                                      : SizedBox.expand(
                                        key: const ValueKey('shimmer'),
                                        child: ShimmerBox(height: imageHeight),
                                      ),
                            );
                          },
                          errorBuilder:
                              (_, __, ___) => Container(color: tBlue3),
                        ),
                      ),

                      Padding(
                        // On phones the top padding clears the floating icon.
                        padding:
                            phone
                                ? EdgeInsets.fromLTRB(
                                  small ? 16 : 18,
                                  32,
                                  small ? 16 : 18,
                                  20,
                                )
                                : const EdgeInsets.fromLTRB(22, 35, 22, 22),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 1),

                            Text(
                              widget.title,
                              style: GoogleFonts.manrope(
                                fontSize: phone ? 18 : 20,
                                fontWeight: FontWeight.w700,
                                color: tBlue2,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              widget.description,
                              // Phones get an extra line so text isn't clipped.
                              maxLines: phone ? 4 : 3,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.manrope(
                                fontSize: 12.5,
                                color: tBlack.withOpacity(.6),
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // ICON
                  Positioned(
                    top: iconTop,
                    left: phone ? 16 : 20,
                    child: Container(
                      width: iconSize,
                      height: iconSize,
                      decoration: BoxDecoration(
                        color: widget.iconBackgroundColor,
                        borderRadius: BorderRadius.circular(phone ? 11 : 12),
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        widget.icon,
                        width: iconGlyph,
                        height: iconGlyph,
                        color: tWhite,
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
