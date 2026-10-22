import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:trakmate_portal/src/utils/responsive.dart';

import '../../utils/colors.dart';

class ProcessSection extends StatelessWidget {
  final String eyebrow;
  final String title;
  final List<ProcessStepData> steps;

  const ProcessSection({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.steps,
  });

  // Breakpoints come from ResponsiveLayout:
  //   mobile  < 700   |   tablet 700 - 1099   |   desktop >= 1100
  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isTablet = ResponsiveLayout.isTablet(context);

    return Column(
      children: [
        Text(
          eyebrow,
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: isMobile ? 12 : 13,
            fontWeight: FontWeight.w600,
            color: tOrange1,
            letterSpacing: 1.2,
          ),
        ),

        SizedBox(height: isMobile ? 8 : 10),

        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: isMobile ? 20 : 25,
            fontWeight: FontWeight.w700,
            color: tBlue2,
            height: isMobile ? 1.25 : null,
          ),
        ),

        SizedBox(height: isMobile ? 24 : 32),

        // MOBILE: vertical timeline (circle + line on the left, text on the right)
        if (isMobile)
          _buildMobileTimeline()
        // TABLET / DESKTOP: steps in one row
        else
          LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int index = 0; index < steps.length; index++) ...[
                      Expanded(
                        child: _buildProcessItem(
                          steps[index],
                          index.isEven ? tBlue3 : tOrange1,
                          isTablet: isTablet,
                        ),
                      ),

                      if (index != steps.length - 1)
                        SizedBox(
                          // Tablet: wider connector (was 28)
                          width: isTablet ? 56 : 90,
                          child: Padding(
                            // Circle is 54 tall (center = 27).
                            // Tablet arrow is 22 tall -> top 16 keeps it centered.
                            // Desktop keeps its original 20.
                            padding: EdgeInsets.only(top: isTablet ? 16 : 20),
                            child:
                                isTablet
                                    ? _buildTabletArrow()
                                    : _buildDottedArrow(),
                          ),
                        ),
                    ],
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // MOBILE
  // ---------------------------------------------------------------------------
  Widget _buildMobileTimeline() {
    return Column(
      children: [
        for (int index = 0; index < steps.length; index++)
          _buildMobileStep(
            steps[index],
            index.isEven ? tBlue3 : tOrange1,
            isLast: index == steps.length - 1,
          ),
      ],
    );
  }

  Widget _buildMobileStep(
    ProcessStepData process,
    Color circleColor, {
    required bool isLast,
  }) {
    const double circleSize = 48;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left: numbered icon circle + connecting line to the next step
          SizedBox(
            width: circleSize,
            child: Column(
              children: [
                Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    color: circleColor,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(process.icon, color: tWhite),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: tBlue3.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Right: step number, title and description
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24, top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    process.number,
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: tOrange1,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    process.title,
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: tBlack,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    process.description,
                    style: GoogleFonts.manrope(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: tBlack.withOpacity(0.6),
                      height: 1.4,
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

  // ---------------------------------------------------------------------------
  // TABLET / DESKTOP
  // ---------------------------------------------------------------------------
  Widget _buildProcessItem(
    ProcessStepData process,
    Color circleColor, {
    bool isTablet = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
          padding: const EdgeInsets.all(11),
          child: SvgPicture.asset(process.icon, color: tWhite),
        ),

        const SizedBox(height: 10),

        Text(
          process.number,
          style: GoogleFonts.manrope(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: tOrange1,
            letterSpacing: 0.8,
          ),
        ),

        const SizedBox(height: 4),

        SizedBox(
          height: isTablet ? 40 : null,
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              process.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.manrope(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: tBlack,
              ),
            ),
          ),
        ),

        const SizedBox(height: 5),

        SizedBox(
          width: isTablet ? null : 180,
          height: isTablet ? null : 49,
          child: Text(
            process.description,
            textAlign: TextAlign.center,
            maxLines: isTablet ? null : 3,
            overflow: isTablet ? TextOverflow.visible : TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: tBlack.withOpacity(0.55),
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }

  // TABLET: wider connector = short dotted line + larger arrow.
  // FittedBox(scaleDown) guarantees it never overflows the 56px slot.
  Widget _buildTabletArrow() {
    return SizedBox(
      width: 56,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 2 dots (was 3)
            for (int i = 0; i < 2; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Icon(
                  Icons.circle,
                  size: 3.5,
                  color: tBlue3.withOpacity(0.45),
                ),
              ),

            const SizedBox(width: 2),

            Icon(
              Icons.arrow_forward_rounded,
              size: 22,
              color: tBlue3.withOpacity(0.65),
            ),
          ],
        ),
      ),
    );
  }

  // DESKTOP (unchanged)
  Widget _buildDottedArrow() {
    return SizedBox(
      width: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < 9; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Icon(
                Icons.circle,
                size: 3.5,
                color: tBlue3.withOpacity(0.45),
              ),
            ),

          const SizedBox(width: 2),

          Icon(
            Icons.arrow_forward_rounded,
            size: 18,
            color: tBlue3.withOpacity(0.65),
          ),
        ],
      ),
    );
  }
}

class ProcessStepData {
  final String number;
  final String icon;
  final String title;
  final String description;

  const ProcessStepData({
    required this.number,
    required this.icon,
    required this.title,
    required this.description,
  });
}
