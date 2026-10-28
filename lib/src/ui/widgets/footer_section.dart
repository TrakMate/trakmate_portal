//footer
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:trakmate_portal/src/ui/pages/main_page.dart';
import 'package:trakmate_portal/src/ui/pages/privacy_policy.dart';
import 'package:trakmate_portal/src/ui/pages/refund_policy.dart';
import 'package:trakmate_portal/src/ui/pages/terms_condition.dart';
import 'package:trakmate_portal/src/ui/widgets/nav_footer.dart';
import 'package:trakmate_portal/src/utils/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/colors.dart';

class FooterSection extends StatelessWidget {
  final void Function(int index)? onNavigate;
  const FooterSection({super.key, this.onNavigate});

  // Breakpoints come from ResponsiveLayout:
  //   mobile  < 700   |   tablet 700 - 1099   |   desktop >= 1100
  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isTablet = ResponsiveLayout.isTablet(context);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: tBlue3),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : (isTablet ? 24 : 40),
        vertical: isMobile ? 24 : 25,
      ),
      child: Column(
        children: [
          isMobile ? _mobileTop() : (isTablet ? _tabletTop() : _desktopTop()),

          SizedBox(height: isMobile ? 24 : 30),
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
          isMobile
              ? _mobileBottomBar()
              : (isTablet ? _bottomBar() : _desktopBottomBar()),
        ],
      ),
    );
  }

  Widget _engineeringMenu({bool mobile = false}) => _menu(
    "Engineering",
    [
      "CAD Design",
      "Product Design",
      "Mechanical Engineering",
      "PCB Design",
      "PCB Assembly (PCBA)",
      "Firmware Development",
      "Prototyping",
    ],
    sectionIndex: 1,
    mobile: mobile,
  );

  Widget _manufacturingMenu({bool mobile = false}) => _menu(
    "Manufacturing",
    [
      "Electronics Manufacturing",
      "Product Assembly",
      "Testing & Validation",
      "Quality Assurance",
      "Production Support",
      "Contract Manufacturing",
    ],
    sectionIndex: 2,
    mobile: mobile,
  );

  Widget _productsMenu({bool mobile = false}) => _menu(
    "Products & Solutions",
    [
      "All Products",
      "Telematics",
      "Vehicle Diagnostics",
      "Gateways",
      "Clusters",
      "ADAS",
      "Solution Hub",
    ],
    sectionIndex: 3,
    mobile: mobile,
  );

  Widget _companyMenu({bool mobile = false}) => _menu(
    "Company",
    [
      "About Us",
      "Our Journey",
      "Vision & Mission",
      "Leadership",
      "Careers",
      "Certifications",
      "Contact Us",
    ],
    sectionIndex: 5,
    mobile: mobile,
  );

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
            // _social('icons/facebook.svg'),
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

  // Mobile: everything stacked in one column.
  //   1. logo / about / social icons
  //   2. link menus in a 2 x 2 grid
  //   3. get in touch
  Widget _mobileTop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _leftSection(),
        const SizedBox(height: 28),
        Divider(color: tWhite.withOpacity(0.1), height: 1),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _engineeringMenu(mobile: true)),
            const SizedBox(width: 16),
            Expanded(child: _manufacturingMenu(mobile: true)),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _productsMenu(mobile: true)),
            const SizedBox(width: 16),
            Expanded(child: _companyMenu(mobile: true)),
          ],
        ),
        const SizedBox(height: 14),
        Divider(color: tWhite.withOpacity(0.1), height: 1),
        const SizedBox(height: 24),
        _getInTouch(),
      ],
    );
  }

  // Opens one of the legal pages (each link passes its own page widget).
  // The page is wrapped in a scrollable Scaffold with a back button on top.
  void _openLegalPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 200),
        reverseTransitionDuration: const Duration(milliseconds: 150),
        pageBuilder:
            (routeContext, __, ___) => Scaffold(
              backgroundColor: tWhite,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          color: tBlue3,
                          tooltip: 'Back',
                          onPressed: () => Navigator.of(routeContext).pop(),
                        ),
                      ),
                      page,
                    ],
                  ),
                ),
              ),
            ),
        transitionsBuilder:
            (_, animation, __, child) =>
                FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  // Clickable text used for the legal links in all three bottom bars.
  Widget _legalLink(String text, TextStyle style, Widget page) {
    return Builder(
      builder:
          (context) => MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _openLegalPage(context, page),
              child: Text(text, style: style),
            ),
          ),
    );
  }

  // Privacy Policy | Terms & Conditions | Refund Policy
  // Each link opens its own page. Wraps onto a new line if space is tight.
  Widget _legalLinks(TextStyle style, {double gap = 15}) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 8,
      children: [
        _legalLink("Privacy Policy", style, const PrivacyPolicyPage()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: gap),
          child: Text("|", style: style.copyWith(fontWeight: FontWeight.w600)),
        ),
        _legalLink("Terms & Conditions", style, const TermsConditionPage()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: gap),
          child: Text("|", style: style.copyWith(fontWeight: FontWeight.w600)),
        ),
        _legalLink("Refund Policy", style, const RefundPolicyPage()),
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
        _legalLinks(style),
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
          _legalLinks(style),
        ],
      ),
    );
  }

  // Mobile: copyright on its own line, policy links underneath.
  Widget _mobileBottomBar() {
    final style = GoogleFonts.manrope(
      color: tWhite,
      fontSize: 11.5,
      fontWeight: FontWeight.w500,
      height: 1.4,
    );
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "© ${DateTime.now().year} Trakmate Design Solutions Pvt Ltd. All Rights Reserved.",
            style: style,
          ),
          const SizedBox(height: 10),
          _legalLinks(style, gap: 10),
        ],
      ),
    );
  }

  Widget _menu(
    String title,
    List<String> items, {
    int? sectionIndex,
    bool mobile = false,
  }) {
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

        SizedBox(height: mobile ? 12 : 15),

        ...items.map(
          (e) => Padding(
            // Slightly more space between links on mobile = easier to tap
            padding: EdgeInsets.only(bottom: mobile ? 12 : 10),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Builder(
                builder:
                    (context) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
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
          behavior: HitTestBehavior.opaque,
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
