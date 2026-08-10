import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../utils/colors.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: tBlue3,
        // gradient: tBlueGradient
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _leftSection()),

              _divider(),

              _menu("Solutions", [
                "IoT Solutions",
                "Embedded Systems",
                "Software Development",
                "Cloud & AI",
                "Mobile Apps",
                "Web Applications",
              ]),
              _divider(),

              _menu("Engineering", [
                "CAD Design",
                "Product Design",
                "Mechanical Engineering",
                "PCB Design",
                "PCB Assembly (PCBA)",
                "Firmware Development",
                "Prototyping",
              ]),
              _divider(),

              _menu("Manufacturing", [
                "Electronics Manufacturing",
                "Product Assembly",
                "Testing & Validation",
                "Quality Assurance",
                "Production Support",
                "Contract Manufacturing",
              ]),
              _divider(),

              _menu("Company", [
                "About Us",
                "Our Team",
                "Infrastructure",
                "Careers",
                "News & Media",
                "Contact Us",
              ]),
              _divider(),

              _menu("Resources", [
                "Case Studies",
                "Whitepapers",
                "Blogs",
                "Documentation",
                "Downloads",
                "FAQs",
              ]),

              _divider(),

              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Contact Us",
                      style: GoogleFonts.manrope(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: tWhite,
                      ),
                    ),
                    const SizedBox(height: 15),

                    _contact("icons/mail.svg", "info@trakmate.co.in"),
                    const SizedBox(height: 10),
                    _contact("icons/call.svg", "+91 80 41532112"),
                    const SizedBox(height: 10),
                    _contact("icons/location.svg", "Bengaluru, India"),

                    const SizedBox(height: 15),

                    SvgPicture.asset(
                      "icons/world_map.svg",
                      height: 80,
                      color: tBlue.withOpacity(0.2),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          Row(
            children: [
              Text(
                "© 2026 Trakmate Design Solutions Pvt Ltd. All Rights Reserved.",
                style: GoogleFonts.manrope(
                  color: tWhite,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const Spacer(),

              Text(
                "Privacy Policy",
                style: GoogleFonts.manrope(
                  color: tWhite,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "|",
                  style: GoogleFonts.manrope(
                    color: tWhite,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Text(
                "Terms & Conditions",
                style: GoogleFonts.manrope(
                  color: tWhite,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _leftSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          "icons/trakmate_logo1.svg", // Replace with your logo
          height: 70,
        ),

        const SizedBox(height: 20),

        Text(
          "We provide innovative IoT products, embedded solutions, CAD/PCB design and manufacturing services to clients worldwide.",
          style: GoogleFonts.manrope(
            color: tWhite.withOpacity(0.7),
            height: 1.5,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),

        const SizedBox(height: 25),

        Row(
          children: [
            _social('icons/linkedin.svg'),
            _social('icons/facebook.svg'),
            _social('icons/whatsapp.svg'),
            _social('icons/youtube.svg'),
          ],
        ),
      ],
    );
  }

  Widget _menu(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.manrope(
            color: tWhite,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),

        const SizedBox(height: 15),

        ...items.map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Text(
                e,
                style: GoogleFonts.manrope(
                  color: tWhite.withOpacity(0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _social(String iconPath) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: tWhite.withOpacity(0.6)),
      ),
      child: Center(
        child: SvgPicture.asset(
          iconPath,
          width: 16,
          height: 16,
          color: tWhite.withOpacity(0.8),
        ),
      ),
    );
  }

  Widget _contact(String iconPath, String text) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          width: 16,
          height: 16,
          color: tWhite.withOpacity(0.7),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: GoogleFonts.manrope(
            fontSize: 13,
            color: tWhite.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      width: 1,
      height: 200,
      color: tWhite.withOpacity(0.05),
    );
  }
}
