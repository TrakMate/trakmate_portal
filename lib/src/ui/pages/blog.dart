import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';
import '../widgets/footer_section.dart';
import '../widgets/resource_page_header.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tWhite,

      body: Column(
        children: [
          // ============================================================
          // SAME MENU
          // ============================================================
          const ResourcePageHeader(selectedIndex: 6),

          // ============================================================
          // PAGE CONTENT
          // ============================================================
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHero(),

                  const SizedBox(height: 50),

                  _buildPlaceholder(),

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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tBlue2, tBlue3],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BLOG',
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
                      const TextSpan(text: 'Ideas. Insights.\n'),
                      TextSpan(
                        text: 'Innovation.',
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
                  'Explore insights, ideas and perspectives from our team on technology, IoT, engineering and digital transformation.',
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    color: tWhite,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 35),

                Row(
                  children: [
                    Expanded(child: _heroItem('Industry', 'Insights')),
                    Expanded(child: _heroItem('Technology', 'Trends')),
                    Expanded(child: _heroItem('Expert', 'Perspectives')),
                    Expanded(child: _heroItem('Latest', 'Updates')),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 40),

          Expanded(flex: 4, child: _buildImage()),
        ],
      ),
    );
  }

  Widget _heroItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: tOrange1.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check_rounded, size: 17, color: tOrange1),
        ),

        const SizedBox(height: 9),

        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.manrope(
            color: tWhite,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 3),

        Text(
          description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.manrope(
            color: tWhite.withOpacity(0.65),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
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
    );
  }

  Widget _buildPlaceholder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 44),
      child: Container(
        width: double.infinity,
        height: 450,
        decoration: BoxDecoration(
          color: tWhite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: tBlack.withOpacity(0.08)),
          boxShadow: [
            BoxShadow(
              color: tBlack.withOpacity(0.04),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'BLOG CONTENT GOES HERE',
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
