import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/widgets/buildengineering.dart';
import 'package:trakmate_portal/src/utils/colors.dart';

import '../widgets/footer_section.dart';

class EngineeringSection extends StatefulWidget {
  const EngineeringSection({super.key});

  @override
  State<EngineeringSection> createState() => _EngineeringSectionState();
}

class _EngineeringSectionState extends State<EngineeringSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildEngineeringHeader(),
          const SizedBox(height: 40),
          BuildEngineeringSection(),
          const SizedBox(height: 40),
          FooterSection(),
        ],
      ),
    );
  }

  // HEADER
  Widget _buildEngineeringHeader() {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tBlue2, tBlue3],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ENGINEERING',
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: tOrange1,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 20),

                RichText(
                  text: TextSpan(
                    style: GoogleFonts.manrope(
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
                      height: 1.15,
                      color: tWhite,
                    ),
                    children: [
                      const TextSpan(text: 'Engineering Innovation.\n'),
                      TextSpan(
                        text: 'Built to Perform.',
                        style: TextStyle(
                          color: tOrange1,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  'From concept to production, we deliver end-to-end engineering solutions that bring your ideas to life with precision, quality and efficiency.',
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    color: tWhite,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 35),

                Row(
                  children: [
                    Expanded(
                      // child: Center(
                      child: _buildHeaderIntroCard(
                        icon: 'icons/globe.svg',
                        title: 'End-to-End',
                        description: 'Engineering',
                      ),
                      // ),
                    ),
                    Expanded(
                      // child: Center(
                      child: _buildHeaderIntroCard(
                        icon: 'icons/globe.svg',
                        title: 'Advanced',
                        description: 'Tools & Software',
                      ),
                      // ),
                    ),
                    Expanded(
                      // child: Center(
                      child: _buildHeaderIntroCard(
                        icon: 'icons/globe.svg',
                        title: 'Expert',
                        description: 'Engineering Team',
                      ),
                      // ),
                    ),
                    Expanded(
                      // child: Center(
                      child: _buildHeaderIntroCard(
                        icon: 'icons/globe.svg',
                        title: 'Quality &',
                        description: 'Reliability',
                      ),
                      // ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 40),

          Expanded(
            flex: 4,
            child: Container(
              height: 340,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: tBlack.withOpacity(0.25),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                'images/company.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: tBlack.withOpacity(0.05),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 50,
                      color: tWhite.withOpacity(0.6),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIntroCard({
    required String icon,
    required String title,
    required String description,
  }) {
    return SizedBox(
      width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            child: Center(
              child: SvgPicture.asset(
                icon,
                width: 30,
                height: 30,
                color: tOrange1,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            title,
            style: GoogleFonts.manrope(
              color: tWhite,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),

          Text(
            description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              color: tWhite,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
