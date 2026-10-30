import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/utils/colors.dart';
import 'package:trakmate_portal/src/utils/responsive.dart';

// Data classes used by the Terms / Privacy / Refund pages (unchanged)

class LegalBullet {
  final String lead; // optional bold lead-in
  final String text;
  const LegalBullet(this.text, {this.lead = ""});
}

class LegalContactLine {
  final String svgAsset;
  final String text;
  const LegalContactLine(this.svgAsset, this.text);
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

// Full-screen layout
//   top bar (back + title)
//   left menu (Home + sections, fixed)  |  right scrollable content
//
//   Mobile: the left menu becomes a horizontal chip row above the content.

class LegalPageLayout extends StatefulWidget {
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

  @override
  State<LegalPageLayout> createState() => _LegalPageLayoutState();
}

class _LegalPageLayoutState extends State<LegalPageLayout> {
  // 0 = Home (welcome + all sections), 1..n = a single section
  int _selected = 0;
  final GlobalKey _rootKey = GlobalKey();
  double _topOffset = 0; // distance from the top of the screen to this page
  double _lastScreenH = -1;

  void _measureTop() {
    final ctx = _rootKey.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) return;
    final double top = box.localToGlobal(Offset.zero).dy;
    if ((top - _topOffset).abs() > 0.5) {
      setState(() => _topOffset = top < 0 ? 0 : top);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isTablet = ResponsiveLayout.isTablet(context);

    final double screenH = MediaQuery.of(context).size.height;

    // Re-measure on first build and whenever the window height changes.
    if (screenH != _lastScreenH) {
      _lastScreenH = screenH;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _measureTop();
      });
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Bounded height from the parent -> use it.
        // Unbounded (inside a scroll view) -> screen height minus whatever
        // sits above this page (the portal's back-arrow header).
        final double avail = screenH - _topOffset;
        final double height =
            constraints.hasBoundedHeight
                ? constraints.maxHeight
                : (avail < 320 ? 320.0 : avail);

        final Widget page = SizedBox(
          key: _rootKey,
          width: double.infinity,
          height: height,
          child: Container(
            color: tWhite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTopBar(context, isMobile),
                const Divider(height: 1, thickness: 1, color: tBlueMist2),
                if (isMobile) _buildChipMenu(),
                Expanded(
                  child:
                      isMobile
                          ? _buildContent(isMobile, isTablet)
                          : Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                width: isTablet ? 230 : 300,
                                child: _buildSideMenu(isTablet),
                              ),
                              const VerticalDivider(
                                width: 1,
                                thickness: 1,
                                color: tBlueMist2,
                              ),
                              Expanded(
                                child: _buildContent(isMobile, isTablet),
                              ),
                            ],
                          ),
                ),
              ],
            ),
          ),
        );

        // Desktop / tablet: stop wheel scroll from leaking to the parent page.
        // The right panel's own scrollable handles the event first when it can
        // scroll; when it can't (at the top or end), this absorbs it so the
        // whole page (and the left menu) never moves.
        if (isMobile) return page;

        return Listener(
          onPointerSignal: (event) {
            if (event is PointerScrollEvent) {
              GestureBinding.instance.pointerSignalResolver.register(
                event,
                (_) {},
              );
            }
          },
          child: page,
        );
      },
    );
  }

  // TOP BAR  ( <  Title )

  Widget _buildTopBar(BuildContext context, bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 24,
        vertical: isMobile ? 12 : 16,
      ),
      child: Row(
        children: [
          // InkWell(
          //   borderRadius: BorderRadius.circular(20),
          //   onTap: () => Navigator.of(context).maybePop(),
          //   child: const Padding(
          //     padding: EdgeInsets.all(4),
          //     child: Icon(Icons.chevron_left_rounded, size: 28, color: tBlack),
          //   ),
          // ),
          // const SizedBox(width: 6),
          Expanded(
            child: Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.manrope(
                fontSize: isMobile ? 15 : 17,
                fontWeight: FontWeight.w700,
                color: tBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // LEFT MENU (desktop / tablet) - fixed, never scrolls

  List<String> get _menuLabels => [
    "Home",
    ...widget.sections.map((s) => s.title),
  ];

  Widget _buildSideMenu(bool isTablet) {
    final labels = _menuLabels;

    final Widget menu = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < labels.length; i++)
          InkWell(
            onTap: () => setState(() => _selected = i),
            child: Container(
              color: i == _selected ? tGrey1.withOpacity(0.2) : tTransparent,
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
              child: Text(
                labels[i],
                style: GoogleFonts.manrope(
                  fontSize: 15.5,
                  fontWeight:
                      i == _selected ? FontWeight.w700 : FontWeight.w500,
                  color: tBlack,
                ),
              ),
            ),
          ),
      ],
    );

    // Tablet: scrollable menu. Desktop: fixed.
    return isTablet ? SingleChildScrollView(child: menu) : menu;
  }

  // CHIP MENU (mobile)
  Widget _buildChipMenu() {
    final labels = _menuLabels;
    return Container(
      height: 52,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: tBlueMist2)),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        itemCount: labels.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final bool active = i == _selected;
          return GestureDetector(
            onTap: () => setState(() => _selected = i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: active ? tOrange1 : tGrey1.withOpacity(0.2),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                labels[i],
                style: GoogleFonts.manrope(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: active ? tWhite : tBlack,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // RIGHT CONTENT (scrollable)
  Widget _buildContent(bool isMobile, bool isTablet) {
    final TextStyle body = GoogleFonts.manrope(
      fontSize: isMobile ? 13 : 15,
      fontWeight: FontWeight.w500,
      color: tBlackLight,
      height: 1.6,
    );

    final double pad = isMobile ? 16 : (isTablet ? 24 : 32);

    final List<Widget> children = [];

    if (_selected == 0) {
      children.add(_buildWelcomeBox(isMobile));
      for (final s in widget.sections) {
        children.add(const SizedBox(height: 28));
        children.add(_buildSection(s, body, isMobile));
      }
    } else {
      children.add(
        _buildSection(widget.sections[_selected - 1], body, isMobile),
      );
    }

    return SingleChildScrollView(
      key: ValueKey(_selected), // resets scroll position when switching
      padding: EdgeInsets.fromLTRB(pad, pad, pad, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildWelcomeBox(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 14 : 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tOrange1.withOpacity(0.1), tOrange1.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome!",
            style: GoogleFonts.manrope(
              fontSize: isMobile ? 14.5 : 16,
              fontWeight: FontWeight.w800,
              color: tRed,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.subtitle,
            style: GoogleFonts.manrope(
              fontSize: isMobile ? 12.5 : 14,
              fontWeight: FontWeight.w700,
              color: tBlack,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.intro,
            style: GoogleFonts.manrope(
              fontSize: isMobile ? 12.5 : 14,
              fontWeight: FontWeight.w500,
              color: tMuted,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.event_available_rounded,
                size: 14,
                color: tOrange1,
              ),
              const SizedBox(width: 6),
              Text(
                "Effective Date: ${widget.effectiveDate}",
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: tGrey1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(LegalSection s, TextStyle body, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${s.number}. ${s.title}",
          style: GoogleFonts.manrope(
            fontSize: isMobile ? 14.5 : 16.5,
            fontWeight: FontWeight.w800,
            color: tBlack,
          ),
        ),
        const SizedBox(height: 8),
        ...s.paragraphs.map(
          (p) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(p, style: body),
          ),
        ),
        ...s.bullets.map(
          (b) => Padding(
            padding: const EdgeInsets.only(bottom: 6, left: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 9, right: 10),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: tOrange1,
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
                                    color: tBlack,
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
            margin: const EdgeInsets.only(top: 6),
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            decoration: BoxDecoration(
              color: tOrange1.withOpacity(0.07),
              borderRadius: BorderRadius.circular(8),
              border: const Border(left: BorderSide(color: tOrange1, width: 3)),
            ),
            child: Text(
              s.footer,
              style: body.copyWith(fontWeight: FontWeight.w600, color: tBlack),
            ),
          ),
        if (s.contacts.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  s.contacts
                      .map(
                        (c) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 3,
                                  right: 10,
                                ),
                                child: SvgPicture.asset(
                                  c.svgAsset,
                                  width: 16,
                                  height: 16,
                                  // Remove colorFilter if you want the SVG's original colors
                                  colorFilter: const ColorFilter.mode(
                                    tOrange1,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SelectableText(
                                  c.text,
                                  style: body.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
      ],
    );
  }
}
