import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trakmate_portal/src/ui/widgets/footer_section.dart';

import '../../utils/colors.dart';

class MobileApp extends StatelessWidget {
  const MobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBackButton(context),

                  const SizedBox(height: 14),
                  Text(
                    'App Showcase',
                    style: GoogleFonts.manrope(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      color: tOrange1,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'A closer look at the screens inside the experience.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      color: tBlack.withOpacity(.55),
                    ),
                  ),

                  const SizedBox(height: 60),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: _PhoneShowcaseGrid(),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),

            const FooterSection(),
          ],
        ),
      ),
    );
  }

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
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back_rounded, size: 18, color: tBlue3),

                const SizedBox(width: 7),

                Text(
                  'Back to solutions',
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
}

// ================================================================
// PHONE SHOWCASE GRID
// ================================================================

class _PhoneShowcaseGrid extends StatelessWidget {
  const _PhoneShowcaseGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;

        int columnCount;
        double crossAxisSpacing;
        double mainAxisSpacing;
        double cardHeight;
        double horizontalPadding;

        // ==========================================================
        // BIG MONITOR
        // 1400px+
        // 5 CARDS PER ROW
        // ==========================================================

        if (availableWidth >= 1400) {
          columnCount = 5;
          crossAxisSpacing = 18;
          mainAxisSpacing = 28;
          cardHeight = 500;
          horizontalPadding = 0;
        }
        // ==========================================================
        // HP LAPTOP
        // 1150px - 1399px
        // 4 CARDS PER ROW
        // ==========================================================
        else if (availableWidth >= 1150) {
          columnCount = 4;
          crossAxisSpacing = 16;
          mainAxisSpacing = 24;
          cardHeight = 430;
          horizontalPadding = 10;
        }
        // ==========================================================
        // SMALL LAPTOP / TABLET
        // 800px - 1149px
        // 3 CARDS PER ROW
        // ==========================================================
        else if (availableWidth >= 800) {
          columnCount = 3;
          crossAxisSpacing = 16;
          mainAxisSpacing = 22;
          cardHeight = 410;
          horizontalPadding = 5;
        }
        // ==========================================================
        // TABLET
        // 550px - 799px
        // 2 CARDS PER ROW
        // ==========================================================
        else if (availableWidth >= 550) {
          columnCount = 2;
          crossAxisSpacing = 18;
          mainAxisSpacing = 24;
          cardHeight = 450;
          horizontalPadding = 0;
        }
        // ==========================================================
        // MOBILE
        // BELOW 550px
        // 1 CARD PER ROW
        // ==========================================================
        else {
          columnCount = 1;
          crossAxisSpacing = 0;
          mainAxisSpacing = 24;
          cardHeight = 450;
          horizontalPadding = 0;
        }

        final gridWidth = availableWidth - (horizontalPadding * 2);

        final cardWidth =
            (gridWidth - ((columnCount - 1) * crossAxisSpacing)) / columnCount;

        // ==========================================================
        // MAXIMUM OFFSET IN ONE ROW
        //
        // IMPORTANT:
        // Every row gets the same amount of reserved height.
        // ==========================================================

        final maxTopOffset = _getMaxTopOffset(availableWidth, columnCount);

        final rowHeight = cardHeight + maxTopOffset;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnCount,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,

              // Every row has exactly the same height.
              mainAxisExtent: rowHeight,
            ),

            itemBuilder: (context, index) {
              // ==================================================
              // IMPORTANT FIX
              //
              // Calculate the COLUMN index.
              //
              // This makes the pattern repeat on EVERY row.
              // ==================================================

              final columnIndex = index % columnCount;

              final topOffset = _getTopOffset(columnIndex, availableWidth);

              return SizedBox(
                width: cardWidth,
                height: rowHeight,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: topOffset),
                    child: SizedBox(
                      width: cardWidth,
                      height: cardHeight,
                      child: _PhoneCard(
                        image: 'images/trakfleet.png',
                        cardHeight: cardHeight,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // ==============================================================
  // GET TOP OFFSET
  //
  // The offset is based ONLY on the column.
  //
  // Therefore the same pattern repeats on every row.
  // ==============================================================

  double _getTopOffset(int columnIndex, double width) {
    double originalOffset;

    // ============================================================
    // BIG MONITOR
    //
    // Pattern:
    //
    // 50   0   50   0   50
    // ↓    ↑   ↓    ↑   ↓
    // ============================================================

    if (width >= 1400) {
      const offsets = [50.0, 0.0, 50.0, 0.0, 50.0];

      originalOffset = offsets[columnIndex.clamp(0, offsets.length - 1)];

      return originalOffset;
    }

    // ============================================================
    // HP LAPTOP
    //
    // Pattern:
    //
    // 50   0   50   0
    // ↓    ↑   ↓    ↑
    // ============================================================

    if (width >= 1150) {
      const offsets = [50.0, 0.0, 50.0, 0.0];

      originalOffset = offsets[columnIndex.clamp(0, offsets.length - 1)];

      return originalOffset * 0.45;
    }

    // ============================================================
    // SMALL LAPTOP / TABLET
    // ============================================================

    if (width >= 800) {
      const offsets = [50.0, 0.0, 50.0];

      originalOffset = offsets[columnIndex.clamp(0, offsets.length - 1)];

      return originalOffset * 0.40;
    }

    // ============================================================
    // TABLET
    // ============================================================

    if (width >= 550) {
      const offsets = [50.0, 0.0];

      originalOffset = offsets[columnIndex.clamp(0, offsets.length - 1)];

      return originalOffset * 0.30;
    }

    // ============================================================
    // MOBILE
    // ============================================================

    return 0;
  }

  // ==============================================================
  // GET MAX OFFSET
  //
  // Used to reserve enough vertical space for every row.
  // ==============================================================

  double _getMaxTopOffset(double width, int columnCount) {
    if (width >= 1400) {
      return 50;
    }

    if (width >= 1150) {
      return 50 * 0.45;
    }

    if (width >= 800) {
      return 50 * 0.40;
    }

    if (width >= 550) {
      return 50 * 0.30;
    }

    return 0;
  }
}

// ================================================================
// PHONE CARD
// ================================================================

class _PhoneCard extends StatelessWidget {
  final String image;
  final double cardHeight;

  const _PhoneCard({required this.image, required this.cardHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: cardHeight,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: tBlue3.withOpacity(.18),
            blurRadius: 28,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(23),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: tBlue3);
              },
            ),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [tBlue3.withOpacity(.20), tBlue3.withOpacity(.35)],
                ),
              ),
            ),

            const _SplashScreen(),
          ],
        ),
      ),
    );
  }
}

// ================================================================
// SPLASH SCREEN
// ================================================================

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 28, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: tWhite.withOpacity(.15),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.menu_book_rounded,
                color: tWhite,
                size: 21,
              ),
            ),
          ),

          const Spacer(),

          const _PrimaryButton(label: 'Watch Demo'),

          const SizedBox(height: 9),

          const _OutlineButton(label: 'View App'),
        ],
      ),
    );
  }
}

// ================================================================
// PRIMARY BUTTON
// ================================================================

class _PrimaryButton extends StatelessWidget {
  final String label;

  const _PrimaryButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: tOrange1,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: tOrange1.withOpacity(.45),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: tWhite,
            ),
          ),

          const SizedBox(width: 6),

          const Icon(Icons.arrow_forward_rounded, size: 14, color: tWhite),
        ],
      ),
    );
  }
}

// ================================================================
// OUTLINE BUTTON
// ================================================================

class _OutlineButton extends StatelessWidget {
  final String label;

  const _OutlineButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: tWhite.withOpacity(.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tWhite.withOpacity(.45)),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: GoogleFonts.manrope(
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          color: tWhite,
        ),
      ),
    );
  }
}
