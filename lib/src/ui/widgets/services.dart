import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trakmate_portal/src/utils/colors.dart';

class Marketing3PWidget extends StatelessWidget {
  const Marketing3PWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),

        Text(
          'OUR SERVICES',
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFFFA300),
            letterSpacing: 1.2,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          'Complete Solutions Under One Roof',
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF142735),
          ),
        ),

        // const SizedBox(height: 5),

        // Existing design
        LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: 1724 / 889,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: 1724,
                    height: 889,
                    child: CustomPaint(painter: _Marketing3PPainter()),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _Marketing3PPainter extends CustomPainter {
  static const Color background = Color(0xFF142735);
  static const Color white = Colors.white;

  static const Color product = Color(0xFFFFA300);
  static const Color price = Color(0xFFFF1230);
  static const Color promotion = Color(0xFF45C96B);

  final Paint _paint = Paint()..isAntiAlias = true;

  // ---------------------------------------------------------------------------
  // PAINT
  // ---------------------------------------------------------------------------

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawRect(Offset.zero & size, Paint()..color = background);

    // _drawHeader(canvas);

    // Connections must be behind the circles
    _drawConnections(canvas);

    // LEFT SIDE
    _drawProductCard(
      canvas,
      x: 123,
      y: 320,
      title: 'Product',
      color: tOrange1,
      icon: Icons.inventory_2_outlined,
      description:
          'Lorem ipsum dolor sit ametera\n'
          'consectetuer adipiscing elititas\n'
          'esed diam nonummy nibh emi\n'
          'volutpat. Ut wisi enim ad diape\n'
          'minim veniam quisi',
    );

    _drawProductCard(
      canvas,
      x: 123,
      y: 513,
      title: 'Product',
      color: tBlue,
      icon: Icons.inventory_2_outlined,
      description:
          'Lorem ipsum dolor sit ametera\n'
          'consectetuer adipiscing elititas\n'
          'esed diam nonummy nibh emi\n'
          'volutpat. Ut wisi enim ad diape\n'
          'minim veniam quisi',
    );

    _drawProductCard(
      canvas,
      x: 123,
      y: 708,
      title: 'Price',
      color: price,
      icon: Icons.attach_money,
      description:
          'Lorem ipsum dolor sit ametera\n'
          'consectetuer adipiscing elititas\n'
          'esed diam nonummy nibh emi\n'
          'volutpat. Ut wisi enim ad diape\n'
          'minim veniam quisi',
    );

    // RIGHT SIDE
    _drawRightCard(
      canvas,
      x: 1137,
      y: 142,
      title: 'Price',
      color: price,
      icon: Icons.attach_money,
      description:
          'Lorem ipsum dolor sit ametera\n'
          'consectetuer adipiscing elititas\n'
          'esed diam nonummy nibh emi\n'
          'volutpat. Ut wisi enim ad diape\n'
          'minim veniam quisi',
    );

    _drawRightCard(
      canvas,
      x: 1199,
      y: 421,
      title: 'Promotion',
      color: promotion,
      icon: Icons.campaign_outlined,
      description:
          'Lorem ipsum dolor sit ametera\n'
          'consectetuer adipiscing elititas\n'
          'esed diam nonummy nibh emi\n'
          'volutpat. Ut wisi enim ad diape\n'
          'minim veniam quisi',
    );

    _drawRightCard(
      canvas,
      x: 1199,
      y: 661,
      title: 'Promotion',
      color: promotion,
      icon: Icons.campaign_outlined,
      description:
          'Lorem ipsum dolor sit ametera\n'
          'consectetuer adipiscing elititas\n'
          'esed diam nonummy nibh emi\n'
          'volutpat. Ut wisi enim ad diape\n'
          'minim veniam quisi',
    );

    // CENTER NODES
    _drawNode(
      canvas,
      center: const Offset(676, 389),
      radius: 59,
      color: tBlue.withOpacity(0.3),
    );

    _drawNode(
      canvas,
      center: const Offset(677, 557),
      radius: 59,
      color: tOrange1.withOpacity(0.6),
    );

    _drawNode(
      canvas,
      center: const Offset(617, 770),
      radius: 62,
      color: price.withOpacity(0.3),
    );

    _drawNode(
      canvas,
      center: const Offset(990, 221),
      radius: 59,
      color: tGreen.withOpacity(0.3),
    );

    _drawNode(
      canvas,
      center: const Offset(1047, 524),
      radius: 61,
      color: ipbadge.withOpacity(0.3),
    );

    _drawNode(
      canvas,
      center: const Offset(1038, 715),
      radius: 61,
      color: tBlueSky.withOpacity(0.3),
    );

    // ARROWS
    // _drawTriangle(canvas, center: const Offset(570, 390), color: product);

    // _drawTriangle(canvas, center: const Offset(570, 574), color: product);

    // _drawTriangle(canvas, center: const Offset(520, 773), color: price);

    // _drawTriangle(canvas, center: const Offset(1094, 220), color: price);

    // _drawTriangle(canvas, center: const Offset(1154, 518), color: promotion);

    // _drawTriangle(canvas, center: const Offset(1154, 719), color: promotion);
  }

  // ---------------------------------------------------------------------------
  // HEADER
  // ---------------------------------------------------------------------------

  void _drawHeader(Canvas canvas) {
    _drawText(
      canvas,
      '3P’s of Marketing',
      const Offset(137, 48),
      fontSize: 39,
      fontWeight: FontWeight.w700,
      color: background,
    );

    canvas.drawLine(
      const Offset(497, 69),
      const Offset(1587, 69),
      Paint()
        ..color = background
        ..strokeWidth = 5,
    );
  }

  // ---------------------------------------------------------------------------
  // CONNECTION LINES
  // ---------------------------------------------------------------------------

  void _drawConnections(Canvas canvas) {
    final paint =
        Paint()
          ..color = background
          ..strokeWidth = 2.5
          ..style = PaintingStyle.stroke;

    canvas.drawLine(
      const Offset(731, 370),
      const Offset(938, 249),
      paint,
    ); //here
    canvas.drawLine(const Offset(1000, 280), const Offset(1020, 469), paint);
    canvas.drawLine(const Offset(735, 397), const Offset(991, 500), paint);

    // canvas.drawLine(const Offset(676, 389), const Offset(677, 557), paint);

    canvas.drawLine(const Offset(660, 614), const Offset(639, 712), paint);

    canvas.drawLine(const Offset(677, 557), const Offset(995, 670), paint);

    canvas.drawLine(const Offset(617, 770), const Offset(1038, 715), paint);
  }

  // ---------------------------------------------------------------------------
  // NODE
  // ---------------------------------------------------------------------------

  void _drawNode(
    Canvas canvas, {
    required Offset center,
    required double radius,
    required Color color,
  }) {
    final glow =
        Paint()
          ..color = color.withOpacity(.20)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);

    canvas.drawCircle(center, radius + 5, glow);

    canvas.drawCircle(center, radius, Paint()..color = color);

    canvas.drawCircle(
      center,
      radius - 14,
      Paint()
        ..color = white
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke,
    );

    _drawCenteredText(
      canvas,
      'P',
      center,
      fontSize: radius * .55,
      fontWeight: FontWeight.w700,
      color: background,
    );
    _drawCenteredText(
      canvas,
      'R',
      center,
      fontSize: radius * .55,
      fontWeight: FontWeight.w700,
      color: background,
    );
  }

  // ---------------------------------------------------------------------------
  // TRIANGLE
  // ---------------------------------------------------------------------------

  void _drawTriangle(
    Canvas canvas, {
    required Offset center,
    required Color color,
  }) {
    final path = Path();

    path.moveTo(center.dx - 22, center.dy - 23);

    path.lineTo(center.dx + 22, center.dy);

    path.lineTo(center.dx - 22, center.dy + 23);

    path.close();

    canvas.drawPath(path, Paint()..color = color);
  }

  // ---------------------------------------------------------------------------
  // LEFT CARD
  // ---------------------------------------------------------------------------

  void _drawProductCard(
    Canvas canvas, {
    required double x,
    required double y,
    required String title,
    required Color color,
    required IconData icon,
    required String description,
  }) {
    final linePaint =
        Paint()
          ..color = color
          ..strokeWidth = 2;

    canvas.drawLine(Offset(x, y), Offset(x + 404, y), linePaint);

    canvas.drawLine(Offset(x, y + 157), Offset(x + 404, y + 157), linePaint);

    _drawIcon(
      canvas,
      icon,
      Offset(x + 87, y + 70),
      color: background,
      size: 65,
    );

    _drawText(
      canvas,
      title,
      Offset(x + 284, y + 26),
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: color,
      align: TextAlign.center,
    );

    _drawText(
      canvas,
      description,
      Offset(x + 177, y + 57),
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: background,
      align: TextAlign.center,
      width: 220,
      lineHeight: 1.15,
    );
  }

  // ---------------------------------------------------------------------------
  // RIGHT CARD
  // ---------------------------------------------------------------------------

  void _drawRightCard(
    Canvas canvas, {
    required double x,
    required double y,
    required String title,
    required Color color,
    required IconData icon,
    required String description,
  }) {
    final linePaint =
        Paint()
          ..color = color
          ..strokeWidth = 2;

    canvas.drawLine(Offset(x, y), Offset(x + 407, y), linePaint);

    canvas.drawLine(Offset(x, y + 168), Offset(x + 407, y + 168), linePaint);

    _drawText(
      canvas,
      title,
      Offset(x + 18, y + 26),
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: color,
    );

    _drawText(
      canvas,
      description,
      Offset(x + 18, y + 62),
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: background,
      width: 245,
      lineHeight: 1.15,
    );

    _drawIcon(canvas, icon, Offset(x + 325, y + 84), color: tBlack, size: 62);
  }

  // ---------------------------------------------------------------------------
  // ICON
  // ---------------------------------------------------------------------------

  void _drawIcon(
    Canvas canvas,
    IconData icon,
    Offset center, {
    required Color color,
    required double size,
  }) {
    final painter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          fontSize: size,
          color: color,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    painter.layout();

    painter.paint(
      canvas,
      Offset(center.dx - painter.width / 2, center.dy - painter.height / 2),
    );
  }

  // ---------------------------------------------------------------------------
  // TEXT
  // ---------------------------------------------------------------------------

  void _drawText(
    Canvas canvas,
    String text,
    Offset offset, {
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    TextAlign align = TextAlign.left,
    double? width,
    double lineHeight = 1,
  }) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          height: lineHeight,
          fontFamily: 'Arial',
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: align,
    );

    painter.layout(minWidth: width ?? 0, maxWidth: width ?? double.infinity);

    painter.paint(canvas, offset);
  }

  // ---------------------------------------------------------------------------
  // CENTER TEXT
  // ---------------------------------------------------------------------------

  void _drawCenteredText(
    Canvas canvas,
    String text,
    Offset center, {
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
  }) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          fontFamily: 'Arial',
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    painter.layout();

    painter.paint(
      canvas,
      Offset(center.dx - painter.width / 2, center.dy - painter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
