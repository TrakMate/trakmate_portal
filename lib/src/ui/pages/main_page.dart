import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../utils/colors.dart';
import '../sections/aboutUs_section.dart';
import '../sections/engineering_section.dart';
import '../sections/home_section.dart';
import '../sections/industries_section.dart';
import '../sections/manufacturing_section.dart';
import '../sections/products_section.dart';
import '../sections/resources_section.dart';
import '../sections/solutions_section.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  final List<String> menus = [
    'Home',
    'Solutions',
    'Engineering',
    'Manufacturing',
    'Products',
    'Industries',
    'Resources',
    'About Us',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tWhite,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: [
                HomeSection(
                  onNavigate: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
                SolutionsSection(
                  onNavigate: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
                EngineeringSection(),
                ManufacturingSection(),
                ProductsSection(),
                IndustriesSection(),
                ResourcesSection(),
                AboutusSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset('icons/trakmate_logo.svg', height: 60),
          Row(
            children: List.generate(
              menus.length,
              (index) => _navButton(menus[index], index),
            ),
          ),

          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              decoration: BoxDecoration(
                // color: tOrange1,
                gradient: tOrangeGradient2,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Text(
                    "Get in Touch",
                    style: GoogleFonts.manrope(
                      color: tWhite,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 10),
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

  Widget _navButton(String text, int index) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
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
                decoration: BoxDecoration(
                  color: tOrange1,
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
