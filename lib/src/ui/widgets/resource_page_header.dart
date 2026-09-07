import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../utils/colors.dart';
import '../pages/main_page.dart';

class ResourcePageHeader extends StatelessWidget {
  final int selectedIndex;

  const ResourcePageHeader({super.key, this.selectedIndex = 6});

  static const List<String> menus = [
    'Home',
    'Solutions',
    'Engineering',
    'Manufacturing',
    'Products',
    'Industries',
    'Resources',
    'About Us',
  ];

  void _navigateToSection(BuildContext context, int index) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainPage(initialIndex: index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: tWhite,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ============================================================
          // LOGO
          // ============================================================
          SvgPicture.asset('icons/trakmate_logo.svg', height: 60),

          // ============================================================
          // MENU
          // ============================================================
          Row(
            children: List.generate(
              menus.length,
              (index) => _buildNavButton(context, menus[index], index),
            ),
          ),

          // ============================================================
          // GET IN TOUCH
          // ============================================================
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              decoration: BoxDecoration(
                gradient: tOrangeGradient2,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Text(
                    'Get in Touch',
                    style: GoogleFonts.manrope(
                      color: tWhite,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(width: 10),

                  SvgPicture.asset(
                    'icons/right_arrow.svg',
                    width: 22,
                    height: 22,
                    color: tWhite,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, String text, int index) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        _navigateToSection(context, index);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                style: GoogleFonts.manrope(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? tOrange1 : tBlack,
                ),
                child: Text(text),
              ),

              const SizedBox(height: 5),

              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                height: 2,
                width: isSelected ? 50 : 0,
                decoration: BoxDecoration(color: tOrange1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
