import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';
import '../widgets/footer_section.dart';
import '../widgets/resource_page_header.dart';

class WhitepapersPage extends StatelessWidget {
  const WhitepapersPage({super.key});

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

                  _placeholder('WHITEPAPERS CONTENT GOES HERE'),

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
    return _hero(
      label: 'WHITEPAPERS',
      first: 'Research. Insights.',
      second: 'Knowledge.',
      description:
          'Explore in-depth research, technical insights and industry perspectives designed to help you understand emerging technologies and make informed decisions.',
      items: const [
        ['Industry', 'Research'],
        ['Technical', 'Insights'],
        ['Expert', 'Analysis'],
        ['Future', 'Trends'],
      ],
    );
  }

  Widget _hero({
    required String label,
    required String first,
    required String second,
    required String description,
    required List<List<String>> items,
  }) {
    return Container(
      width: double.infinity,
      height: 400,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [tBlue2, tBlue3]),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
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
                      TextSpan(text: '$first\n'),
                      TextSpan(
                        text: second,
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
                  description,
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    color: tWhite,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 35),

                Row(
                  children:
                      items
                          .map(
                            (item) => Expanded(child: _item(item[0], item[1])),
                          )
                          .toList(),
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
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: Image.asset('images/company.jpg', fit: BoxFit.cover),
    );
  }

  Widget _placeholder(String text) {
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
