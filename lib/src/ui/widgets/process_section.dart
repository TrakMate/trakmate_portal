import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          eyebrow,
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: tOrange1,
            letterSpacing: 1.2,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: tBlue2,
          ),
        ),

        const SizedBox(height: 32),

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
                      ),
                    ),

                    if (index != steps.length - 1)
                      SizedBox(
                        width: 90,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: _buildDottedArrow(),
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

  Widget _buildProcessItem(ProcessStepData process, Color circleColor) {
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

        Text(
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

        const SizedBox(height: 5),

        SizedBox(
          width: 180,
          height: 49,
          child: Text(
            process.description,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
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
