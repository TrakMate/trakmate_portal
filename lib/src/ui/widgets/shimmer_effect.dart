import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trakmate_portal/src/utils/colors.dart';
import 'package:trakmate_portal/src/utils/responsive.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isTablet = ResponsiveLayout.isTablet(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double w = constraints.maxWidth;

        // MOBILE / TABLET: wrap cards, same as the real grid
        if (isMobile || isTablet) {
          const double gap = 16;
          final int columns = isMobile ? (w >= 560 ? 2 : 1) : 2;
          final double cardW =
              ((w - gap * (columns - 1)) / columns).floorToDouble();

          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: [
              for (int i = 0; i < (isMobile ? 3 : 4); i++)
                SizedBox(width: cardW, height: 390, child: _buildShimmerCard()),
            ],
          );
        }

        // DESKTOP
        final double cardWidth = w >= 1800 ? 410 : 330;

        return Column(
          children: [
            for (int i = 0; i < 3; i++) ...[
              Padding(
                padding: const EdgeInsets.only(left: 75, bottom: 28),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: _buildShimmerHeading(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 75),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  child: Row(
                    children: [
                      for (int j = 0; j < 4; j++)
                        Padding(
                          padding: EdgeInsets.only(right: j == 3 ? 0 : 16),
                          child: SizedBox(
                            width: cardWidth,
                            height: 390,
                            child: _buildShimmerCard(),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 52),
            ],
          ],
        );
      },
    );
  }

  Widget _buildShimmerHeading() {
    return Shimmer.fromColors(
      baseColor: tGrey1.shade300,
      highlightColor: tGrey1.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 170,
            height: 22,
            decoration: BoxDecoration(
              color: tWhite,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(height: 8),
          Container(width: 30, height: 2, color: tWhite),
        ],
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: tGrey1.shade300,
      highlightColor: tGrey1.shade100,
      child: Container(
        decoration: BoxDecoration(
          color: tWhite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: tGrey1.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE PLACEHOLDER
            Container(width: double.infinity, height: 210, color: tWhite),

            // CONTENT
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Container(
                    width: 90,
                    height: 15,
                    decoration: BoxDecoration(
                      color: tWhite,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // subtitle
                  Container(
                    width: 140,
                    height: 11,
                    decoration: BoxDecoration(
                      color: tWhite,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // description line 1
                  Container(
                    width: double.infinity,
                    height: 10,
                    decoration: BoxDecoration(
                      color: tWhite,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  const SizedBox(height: 7),

                  // description line 2
                  Container(
                    width: double.infinity,
                    height: 10,
                    decoration: BoxDecoration(
                      color: tWhite,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  const SizedBox(height: 7),

                  // description line 3
                  Container(
                    width: 180,
                    height: 10,
                    decoration: BoxDecoration(
                      color: tWhite,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // More info
                  Container(
                    width: 75,
                    height: 12,
                    decoration: BoxDecoration(
                      color: tWhite,
                      borderRadius: BorderRadius.circular(4),
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

//on just image frame
class ShimmerBox extends StatelessWidget {
  final double? width;
  final double height;
  final BorderRadius? borderRadius;

  const ShimmerBox({
    super.key,
    this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: tGrey1.shade300,
      highlightColor: tGrey1.shade100,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(color: tWhite, borderRadius: borderRadius),
      ),
    );
  }
}

//heroheader
class HeroHeaderShimmer extends StatelessWidget {
  const HeroHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // Mobile has its own stacked layout (same as the real header).
    if (ResponsiveLayout.isMobile(context)) {
      return _buildMobile(context);
    }

    // ───────── TABLET / DESKTOP (unchanged) ─────────
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // LEFT: text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerBox(
                  width: 140,
                  height: 14,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                const SizedBox(height: 20),
                const ShimmerBox(
                  width: 480,
                  height: 40,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                const SizedBox(height: 10),
                const ShimmerBox(
                  width: 360,
                  height: 40,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                const SizedBox(height: 20),
                const ShimmerBox(
                  height: 16,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                const SizedBox(height: 8),
                const ShimmerBox(
                  width: 420,
                  height: 16,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                const SizedBox(height: 35),

                // 4 intro-cards row
                Row(
                  children: List.generate(4, (index) {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: index == 3 ? 0 : 12),
                        child: _buildIntroCardShimmer(),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),

          const SizedBox(width: 40),

          // RIGHT: hero image
          Expanded(
            child: ShimmerBox(
              height: 350,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────────────────
  // MOBILE: image banner on top, text below, 2 x 2 intro cards
  // ───────────────────────────────────────────────────────────
  Widget _buildMobile(BuildContext context) {
    final double screenW = MediaQuery.of(context).size.width;
    final bool compact = screenW < 380; // same rule as the real header

    const double hPad = 20;
    const double gap = 16;
    final double contentW = screenW - (hPad * 2);
    final double cardW = ((screenW - (hPad * 2) - gap) / 2).floorToDouble();

    // real heading: font 25/30 x height 1.2 -> 30/36 px per line
    final double headingH = compact ? 30 : 36;

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image banner (same height as the real one)
          ShimmerBox(height: screenW * 0.62),

          Padding(
            padding: const EdgeInsets.fromLTRB(hPad, 16, hPad, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // label
                const ShimmerBox(
                  width: 110,
                  height: 12,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                const SizedBox(height: 14),

                // heading (2 lines)
                ShimmerBox(
                  width: contentW * 0.85,
                  height: headingH - 4,
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                const SizedBox(height: 8),
                ShimmerBox(
                  width: contentW * 0.6,
                  height: headingH - 4,
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                const SizedBox(height: 14),

                // description (4 lines)
                const ShimmerBox(
                  height: 12,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                const SizedBox(height: 8),
                const ShimmerBox(
                  height: 12,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                const SizedBox(height: 8),
                const ShimmerBox(
                  height: 12,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                const SizedBox(height: 8),
                ShimmerBox(
                  width: contentW * 0.55,
                  height: 12,
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                const SizedBox(height: 28),

                // 2 x 2 intro cards
                Wrap(
                  spacing: gap,
                  runSpacing: 22,
                  children: [
                    for (int i = 0; i < 4; i++)
                      SizedBox(width: cardW, child: _buildMobileIntroCard()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileIntroCard() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerBox(
          width: 30,
          height: 30,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        SizedBox(height: 10),
        ShimmerBox(
          width: 100,
          height: 13,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        SizedBox(height: 6),
        ShimmerBox(
          height: 11,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        SizedBox(height: 5),
        ShimmerBox(
          width: 70,
          height: 11,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ],
    );
  }

  // desktop / tablet intro card (unchanged)
  Widget _buildIntroCardShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerBox(
            width: 30,
            height: 30,
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          const SizedBox(height: 10),
          const ShimmerBox(
            width: 90,
            height: 12,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          const SizedBox(height: 6),
          const ShimmerBox(
            height: 11,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ],
      ),
    );
  }
}

//video shimmer
class HeroVideoShimmer extends StatelessWidget {
  const HeroVideoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            RepaintBoundary(
              // sweeper
              child: Shimmer.fromColors(
                baseColor: tGrey1.shade300,
                highlightColor: tGrey1.shade100,
                direction: ShimmerDirection.ltr,
                period: const Duration(milliseconds: 1600),
                child: Container(
                  //container bg
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  color: tGrey1.shade300,
                ),
              ),
            ),

            RepaintBoundary(
              // ADD
              child: SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: const Center(
                  child: SizedBox(
                    width: 44,
                    height: 44,
                    child: CircularProgressIndicator(
                      strokeWidth: 3.5,
                      valueColor: AlwaysStoppedAnimation<Color>(tOrange1),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

//manufacturing service card shimmer
class ServiceCardShimmer extends StatelessWidget {
  const ServiceCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tGrey1.shade200),
      ),
      clipBehavior: Clip.antiAlias,
      child: Shimmer.fromColors(
        baseColor: tGrey1.shade300,
        highlightColor: tGrey1.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image placeholder
            Container(height: 200, width: double.infinity, color: tWhite),

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Container(
                    width: 120,
                    height: 14,
                    decoration: BoxDecoration(
                      color: tWhite,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // description line 1
                  Container(
                    width: double.infinity,
                    height: 10,
                    decoration: BoxDecoration(
                      color: tWhite,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // description line 2
                  Container(
                    width: double.infinity,
                    height: 10,
                    decoration: BoxDecoration(
                      color: tWhite,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // description line 3
                  Container(
                    width: 140,
                    height: 10,
                    decoration: BoxDecoration(
                      color: tWhite,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // "Learn More"
                  Container(
                    width: 75,
                    height: 12,
                    decoration: BoxDecoration(
                      color: tWhite,
                      borderRadius: BorderRadius.circular(4),
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

//engineering service card shimmer
class EngineeringCardShimmer extends StatelessWidget {
  const EngineeringCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: tBlack.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Shimmer.fromColors(
        baseColor: tGrey1.shade300,
        highlightColor: tGrey1.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image + icon-badge placeholder
            Stack(
              children: [
                AspectRatio(aspectRatio: 1.5, child: Container(color: tWhite)),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: tWhite,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Container(
                      width: 110,
                      height: 15,
                      decoration: BoxDecoration(
                        color: tWhite,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // description (3 lines, matches the 57px block)
                    SizedBox(
                      height: 57,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 10,
                            decoration: BoxDecoration(
                              color: tWhite,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 7),
                          Container(
                            width: double.infinity,
                            height: 10,
                            decoration: BoxDecoration(
                              color: tWhite,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 7),
                          Container(
                            width: 150,
                            height: 10,
                            decoration: BoxDecoration(
                              color: tWhite,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // "Learn More"
                    Container(
                      width: 90,
                      height: 13,
                      decoration: BoxDecoration(
                        color: tWhite,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//engineering service card shimmer
class EngineeringServiceCardShimmer extends StatelessWidget {
  const EngineeringServiceCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: tBlack.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Shimmer.fromColors(
        baseColor: tGrey1.shade300,
        highlightColor: tGrey1.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image placeholder
            AspectRatio(aspectRatio: 1.5, child: Container(color: tWhite)),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Container(
                    width: 110,
                    height: 16,
                    decoration: BoxDecoration(
                      color: tWhite,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // description (matches the 57px, 3-line box)
                  SizedBox(
                    height: 57,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 10,
                          decoration: BoxDecoration(
                            color: tWhite,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 7),
                        Container(
                          width: double.infinity,
                          height: 10,
                          decoration: BoxDecoration(
                            color: tWhite,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 7),
                        Container(
                          width: 150,
                          height: 10,
                          decoration: BoxDecoration(
                            color: tWhite,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // "Learn More"
                  Container(
                    width: 80,
                    height: 13,
                    decoration: BoxDecoration(
                      color: tWhite,
                      borderRadius: BorderRadius.circular(4),
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

//solution hub card shimmer
class SolutionCardShimmer extends StatelessWidget {
  const SolutionCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390, // matches _SolutionCard's fixed height
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: tBlack.withOpacity(0.10),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Shimmer.fromColors(
        baseColor: tGrey1.shade300,
        highlightColor: tGrey1.shade100,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // background image placeholder
                Container(width: double.infinity, height: 250, color: tWhite),

                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 35, 22, 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // title
                      Container(
                        width: 150,
                        height: 18,
                        decoration: BoxDecoration(
                          color: tWhite,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // description line 1
                      Container(
                        width: double.infinity,
                        height: 11,
                        decoration: BoxDecoration(
                          color: tWhite,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 7),

                      // description line 2
                      Container(
                        width: double.infinity,
                        height: 11,
                        decoration: BoxDecoration(
                          color: tWhite,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 7),

                      // description line 3
                      Container(
                        width: 160,
                        height: 11,
                        decoration: BoxDecoration(
                          color: tWhite,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // icon badge placeholder (matches Positioned(top:225,left:20,...) in _SolutionCard)
            Positioned(
              top: 225,
              left: 20,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: tWhite,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//webapp cards
class WebServiceCardShimmer extends StatelessWidget {
  final double width;
  const WebServiceCardShimmer({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
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
      clipBehavior: Clip.antiAlias,
      child: Shimmer.fromColors(
        baseColor: tGrey1.shade300,
        highlightColor: tGrey1.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: AspectRatio(
                  aspectRatio: 2.5,
                  child: Container(color: tWhite),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 110, height: 17, color: tWhite),
                  const SizedBox(height: 10),
                  Container(width: double.infinity, height: 10, color: tWhite),
                  const SizedBox(height: 7),
                  Container(width: 160, height: 10, color: tWhite),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 38,
                          decoration: BoxDecoration(
                            color: tWhite,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 38,
                          decoration: BoxDecoration(
                            color: tWhite,
                            borderRadius: BorderRadius.circular(8),
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
      ),
    );
  }
}

//product details specs slide shimmer
class SpecsSlideShimmer extends StatelessWidget {
  final int badgeCount;
  final int topRowCount;

  const SpecsSlideShimmer({
    super.key,
    required this.badgeCount,
    this.topRowCount = 0,
  });

  Widget _badgePlaceholder() {
    return SizedBox(
      width: 84,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              color: tWhite,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 64,
            height: 10,
            decoration: BoxDecoration(
              color: tWhite,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }

  // MOBILE: image on top, ALL badges wrapped below it
  // (mirrors _buildMobileSpecsSlide in the product details page)
  Widget _buildMobile(BuildContext context) {
    final double screenW = MediaQuery.of(context).size.width;
    final double kb = screenW < 380 ? 0.62 : 0.72; // same as the real slide

    return LayoutBuilder(
      builder: (context, c) {
        const double sidePad = 30;
        final double contentW = math.max(c.maxWidth - sidePad * 2, 0);

        return Padding(
          // same clearances as the real mobile slide
          padding: const EdgeInsets.fromLTRB(sidePad, 16, sidePad, 62),
          child: Shimmer.fromColors(
            baseColor: tGrey1.shade300,
            highlightColor: tGrey1.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // product image placeholder
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: tWhite,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // badges, wrapped + centered, scaled down if they don't fit
                Flexible(
                  flex: 2,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: contentW,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        spacing: 8,
                        runSpacing: 10,
                        children: [
                          for (int i = 0; i < badgeCount; i++)
                            _mobileBadgePlaceholder(kb),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _mobileBadgePlaceholder(double kb) {
    return SizedBox(
      width: 132 * kb,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 96 * kb,
            height: 96 * kb,
            decoration: const BoxDecoration(
              color: tWhite,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: 8 * kb),
          Container(
            width: 80 * kb,
            height: 11,
            decoration: BoxDecoration(
              color: tWhite,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mobile has its own layout (image on top, badges wrapped below).
    if (ResponsiveLayout.isMobile(context)) return _buildMobile(context);
    final int topCount = topRowCount.clamp(0, badgeCount);
    final int colCount = badgeCount - topCount;
    final bool both = topCount > 0 && colCount > 0;

    // Same split as the real slide: first `topCount` badges in a row,
    // the rest in a column under the row's LAST badge.
    final Widget badgeBlock = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (topCount > 0)
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < topCount; i++) ...[
                if (i > 0) const SizedBox(width: 12),
                _badgePlaceholder(),
              ],
            ],
          ),
        if (both) const SizedBox(height: 22),
        if (colCount > 0)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < colCount; i++) ...[
                if (i > 0) const SizedBox(height: 22),
                _badgePlaceholder(),
              ],
            ],
          ),
      ],
    );

    return Padding(
      // same clearances as the real slide (thumbnails at the bottom)
      padding: const EdgeInsets.fromLTRB(56, 24, 56, 80),
      child: Shimmer.fromColors(
        baseColor: tGrey1.shade300,
        highlightColor: tGrey1.shade100,
        child: Stack(
          children: [
            // product image placeholder (leaves room for the badge column)
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(
                  right: 84 + 28,
                  top: both ? 120 : 40,
                  bottom: 40,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: tWhite,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            // badges: top-right, scales down if it doesn't fit
            Positioned.fill(
              child: Align(
                alignment:
                    both || topCount > 0
                        ? Alignment.topRight
                        : Alignment.centerRight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment:
                      both || topCount > 0
                          ? Alignment.topRight
                          : Alignment.centerRight,
                  child: badgeBlock,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// //product details specs slide shimmer (fills the whole slide)
// class SpecsSlideShimmer extends StatelessWidget {
//   const SpecsSlideShimmer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: tGrey1.shade300,
//       highlightColor: tGrey1.shade100,
//       child: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           color: tWhite,
//           borderRadius: BorderRadius.circular(
//             2,
//           ), // matches the slide container's radius
//         ),
//       ),
//     );
//   }
// }

//hero slider shimmer (matches HeroSlider layout, no loader)
//hero slider shimmer (matches HeroSlider layout, no loader)
class HeroSliderShimmer extends StatelessWidget {
  const HeroSliderShimmer({super.key});

  Widget _bar(double width, double height, {double radius = 8}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (ResponsiveLayout.isMobile(context)) return _buildMobile(context);
    if (ResponsiveLayout.isTablet(context)) return _buildTablet(context);
    return _buildDesktop(context);
  }

  // ─────────────────────────────────────────────────────────
  // MOBILE: image banner on top, label + heading below
  // (mirrors HeroSlider._buildMobileSlide)
  // ─────────────────────────────────────────────────────────
  Widget _buildMobile(BuildContext context) {
    final double screenW = MediaQuery.of(context).size.width;
    final bool compact = screenW < 380;

    const double hPad = 20;
    final double contentW = screenW - (hPad * 2);
    final double lineH = compact ? 24 : 28; // heading line (font 25/30 x 1.2)

    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image banner (same height as the real one)
          Shimmer.fromColors(
            baseColor: tGrey1.shade300,
            highlightColor: tGrey1.shade100,
            direction: ShimmerDirection.ltr,
            period: const Duration(milliseconds: 1600),
            child: Container(
              width: double.infinity,
              height: screenW * 0.62,
              color: tWhite,
            ),
          ),

          // text placeholders
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(hPad, 14, hPad, 40),
              child: Align(
                alignment: Alignment.topLeft,
                child: Shimmer.fromColors(
                  baseColor: tGrey1.shade300,
                  highlightColor: tGrey1.shade100,
                  direction: ShimmerDirection.ltr,
                  period: const Duration(milliseconds: 1600),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _bar(110, 12, radius: 4), // label
                      const SizedBox(height: 8),
                      _bar(35, 3, radius: 10), // small underline
                      const SizedBox(height: 14),
                      _bar(contentW * 0.92, lineH), // heading line 1
                      const SizedBox(height: 10),
                      _bar(contentW * 0.70, lineH), // heading line 2
                      const SizedBox(height: 10),
                      _bar(contentW * 0.85, lineH), // heading line 3
                      const SizedBox(height: 10),
                      _bar(contentW * 0.50, lineH), // heading line 4
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // TABLET: full-bleed sweep, text bars scaled to the width
  // ─────────────────────────────────────────────────────────
  Widget _buildTablet(BuildContext context) {
    return SizedBox.expand(
      child: LayoutBuilder(
        builder: (context, c) {
          final double contentW = (c.maxWidth - 160).clamp(200.0, 700.0);

          return Stack(
            children: [
              // LAYER 1: grey background sweep
              Positioned.fill(
                child: Shimmer.fromColors(
                  baseColor: tGrey1.shade300,
                  highlightColor: tGrey1.shade100,
                  direction: ShimmerDirection.ltr,
                  period: const Duration(milliseconds: 1600),
                  child: Container(color: tWhite),
                ),
              ),

              // LAYER 2: text placeholders (font 35 x 1.15 ~ 40px lines)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Shimmer.fromColors(
                    baseColor: tWhite.withOpacity(0.45),
                    highlightColor: tWhite.withOpacity(0.85),
                    direction: ShimmerDirection.ltr,
                    period: const Duration(milliseconds: 1600),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _bar(120, 13, radius: 4), // label
                        const SizedBox(height: 8),
                        _bar(35, 3, radius: 10), // small underline
                        const SizedBox(height: 16),
                        _bar(contentW * 0.95, 36), // heading line 1
                        const SizedBox(height: 12),
                        _bar(contentW * 0.80, 36), // heading line 2
                        const SizedBox(height: 12),
                        _bar(contentW * 0.50, 36), // heading line 3
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // DESKTOP (unchanged)
  // ─────────────────────────────────────────────────────────
  Widget _buildDesktop(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          // LAYER 1: grey background sweep
          Positioned.fill(
            child: Shimmer.fromColors(
              baseColor: tGrey1.shade300,
              highlightColor: tGrey1.shade100,
              direction: ShimmerDirection.ltr,
              period: const Duration(milliseconds: 1600),
              child: Container(color: tWhite),
            ),
          ),

          // LAYER 2: text placeholders, lighter than the background
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Shimmer.fromColors(
                baseColor: tWhite.withOpacity(0.45),
                highlightColor: tWhite.withOpacity(0.85),
                direction: ShimmerDirection.ltr,
                period: const Duration(milliseconds: 1600),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _bar(130, 14, radius: 4), // label (COMPANY NEWS)
                    const SizedBox(height: 22),
                    _bar(640, 44), // heading line 1
                    const SizedBox(height: 14),
                    _bar(560, 44), // heading line 2
                    const SizedBox(height: 14),
                    _bar(380, 44), // heading line 3
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//industries section shimmer
class IndustriesShimmer extends StatelessWidget {
  const IndustriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      clipBehavior: Clip.none,
      itemCount: 10,
      separatorBuilder:
          (_, __) => const SizedBox(width: 12), // _industrySeparatorWidth
      itemBuilder: (context, index) {
        return SizedBox(
          width: 200, // _industryItemWidth
          child: Shimmer.fromColors(
            baseColor: tGrey1.shade300,
            highlightColor: tGrey1.shade100,
            child: Column(
              children: [
                // square image placeholder (AspectRatio 1, same as real card)
                // AspectRatio(
                //   aspectRatio: 1,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: tWhite,
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: tWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // label placeholder
                Container(
                  width: 90,
                  height: 12,
                  decoration: BoxDecoration(
                    color: tWhite,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

//featured products section shimmer (horizontal row, matches _buildProductCard)
class FeaturedProductsShimmer extends StatelessWidget {
  const FeaturedProductsShimmer({super.key});

  Widget _bar(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 12),
      clipBehavior: Clip.hardEdge,
      itemCount: 8,
      separatorBuilder: (_, __) => const SizedBox(width: 16),
      itemBuilder: (context, index) {
        return SizedBox(
          width: 220,
          height: 210,
          child: Shimmer.fromColors(
            baseColor: tGrey1.shade300,
            highlightColor: tGrey1.shade100,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: tWhite,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  // image placeholder
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: tWhite,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _bar(80, 13), // name
                  const SizedBox(height: 6),
                  _bar(120, 11), // subtitle
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

//news latest banner shimmer
class NewsBannerShimmer extends StatelessWidget {
  const NewsBannerShimmer({super.key});

  Widget _bar(double? w, double h, {double r = 4}) => Container(
    width: w ?? double.infinity,
    height: h,
    decoration: BoxDecoration(
      color: tWhite,
      borderRadius: BorderRadius.circular(r),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 330,
      decoration: BoxDecoration(
        color: tBlue1.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Shimmer.fromColors(
        baseColor: tGrey1.shade300,
        highlightColor: tGrey1.shade100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: 11, child: Container(color: tWhite)), // image
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(35, 25, 35, 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _bar(80, 24, r: 20), // LATEST pill
                    const SizedBox(height: 18),
                    _bar(170, 12), // category | date
                    const SizedBox(height: 12),
                    _bar(null, 24), // title line 1
                    const SizedBox(height: 8),
                    _bar(260, 24), // title line 2
                    const SizedBox(height: 12),
                    _bar(null, 12), // summary 1
                    const SizedBox(height: 7),
                    _bar(null, 12), // summary 2
                    const SizedBox(height: 7),
                    _bar(180, 12), // summary 3
                    const SizedBox(height: 20),
                    _bar(125, 40, r: 7), // Read Story button
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//news card shimmer (matches NewsCard: 350 tall, 180 image)
class NewsCardShimmer extends StatelessWidget {
  final double height;
  const NewsCardShimmer({super.key, this.height = 350});

  Widget _bar(double? w, double h) => Container(
    width: w ?? double.infinity,
    height: h,
    decoration: BoxDecoration(
      color: tWhite,
      borderRadius: BorderRadius.circular(4),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tGrey1.shade200),
      ),
      clipBehavior: Clip.antiAlias,
      child: Shimmer.fromColors(
        baseColor: tGrey1.shade300,
        highlightColor: tGrey1.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 180, width: double.infinity, color: tWhite),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _bar(130, 11), // category | date
                    const SizedBox(height: 10),
                    _bar(null, 16), // title 1
                    const SizedBox(height: 6),
                    _bar(180, 16), // title 2
                    const SizedBox(height: 8),
                    _bar(null, 12), // summary 1
                    const SizedBox(height: 6),
                    _bar(150, 12), // summary 2
                    const Spacer(),
                    _bar(80, 11), // Read More
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//all-news left list shimmer
class NewsListItemShimmer extends StatelessWidget {
  const NewsListItemShimmer({super.key});

  Widget _bar(double? w, double h) => Container(
    width: w ?? double.infinity,
    height: h,
    decoration: BoxDecoration(
      color: tWhite,
      borderRadius: BorderRadius.circular(4),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: tGrey1.shade300,
      highlightColor: tGrey1.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bar(140, 11),
            const SizedBox(height: 8),
            _bar(null, 14),
            const SizedBox(height: 6),
            _bar(200, 14),
          ],
        ),
      ),
    );
  }
}

//image with shimmer until first frame is painted
Widget shimmerImage(String path, {BoxFit fit = BoxFit.cover}) {
  return Image.asset(
    path,
    fit: fit,
    frameBuilder: (context, child, frame, wasSyncLoaded) {
      if (wasSyncLoaded || frame != null) return child;
      return const ShimmerBox(height: double.infinity);
    },
  );
}

//our team (leadership) section shimmer(about us page)
class TeamSectionShimmer extends StatelessWidget {
  const TeamSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // LEFT: heading + underline + paragraph
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerBox(
                  width: 260,
                  height: 30,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                SizedBox(height: 10),
                ShimmerBox(width: 75, height: 2),
                SizedBox(height: 20),
                ShimmerBox(
                  height: 12,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                SizedBox(height: 7),
                ShimmerBox(
                  height: 12,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                SizedBox(height: 7),
                ShimmerBox(
                  width: 160,
                  height: 12,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),

          const SizedBox(width: 80),

          // RIGHT: 3 profile cards
          Expanded(
            flex: 4,
            child: Row(
              children: [
                for (int i = 0; i < 3; i++) ...[
                  if (i > 0) const SizedBox(width: 20),
                  const Expanded(child: _TeamCardShimmer()),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamCardShimmer extends StatelessWidget {
  const _TeamCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tGrey1.shade200),
      ),
      clipBehavior: Clip.antiAlias,
      child: Shimmer.fromColors(
        baseColor: tGrey1.shade300,
        highlightColor: tGrey1.shade100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // photo (matches the 150px image)
            Container(height: 150, width: double.infinity, color: tWhite),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 14,
                    decoration: BoxDecoration(
                      color: tWhite,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 130,
                    height: 12,
                    decoration: BoxDecoration(
                      color: tWhite,
                      borderRadius: BorderRadius.circular(4),
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

//careers section shimmer (about us page)
class CareersSectionShimmer extends StatelessWidget {
  const CareersSectionShimmer({super.key});

  Widget _bar(double? w, double h, {double r = 4}) => Container(
    width: w ?? double.infinity,
    height: h,
    decoration: BoxDecoration(
      color: tWhite,
      borderRadius: BorderRadius.circular(r),
    ),
  );

  // one job row: icon box + 2 lines + experience pill
  Widget _jobRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          _bar(56, 56, r: 14),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bar(150, 15),
                const SizedBox(height: 9),
                _bar(210, 12),
              ],
            ),
          ),
          const SizedBox(width: 10),
          _bar(80, 32, r: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 525,
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: tGrey1.shade200),
      ),
      clipBehavior: Clip.antiAlias,
      child: Shimmer.fromColors(
        baseColor: tGrey1.shade300,
        highlightColor: tGrey1.shade100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // LEFT PANEL (flex 47)
            Expanded(
              flex: 47,
              child: Padding(
                // padding: const EdgeInsets.fromLTRB(40, 38, 40, 22),
                // child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     _bar(190, 12), // CURRENT OPENINGS
                //     const SizedBox(height: 18),
                //     _bar(320, 33, r: 6), // heading line 1
                //     const SizedBox(height: 8),
                //     _bar(240, 33, r: 6), // heading line 2
                //     const SizedBox(height: 14),
                //     _bar(null, 12), // subtitle 1
                //     const SizedBox(height: 7),
                //     _bar(260, 12), // subtitle 2
                //     const SizedBox(height: 18),
                padding: const EdgeInsets.fromLTRB(40, 30, 40, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _bar(190, 12), // CURRENT OPENINGS
                    const SizedBox(height: 14),
                    _bar(320, 33, r: 6), // heading line 1
                    const SizedBox(height: 8),
                    _bar(240, 33, r: 6), // heading line 2
                    const SizedBox(height: 12),
                    _bar(null, 12), // subtitle 1
                    const SizedBox(height: 7),
                    _bar(260, 12), // subtitle 2
                    const SizedBox(height: 14),
                    for (int i = 0; i < 3; i++) ...[
                      _jobRow(),
                      if (i != 2) const SizedBox(height: 10),
                    ],
                    const Spacer(),
                    _bar(190, 52, r: 10), // View All Openings button
                  ],
                ),
              ),
            ),

            // RIGHT PANEL (flex 53) - one whole box
            Expanded(flex: 53, child: Container(color: tWhite)),
          ],
        ),
      ),
    );
  }
}
