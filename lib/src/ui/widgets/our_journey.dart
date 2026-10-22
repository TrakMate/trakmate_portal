import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:trakmate_portal/src/utils/colors.dart';
import 'package:trakmate_portal/src/utils/responsive.dart';

class _JourneyItem {
  final String year;
  final String title;
  final String description;
  final String icon;

  const _JourneyItem({
    required this.year,
    required this.title,
    required this.description,
    required this.icon,
  });
}

const List<_JourneyItem> _journeyItems = [
  _JourneyItem(
    year: '2013',
    title: 'The Beginning',
    description: 'TrakMate was founded with a vision to innovate',
    icon: 'icons/innovation.svg',
  ),
  _JourneyItem(
    year: '2016',
    title: 'Expanding Solutions',
    description: 'Launched IoT products and embedded solutions',
    icon: 'icons/manufacture.svg',
  ),
  _JourneyItem(
    year: '2019',
    title: 'Global Growth',
    description:
        'Expanded into international markets and built strong partnerships',
    icon: 'icons/globe.svg',
  ),
  _JourneyItem(
    year: 'Today',
    title: 'Shaping the Future',
    description: 'Continuously innovating to build a smarter, connected world',
    icon: 'icons/collaboration.svg',
  ),
];

/// "Our Journey" section.
/// Desktop = zig-zag horizontal timeline
/// Tablet  = the same zig-zag rotated to vertical
/// Mobile  = single-column timeline (line on the left, cards on the right)
class OurJourneySection extends StatelessWidget {
  const OurJourneySection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isTablet = ResponsiveLayout.isTablet(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'OUR JOURNEY',
          style: GoogleFonts.manrope(
            color: tOrange1,
            fontSize: isMobile ? 12 : 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          'Milestones That Shaped Our Journey.',
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            color: tBlue2,
            fontSize: isMobile ? 20 : 25,
            fontWeight: FontWeight.w700,
            height: 1.15,
          ),
        ),
        SizedBox(height: isMobile ? 22 : 25),
        if (isMobile)
          const _MobileTimeline(items: _journeyItems)
        else if (isTablet)
          const _VerticalTimeline(items: _journeyItems)
        else
          const _HorizontalTimeline(items: _journeyItems),
        const SizedBox(height: 5),
      ],
    );
  }
}

// =====================================================================
//                         DESKTOP: HORIZONTAL
// =====================================================================

class _HorizontalTimeline extends StatelessWidget {
  final List<_JourneyItem> items;
  const _HorizontalTimeline({required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double w = constraints.maxWidth;

          const double cardH = 104;
          const double pointerH = 10;
          const double nodeSize = 30;
          const double cardWidthFactor = 0.27;
          const double stepFactor = 0.17;
          const double totalSpan = stepFactor * 3 + cardWidthFactor;
          const double startFactor = (1 - totalSpan) / 2;
          const double lineY = cardH + pointerH + nodeSize / 2;

          final List<Widget> children = [
            // timeline line
            Positioned(
              left: 150,
              right: 150,
              top: lineY - 2.5,
              child: Container(
                height: 5,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [tWhite, tBlue1, tBlue, tBlue1, tWhite],
                    stops: [0.0, 0.18, 0.50, 0.82, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: tBlue.withOpacity(0.35),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
          ];

          // cards
          for (int i = 0; i < items.length; i++) {
            final bool isAbove = i.isEven;
            children.add(
              Positioned(
                left: w * (startFactor + stepFactor * i),
                width: w * cardWidthFactor,
                top: isAbove ? 0 : lineY + nodeSize / 2 + pointerH,
                child: _JourneyCard(
                  item: items[i],
                  cardHeight: cardH,
                  pointer: isAbove ? _PointerDir.down : _PointerDir.up,
                  pointerHeight: pointerH,
                ),
              ),
            );
          }

          // nodes
          for (int i = 0; i < items.length; i++) {
            final double centerX =
                w * (startFactor + stepFactor * i + cardWidthFactor / 2);
            children.add(
              Positioned(
                left: centerX - nodeSize / 2,
                top: lineY - nodeSize / 2,
                child: const _JourneyNode(size: nodeSize),
              ),
            );
          }

          return Stack(clipBehavior: Clip.none, children: children);
        },
      ),
    );
  }
}

// =====================================================================
//                    TABLET: VERTICAL (rotated zig-zag)
// =====================================================================
class _VerticalTimeline extends StatelessWidget {
  final List<_JourneyItem> items;
  const _VerticalTimeline({required this.items});

  @override
  Widget build(BuildContext context) {
    // same constants as desktop, just rotated
    const double cardH = 104;
    const double pointerH = 10;
    const double nodeSize = 30;
    const double stepY = 104; // vertical distance between cards

    final double totalH = stepY * (items.length - 1) + cardH;

    return SizedBox(
      width: double.infinity,
      height: totalH,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double w = constraints.maxWidth;
          final double centerX = w / 2;
          // card edge sits `pointerH` away from the node edge (same as desktop)
          final double cardW = centerX - nodeSize / 2 - pointerH;

          final List<Widget> children = [
            // vertical timeline line (fades at both ends, like desktop)
            Positioned(
              top: cardH / 2,
              bottom: cardH / 2,
              left: centerX - 2.5,
              child: Container(
                width: 5,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [tWhite, tBlue1, tBlue, tBlue1, tWhite],
                    stops: [0.0, 0.18, 0.50, 0.82, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: tBlue.withOpacity(0.35),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
          ];

          // cards: even = left of the line, odd = right of the line
          for (int i = 0; i < items.length; i++) {
            final bool isLeft = i.isEven;
            children.add(
              Positioned(
                top: stepY * i,
                left: isLeft ? 0 : centerX + nodeSize / 2 + pointerH,
                width: cardW,
                child: _JourneyCard(
                  item: items[i],
                  cardHeight: cardH,
                  pointer: isLeft ? _PointerDir.right : _PointerDir.left,
                  pointerHeight: pointerH,
                ),
              ),
            );
          }

          // nodes (drawn last, centered on the line, level with each card)
          for (int i = 0; i < items.length; i++) {
            children.add(
              Positioned(
                left: centerX - nodeSize / 2,
                top: stepY * i + cardH / 2 - nodeSize / 2,
                child: const _JourneyNode(size: nodeSize),
              ),
            );
          }

          return Stack(clipBehavior: Clip.none, children: children);
        },
      ),
    );
  }
}

// =====================================================================
//                    MOBILE: SINGLE COLUMN TIMELINE
// =====================================================================
class _MobileTimeline extends StatelessWidget {
  final List<_JourneyItem> items;
  const _MobileTimeline({required this.items});

  @override
  Widget build(BuildContext context) {
    const double cardH = 112;
    const double pointerH = 10;
    const double nodeSize = 26;
    const double gap = 18;
    const double leftCol = 40; // space on the left for the line + nodes
    const double nodeCenterX = 14;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // vertical line (from first node centre to last node centre)
        Positioned(
          top: cardH / 2,
          bottom: cardH / 2,
          left: nodeCenterX - 2.5,
          child: Container(
            width: 5,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [tBlue1, tBlue, tBlue1],
                stops: [0.0, 0.5, 1.0],
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: tBlue.withOpacity(0.30),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ),

        // cards
        Column(
          children: [
            for (int i = 0; i < items.length; i++)
              Padding(
                padding: EdgeInsets.only(
                  left: leftCol,
                  bottom: i == items.length - 1 ? 0 : gap,
                ),
                child: _JourneyCard(
                  item: items[i],
                  cardHeight: cardH,
                  pointer: _PointerDir.left,
                  pointerHeight: pointerH,
                  iconSize: 52,
                ),
              ),
          ],
        ),

        // nodes (drawn last, level with the middle of each card)
        for (int i = 0; i < items.length; i++)
          Positioned(
            left: nodeCenterX - nodeSize / 2,
            top: (cardH + gap) * i + cardH / 2 - nodeSize / 2,
            child: const _JourneyNode(size: nodeSize),
          ),
      ],
    );
  }
}

// =====================================================================
//                            SHARED PIECES
// =====================================================================
enum _PointerDir { none, up, down, left, right }

class _JourneyCard extends StatelessWidget {
  final _JourneyItem item;
  final double? cardHeight;
  final _PointerDir pointer;
  final double pointerHeight;
  final double iconSize;

  const _JourneyCard({
    required this.item,
    this.cardHeight,
    this.pointer = _PointerDir.none,
    this.pointerHeight = 0,
    this.iconSize = 70,
  });

  @override
  Widget build(BuildContext context) {
    const Color cardColor = Color(0xFFF8FBFF);
    final bool small = iconSize < 70;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: cardHeight,
          padding: EdgeInsets.symmetric(
            horizontal: small ? 12 : 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFB9D9FF).withOpacity(0.65),
              width: 1.4,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF66AFFF).withOpacity(0.18),
                blurRadius: 20,
                spreadRadius: 1,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                color: const Color(0xFF4C9AFF).withOpacity(0.10),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const RadialGradient(
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFF1F7FF),
                      Color(0xFFE6F1FF),
                    ],
                    stops: [0.0, 0.65, 1.0],
                  ),
                  border: Border.all(
                    color: const Color(0xFFD4E9FF),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5B9CFF).withOpacity(0.16),
                      blurRadius: small ? 10 : 15,
                      spreadRadius: small ? 1 : 3,
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.9),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Container(
                  margin: EdgeInsets.all(small ? 5 : 6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFF7FBFF),
                    border: Border.all(
                      color: const Color(0xFFE0EEFF),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      item.icon,
                      width: small ? 26 : 36,
                      height: small ? 26 : 36,
                      fit: BoxFit.contain,
                      color: const Color(0xFF2474EA),
                    ),
                  ),
                ),
              ),
              SizedBox(width: small ? 12 : 13),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: small ? 0 : 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.year,
                        style: GoogleFonts.manrope(
                          color: const Color(0xFF1263E8),
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.manrope(
                          color: const Color(0xFF10284E),
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.manrope(
                          color: const Color(0xFF617797),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // pointer above / below the card (desktop)
        if (pointer == _PointerDir.up || pointer == _PointerDir.down)
          Positioned(
            left: 0,
            right: 0,
            top: pointer == _PointerDir.up ? -(pointerHeight - 1.5) : null,
            bottom: pointer == _PointerDir.down ? -(pointerHeight - 1.5) : null,
            child: Center(
              child: CustomPaint(
                size: Size(30, pointerHeight),
                painter: _PointerPainter(dir: pointer, fillColor: cardColor),
              ),
            ),
          ),

        // pointer left / right of the card (tablet + mobile)
        if (pointer == _PointerDir.left || pointer == _PointerDir.right)
          Positioned(
            top: 0,
            bottom: 0,
            left: pointer == _PointerDir.left ? -(pointerHeight - 1.5) : null,
            right: pointer == _PointerDir.right ? -(pointerHeight - 1.5) : null,
            child: Center(
              child: CustomPaint(
                size: Size(pointerHeight, 30),
                painter: _PointerPainter(dir: pointer, fillColor: cardColor),
              ),
            ),
          ),
      ],
    );
  }
}

class _JourneyNode extends StatelessWidget {
  final double size;
  const _JourneyNode({this.size = 34});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFF7FBFF),
        border: Border.all(color: const Color(0xFFA8CFFF), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3C8DFF).withOpacity(0.25),
            blurRadius: 14,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: size - 12,
          height: size - 12,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [Color(0xFF3488FF), Color(0xFF1263E8)],
            ),
          ),
        ),
      ),
    );
  }
}

class _PointerPainter extends CustomPainter {
  final _PointerDir dir;
  final Color fillColor;

  _PointerPainter({required this.dir, required this.fillColor});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint = Paint()..color = fillColor;
    final Paint borderPaint =
        Paint()
          ..color = const Color(0xFF8FC0FF)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.6
          ..strokeJoin = StrokeJoin.round;

    final double w = size.width;
    final double h = size.height;
    final Path fill = Path();
    final Path edge = Path();

    switch (dir) {
      case _PointerDir.down: // card above, arrow points down
        fill
          ..moveTo(0, 0)
          ..lineTo(w, 0)
          ..lineTo(w / 2, h)
          ..close();
        edge
          ..moveTo(0, 0)
          ..lineTo(w / 2, h)
          ..lineTo(w, 0);
        break;
      case _PointerDir.up: // card below, arrow points up
        fill
          ..moveTo(0, h)
          ..lineTo(w, h)
          ..lineTo(w / 2, 0)
          ..close();
        edge
          ..moveTo(0, h)
          ..lineTo(w / 2, 0)
          ..lineTo(w, h);
        break;
      case _PointerDir.right: // card on the left, arrow points right
        fill
          ..moveTo(0, 0)
          ..lineTo(0, h)
          ..lineTo(w, h / 2)
          ..close();
        edge
          ..moveTo(0, 0)
          ..lineTo(w, h / 2)
          ..lineTo(0, h);
        break;
      case _PointerDir.left: // card on the right, arrow points left
        fill
          ..moveTo(w, 0)
          ..lineTo(w, h)
          ..lineTo(0, h / 2)
          ..close();
        edge
          ..moveTo(w, 0)
          ..lineTo(0, h / 2)
          ..lineTo(w, h);
        break;
      case _PointerDir.none:
        return;
    }

    canvas.drawPath(fill, fillPaint);
    canvas.drawPath(edge, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _PointerPainter old) =>
      old.dir != dir || old.fillColor != fillColor;
}
