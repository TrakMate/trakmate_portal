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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 50),
              _buildBackButton(context),
              const SizedBox(height: 25),

              // const SizedBox(height: 70),
              Text(
                'App Showcase',
                // textAlign: TextAlign.center,
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

              const FooterSection(),
            ],
          ),
        ),
      ),
    );
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
                  'Back to Products',

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

class _PhoneShowcaseGrid extends StatelessWidget {
  const _PhoneShowcaseGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;

        int columnCount;

        if (availableWidth >= 1400) {
          columnCount = 5;
        } else if (availableWidth >= 1100) {
          columnCount = 4;
        } else if (availableWidth >= 800) {
          columnCount = 3;
        } else if (availableWidth >= 550) {
          columnCount = 2;
        } else {
          columnCount = 1;
        }

        const double spacing = 18;

        final cardWidth =
            (availableWidth - ((columnCount - 1) * spacing)) / columnCount;

        return Wrap(
          alignment: WrapAlignment.center,
          spacing: spacing,
          runSpacing: 28,
          children: [
            SizedBox(
              width: cardWidth,
              child: const _PhoneCard(
                image: 'images/trakfleet.png',
                topOffset: 50,
              ),
            ),

            SizedBox(
              width: cardWidth,
              child: const _PhoneCard(
                image: 'images/trakfleet.png',
                topOffset: 0,
              ),
            ),

            SizedBox(
              width: cardWidth,
              child: const _PhoneCard(
                image: 'images/trakfleet.png',
                topOffset: 70,
              ),
            ),

            SizedBox(
              width: cardWidth,
              child: const _PhoneCard(
                image: 'images/trakfleet.png',
                topOffset: 25,
              ),
            ),

            SizedBox(
              width: cardWidth,
              child: const _PhoneCard(
                image: 'images/trakfleet.png',
                topOffset: 55,
              ),
            ),

            SizedBox(
              width: cardWidth,
              child: const _PhoneCard(
                image: 'images/trakfleet.png',
                topOffset: 50,
              ),
            ),

            SizedBox(
              width: cardWidth,
              child: const _PhoneCard(
                image: 'images/trakfleet.png',
                topOffset: 0,
              ),
            ),

            SizedBox(
              width: cardWidth,
              child: const _PhoneCard(
                image: 'images/trakfleet.png',
                topOffset: 70,
              ),
            ),

            SizedBox(
              width: cardWidth,
              child: const _PhoneCard(
                image: 'images/trakfleet.png',
                topOffset: 25,
              ),
            ),

            SizedBox(
              width: cardWidth,
              child: const _PhoneCard(
                image: 'images/trakfleet.png',
                topOffset: 55,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PhoneCard extends StatelessWidget {
  final String image;
  final double topOffset;

  const _PhoneCard({required this.image, required this.topOffset});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topOffset),
      child: Container(
        width: double.infinity,
        height: 500,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: tWhite,
          borderRadius: BorderRadius.circular(34),
          boxShadow: [
            BoxShadow(
              color: tBlue3.withOpacity(.18),
              blurRadius: 28,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
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
      ),
    );
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 36, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: tWhite.withOpacity(.15),
                borderRadius: BorderRadius.circular(13),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.menu_book_rounded,
                color: tWhite,
                size: 22,
              ),
            ),
          ),

          // const Spacer(),

          // Text(
          //   'TrakMate',
          //   textAlign: TextAlign.center,
          //   style: GoogleFonts.manrope(
          //     fontSize: 26,
          //     fontWeight: FontWeight.w800,
          //     color: tWhite,
          //   ),
          // ),

          // const SizedBox(height: 8),

          // Text(
          //   'Track everything, effortlessly',
          //   textAlign: TextAlign.center,
          //   style: GoogleFonts.manrope(
          //     fontSize: 11,
          //     color: tWhite.withOpacity(.85),
          //   ),
          // ),
          const Spacer(),

          const _PrimaryButton(label: 'Watch Demo'),

          const SizedBox(height: 10),

          const _OutlineButton(label: 'View App'),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;

  const _PrimaryButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 11),
      decoration: BoxDecoration(
        color: tOrange1,
        borderRadius: BorderRadius.circular(11),
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
              fontSize: 11.5,
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

class _OutlineButton extends StatelessWidget {
  final String label;

  const _OutlineButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 11),
      decoration: BoxDecoration(
        color: tWhite.withOpacity(.08),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: tWhite.withOpacity(.45)),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: GoogleFonts.manrope(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: tWhite,
        ),
      ),
    );
  }
}
