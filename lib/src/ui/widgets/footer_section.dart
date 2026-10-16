//footer
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:trakmate_portal/src/ui/pages/main_page.dart';
import 'package:trakmate_portal/src/ui/widgets/nav_footer.dart';
import 'package:trakmate_portal/src/utils/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/colors.dart';

class FooterSection extends StatelessWidget {
  final void Function(int index)? onNavigate;
  const FooterSection({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final isTablet = ResponsiveLayout.isTablet(context);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: tBlue3),
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 24 : 40,
        vertical: 25,
      ),
      child: Column(
        children: [
          isTablet ? _tabletTop() : _desktopTop(),

          const SizedBox(height: 30),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Made with  ",
                  style: GoogleFonts.manrope(
                    color: tWhite.withOpacity(0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SvgPicture.asset(
                  "icons/heart.svg",
                  width: 14,
                  height: 14,
                  color: tWhite.withOpacity(0.7),
                ),
                Text(
                  "  INDIA",
                  style: GoogleFonts.manrope(
                    color: tWhite.withOpacity(0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          isTablet ? _bottomBar() : _desktopBottomBar(),
        ],
      ),
    );
  }

  Widget _engineeringMenu() => _menu("Engineering", [
    "CAD Design",
    "Product Design",
    "Mechanical Engineering",
    "PCB Design",
    "PCB Assembly (PCBA)",
    "Firmware Development",
    "Prototyping",
  ], sectionIndex: 1);

  Widget _manufacturingMenu() => _menu("Manufacturing", [
    "Electronics Manufacturing",
    "Product Assembly",
    "Testing & Validation",
    "Quality Assurance",
    "Production Support",
    "Contract Manufacturing",
  ], sectionIndex: 2);

  Widget _productsMenu() => _menu("Products & Solutions", [
    "All Products",
    "Telematics",
    "Vehicle Diagnostics",
    "Gateways",
    "Clusters",
    "ADAS",
    "Solution Hub",
  ], sectionIndex: 3);

  Widget _companyMenu() => _menu("Company", [
    "About Us",
    "Our Journey",
    "Vision & Mission",
    "Leadership",
    "Careers",
    "Certifications",
    "Contact Us",
  ], sectionIndex: 5);

  Widget _getInTouch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Get in Touch",
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: tWhite,
          ),
        ),
        const SizedBox(height: 15),
        _contactLinks("icons/mail.svg", ["info@trakmate.co.in"], 'mailto'),
        const SizedBox(height: 10),
        _contactLinks("icons/call.svg", [
          "+91 80 41532112",
          "+91 99 00450640",
        ], 'tel'),
        const SizedBox(height: 10),
        _contact(
          "icons/location.svg",
          "TrakMate Design Solutions Pvt Ltd.\n"
              "17G/46-3 and 17G/46-3-1,\n"
              "1st & 2nd floor, MEI Road, Industrial Suburb, Yeshwanthpura,\n Bengaluru -560022",
        ),
        const SizedBox(height: 15),
        SvgPicture.asset(
          "icons/world_map.svg",
          height: 80,
          color: tBlue.withOpacity(0.2),
        ),
      ],
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

  Widget _desktopTop() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _leftSection()),
        _divider(),
        _engineeringMenu(),
        _divider(),
        _manufacturingMenu(),
        _divider(),
        _productsMenu(),
        _divider(),
        _companyMenu(),
        _divider(),
        Expanded(flex: 2, child: _getInTouch()),
      ],
    );
  }

  Widget _tabletTop() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _leftSection()),
            const SizedBox(width: 40),
            Expanded(child: _getInTouch()),
          ],
        ),
        const SizedBox(height: 30),
        Divider(color: tWhite.withOpacity(0.1), height: 1),
        const SizedBox(height: 25),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _engineeringMenu()),
            Expanded(child: _manufacturingMenu()),
            Expanded(child: _productsMenu()),
            Expanded(child: _companyMenu()),
          ],
        ),
      ],
    );
  }

  Widget _desktopBottomBar() {
    final style = GoogleFonts.manrope(
      color: tWhite,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
    return Row(
      children: [
        Text(
          "© ${DateTime.now().year} Trakmate Design Solutions Pvt Ltd. All Rights Reserved.",
          style: style,
        ),
        const Spacer(),
        Text("Privacy Policy", style: style),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text("|", style: style.copyWith(fontWeight: FontWeight.w600)),
        ),
        Text("Terms & Conditions", style: style),
      ],
    );
  }

  Widget _bottomBar() {
    final style = GoogleFonts.manrope(
      color: tWhite,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: 8,
        children: [
          Text(
            "© ${DateTime.now().year} Trakmate Design Solutions Pvt Ltd. All Rights Reserved.",
            style: style,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Privacy Policy", style: style),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("|", style: style),
              ),
              Text("Terms & Conditions", style: style),
            ],
          ),
        ],
      ),
    );
  }

  Widget _menu(String title, List<String> items, {int? sectionIndex}) {
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
              child: Builder(
                builder:
                    (context) => GestureDetector(
                      onTap: () {
                        if (e == "Contact Us") {
                          showGetInTouchDialog(context);
                          return;
                        }
                        if (sectionIndex != null) {
                          SectionScrollBus.instance.request(e);
                          onNavigate?.call(sectionIndex);
                        }
                      },
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 16,
          height: 16,
          color: tWhite.withOpacity(0.7),
        ),
        const SizedBox(width: 10),

        Expanded(
          child: Text(
            text,
            style: GoogleFonts.manrope(
              fontSize: 13,
              color: tWhite.withOpacity(0.7),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _openContact(String value, String scheme) async {
    final Uri uri =
        scheme == 'tel'
            ? Uri(scheme: 'tel', path: value.replaceAll(' ', ''))
            : Uri(scheme: 'mailto', path: value);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _contactLinks(String iconPath, List<String> values, String scheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 16,
          height: 16,
          color: tWhite.withOpacity(0.7),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final value in values)
                _FooterLink(
                  text: value,
                  onTap: () => _openContact(value, scheme),
                ),
            ],
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

// class _FooterLink extends StatefulWidget {
//   final String text;
//   final VoidCallback onTap;

//   const _FooterLink({required this.text, required this.onTap});

//   @override
//   State<_FooterLink> createState() => _FooterLinkState();
// }

// class _FooterLinkState extends State<_FooterLink> {
//   bool _hovered = false;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 1.5),
//       child: MouseRegion(
//         cursor: SystemMouseCursors.click,
//         onEnter: (_) => setState(() => _hovered = true),
//         onExit: (_) => setState(() => _hovered = false),
//         child: GestureDetector(
//           onTap: widget.onTap,
//           child: Text(
//             widget.text,
//             style: GoogleFonts.manrope(
//               fontSize: 13,
//               color: _hovered ? tWhite : tWhite.withOpacity(0.7),
//               decoration:
//                   _hovered ? TextDecoration.underline : TextDecoration.none,
//               decorationColor: tWhite,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class _FooterLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _FooterLink({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            text,
            style: GoogleFonts.manrope(
              fontSize: 13,
              color: tWhite.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}
