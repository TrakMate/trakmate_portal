import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';
import '../widgets/footer_section.dart';
import '../widgets/resource_page_header.dart';

class CaseStudiesPage extends StatelessWidget {
  const CaseStudiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tWhite,
      body: Column(
        children: [
          const ResourcePageHeader(selectedIndex: 6),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHero(),

                  const SizedBox(height: 50),

                  _buildPlaceholder('CASE STUDIES CONTENT GOES HERE'),

                  const SizedBox(height: 60),

                  FooterSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      width: double.infinity,
      height: 400,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tBlue2, tBlue3],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label('CASE STUDIES'),

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
                      const TextSpan(text: 'Real Solutions.\n'),
                      TextSpan(
                        text: 'Real Results.',
                        style: TextStyle(
                          color: tOrange1,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                _description(
                  'Discover how we solve real-world business challenges through innovative technology, engineering and digital solutions.',
                ),

                const SizedBox(height: 35),

                Row(
                  children: [
                    Expanded(child: _item('Proven', 'Solutions')),
                    Expanded(child: _item('Measurable', 'Results')),
                    Expanded(child: _item('Industry', 'Expertise')),
                    Expanded(child: _item('Client', 'Success')),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 40),

          Expanded(flex: 4, child: _image()),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: GoogleFonts.manrope(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: tOrange1,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _description(String text) {
    return Text(
      text,
      style: GoogleFonts.manrope(fontSize: 13, color: tWhite, height: 1.5),
    );
  }

  Widget _item(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle_outline, color: tOrange1, size: 28),
        const SizedBox(height: 9),
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
          style: GoogleFonts.manrope(
            color: tWhite.withOpacity(0.65),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _image() {
    return Container(
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
      child: Image.asset('images/company.jpg', fit: BoxFit.cover),
    );
  }

  Widget _buildPlaceholder(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 44),
      child: Container(
        width: double.infinity,
        height: 450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: tBlack.withOpacity(0.08)),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.manrope(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: tBlue2,
            ),
          ),
        ),
      ),
    );
  }
}
