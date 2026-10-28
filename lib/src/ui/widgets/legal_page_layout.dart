import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trakmate_portal/src/utils/colors.dart';
import 'package:trakmate_portal/src/utils/responsive.dart';

// =============================================================================
// Data classes used by the Terms / Privacy / Refund pages
// =============================================================================

class LegalBullet {
  final String lead; // optional bold lead-in
  final String text;
  const LegalBullet(this.text, {this.lead = ""});
}

class LegalContactLine {
  final IconData icon;
  final String text;
  const LegalContactLine(this.icon, this.text);
}

class LegalSection {
  final String number;
  final String title;
  final List<String> paragraphs;
  final List<LegalBullet> bullets;
  final String footer;
  final List<LegalContactLine> contacts;

  const LegalSection({
    required this.number,
    required this.title,
    this.paragraphs = const [],
    this.bullets = const [],
    this.footer = "",
    this.contacts = const [],
  });
}

// =============================================================================
// Shared full-width layout
//   slim header band -> sections in rows of two (1 | 2, 3 | 4, ...)
//   Both cards in a row always have the same height, so there are no gaps.
//   A last, unpaired section spans the full width.
// =============================================================================

class LegalPageLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final String effectiveDate;
  final String intro;
  final List<LegalSection> sections;

  const LegalPageLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.effectiveDate,
    required this.intro,
    required this.sections,
  });

  static const List<Color> _accents = [tOrange1, tBlue3];

  // Breakpoints come from ResponsiveLayout:
  //   mobile  < 700   |   tablet 700 - 1099   |   desktop >= 1100
  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isTablet = ResponsiveLayout.isTablet(context);
    final double hPad = isMobile ? 16 : (isTablet ? 24 : 40);

    return Container(
      width: double.infinity,
      color: const Color(0xFFF6F8FC),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(isMobile, hPad),
          Padding(
            padding: EdgeInsets.fromLTRB(hPad, isMobile ? 16 : 22, hPad, 32),
            child: _buildBody(isMobile),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HEADER BAND
  // ---------------------------------------------------------------------------
  Widget _buildHeader(bool isMobile, double hPad) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        hPad,
        isMobile ? 18 : 24,
        hPad,
        isMobile ? 20 : 26,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [tBlue2, tBlue3],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "LEGAL",
            style: GoogleFonts.manrope(
              fontSize: isMobile ? 11.5 : 12.5,
              fontWeight: FontWeight.w700,
              color: tOrange1,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: isMobile ? 22 : 30,
              fontWeight: FontWeight.w800,
              color: tWhite,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.event_available_rounded,
                size: 14,
                color: tWhite.withOpacity(0.8),
              ),
              const SizedBox(width: 6),
              Text(
                "Effective Date: $effectiveDate",
                style: GoogleFonts.manrope(
                  fontSize: isMobile ? 11.5 : 12.5,
                  fontWeight: FontWeight.w600,
                  color: tWhite.withOpacity(0.85),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            intro,
            style: GoogleFonts.manrope(
              fontSize: isMobile ? 12.5 : 13.5,
              fontWeight: FontWeight.w500,
              color: tWhite.withOpacity(0.9),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // BODY
  //   mobile : one card per row
  //   others : two cards per row, equal height (1 | 2, 3 | 4, ...)
  //            the last card spans the full width when it has no partner
  // ---------------------------------------------------------------------------
  Widget _buildBody(bool isMobile) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < sections.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildCard(sections[i], i, isMobile: true, wide: false),
            ),
        ],
      );
    }

    final List<Widget> rows = [];
    for (int i = 0; i < sections.length; i += 2) {
      final bool hasPair = i + 1 < sections.length;

      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child:
              hasPair
                  ? IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: _buildCard(
                            sections[i],
                            i,
                            isMobile: false,
                            wide: false,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildCard(
                            sections[i + 1],
                            i + 1,
                            isMobile: false,
                            wide: false,
                          ),
                        ),
                      ],
                    ),
                  )
                  // Unpaired last section: full width, no empty half
                  : _buildCard(sections[i], i, isMobile: false, wide: true),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION CARD
  // ---------------------------------------------------------------------------
  TextStyle _bodyStyle(bool isMobile) => GoogleFonts.manrope(
    fontSize: isMobile ? 12.5 : 13.5,
    fontWeight: FontWeight.w500,
    color: tBlack,
    height: 1.65,
  );

  Widget _buildCard(
    LegalSection s,
    int index, {
    required bool isMobile,
    required bool wide,
  }) {
    final Color accent = _accents[index % _accents.length];
    final TextStyle body = _bodyStyle(isMobile);

    return Container(
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tBlue3.withOpacity(0.08), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: tBlue3.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [accent, accent.withOpacity(0.3)],
              ),
            ),
          ),
          // Header band: soft tint behind the heading
          Container(
            color: accent.withOpacity(0.05),
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 14 : 18,
              vertical: isMobile ? 10 : 12,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(
                    child: Text(
                      s.number,
                      style: GoogleFonts.manrope(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        color: tWhite,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    s.title,
                    style: GoogleFonts.manrope(
                      fontSize: isMobile ? 14.5 : 15.5,
                      fontWeight: FontWeight.w700,
                      color: tBlue2,
                      height: 1.25,
                    ),
                  ),
                ),
                Text(
                  s.number.padLeft(2, '0'),
                  style: GoogleFonts.manrope(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: accent.withOpacity(0.16),
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          // Content (the card itself is stretched to the row height by the Row)
          Padding(
            padding: EdgeInsets.fromLTRB(
              isMobile ? 14 : 18,
              isMobile ? 12 : 14,
              isMobile ? 14 : 18,
              isMobile ? 12 : 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...s.paragraphs.map(
                  (p) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(p, style: body),
                  ),
                ),
                ...s.bullets.map(
                  (b) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8, right: 10),
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: accent,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Expanded(
                          child:
                              b.lead.isEmpty
                                  ? Text(b.text, style: body)
                                  : Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "${b.lead}: ",
                                          style: body.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: tBlue2,
                                          ),
                                        ),
                                        TextSpan(text: b.text, style: body),
                                      ],
                                    ),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (s.footer.isNotEmpty)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.07),
                      borderRadius: BorderRadius.circular(8),
                      border: Border(left: BorderSide(color: accent, width: 3)),
                    ),
                    child: Text(
                      s.footer,
                      style: body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: tBlue2,
                      ),
                    ),
                  ),
                if (s.contacts.isNotEmpty)
                  _buildContacts(s, accent, body, wide),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Contact lines: stacked inside a half-width card, side by side when the
  // card spans the full width (so the last section doesn't look empty).
  Widget _buildContacts(
    LegalSection s,
    Color accent,
    TextStyle body,
    bool wide,
  ) {
    Widget line(LegalContactLine c) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3, right: 10),
            child: Icon(c.icon, size: 16, color: accent),
          ),
          Flexible(
            child: SelectableText(
              c.text,
              style: body.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      );
    }

    if (wide) {
      return Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Wrap(
          spacing: 36,
          runSpacing: 10,
          children: s.contacts.map(line).toList(),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          s.contacts
              .map(
                (c) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: line(c),
                ),
              )
              .toList(),
    );
  }
}
