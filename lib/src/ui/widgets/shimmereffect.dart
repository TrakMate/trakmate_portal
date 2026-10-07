import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trakmate_portal/src/utils/colors.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;

        final double cardWidth = screenWidth >= 1800 ? 410 : 330;

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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

  @override
  Widget build(BuildContext context) {
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
//hero slider shimmer (grey sweep + visible text placeholders)
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
            padding: const EdgeInsets.symmetric(
              horizontal: 80,
            ), // same as slide
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
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
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
