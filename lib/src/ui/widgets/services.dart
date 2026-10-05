import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/utils/colors.dart';

const double _topCrop = 90; // how much empty space to remove from the top

class Marketing3PWidget extends StatefulWidget {
  const Marketing3PWidget({super.key});

  @override
  State<Marketing3PWidget> createState() => _Marketing3PWidgetState();
}

class _Marketing3PWidgetState extends State<Marketing3PWidget> {
  static const _svgPaths = [
    'icons/product_engineering.svg',
    'icons/electronics_design.svg',
    'icons/embedded_systems.svg',
    'icons/iot_solutions.svg',
    'icons/software_solutions.svg',
    'icons/manufacturing.svg',
  ];

  final Map<String, PictureInfo> _svgs = {};

  @override
  void initState() {
    super.initState();
    _loadSvgs();
  }

  Future<void> _loadSvgs() async {
    for (final p in _svgPaths) {
      _svgs[p] = await vg.loadPicture(SvgAssetLoader(p), null);
    }
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    for (final i in _svgs.values) {
      i.picture.dispose();
    }
    super.dispose();
  }

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
            color: tOrange1,
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
            color: tBlue2,
          ),
        ),

        // const SizedBox(height: 5),

        // Existing design
        // LayoutBuilder(
        //   builder: (context, constraints) {
        //     return SizedBox(
        //       width: double.infinity,
        //       child: AspectRatio(

        //         aspectRatio: 1724 / 889,
        //         child: FittedBox(
        //           fit: BoxFit.contain,
        //           child: SizedBox(
        //             width: 1724,
        //             height: 889,
        //             child: CustomPaint(
        //               painter: _Marketing3PPainter(svgs: _svgs),
        //             ),
        //           ),
        //         ),
        //       ),
        //     );
        //   },
        // ),
        LayoutBuilder(
          builder: (context, constraints) {
            return ClipRect(
              child: Align(
                alignment: Alignment.bottomCenter,
                heightFactor: (889 - _topCrop) / 889,
                child: AspectRatio(
                  aspectRatio: 1724 / 889,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: SizedBox(
                      width: 1724,
                      height: 889,
                      child: CustomPaint(
                        painter: _Marketing3PPainter(svgs: _svgs),
                      ),
                    ),
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
  static const Color white = Colors.white;
  // final Paint _paint = Paint()..isAntiAlias = true;
  final Map<String, PictureInfo> svgs;

  _Marketing3PPainter({required this.svgs});
  // PAINT

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawRect(Offset.zero & size, Paint()..color = background);

    // _drawHeader(canvas);

    // Connections must be behind the circles
    _drawConnections(canvas);

    // LEFT SIDE
    _drawProductCard(
      canvas,
      x: 165, //block left/right
      y: 210, //block up/down
      title: 'Product Engineering',
      color: tBlue,
      svg: 'icons/product_engineering.svg',
      points: ['CAD Design', 'Industrial Design', 'Product Development'],
    );

    _drawProductCard(
      canvas,
      x: 133,
      y: 480,
      title: 'Electroinics Design',
      color: tOrange1,
      svg: 'icons/electronics_design.svg',
      points: ['PCB Design', 'Prototype Development', 'Hardware Development'],
    );

    _drawProductCard(
      canvas,
      x: 123,
      y: 708,
      title: 'Software Solutions',
      color: tRed,
      svg: 'icons/embedded_systems.svg',

      points: ['Web Applications', 'Mobile Apps', 'APIs & Integrations'],
    );

    // RIGHT SIDE
    _drawRightCard(
      canvas,
      x: 1137,
      y: 142,
      title: 'IOT Solutions',
      color: tGreen,
      svg: 'icons/iot_solutions.svg',
      points: ['GPS/BLE/WIFI/LoRa', 'Cloud Integration', 'MQTT & Analysis'],
    );

    _drawRightCard(
      canvas,
      x: 1199,
      y: 421,
      title: 'Embedded Systems',
      color: ipbadge,
      svg: 'icons/software_solutions.svg',
      points: ['Firmware Development', 'RTOS / Linux', 'Testing & Validation'],
    );

    _drawRightCard(
      canvas,
      x: 1160,
      y: 661,
      title: 'Manufacturing',
      color: tBlueSky,
      svg: 'icons/manufacturing.svg',
      points: ['PCB Assembly (PCBA)', 'Testing & Quality', 'Mass Production'],
    );

    // CENTER NODES
    _drawNode(
      canvas,
      center: const Offset(676, 389),
      radius: 59,
      color: tBlue.withOpacity(0.3), //here
      label: 'P',
    );

    _drawNode(
      canvas,
      center: const Offset(637, 547),
      radius: 59,
      color: tOrange1.withOpacity(0.6),
      label: 'E',
    );

    _drawNode(
      canvas,
      // center: const Offset(677, 815),
      center: const Offset(700, 815),
      radius: 62,
      color: tRed.withOpacity(0.3),
      label: 'S',
    );

    _drawNode(
      canvas,
      center: const Offset(990, 221),
      radius: 59,
      color: tGreen.withOpacity(0.3),
      label: 'I',
    );

    _drawNode(
      canvas,
      center: const Offset(1047, 524),
      radius: 61,
      color: ipbadge.withOpacity(0.3),
      label: 'E',
    );

    _drawNode(
      canvas,
      center: const Offset(1000, 695),
      radius: 61,
      color: tBlueSky.withOpacity(0.3),
      label: 'M',
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

  // void _drawHeader(Canvas canvas) {
  //   _drawText(
  //     canvas,
  //     '3P’s of Marketing',
  //     const Offset(137, 48),
  //     fontSize: 39,
  //     fontWeight: FontWeight.w700,
  //     color: background,
  //   );

  //   canvas.drawLine(
  //     const Offset(497, 69),
  //     const Offset(1587, 69),
  //     Paint()
  //       ..color = background
  //       ..strokeWidth = 5,
  //   );
  // }

  // ---------------------------------------------------------------------------
  // CONNECTION LINES
  // ---------------------------------------------------------------------------

  void _drawConnections(Canvas canvas) {
    final paint =
        Paint()
          ..color = tBlack
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

    canvas.drawLine(const Offset(651, 604), const Offset(686, 755), paint);

    canvas.drawLine(const Offset(692, 569), const Offset(944, 672), paint);

    canvas.drawLine(const Offset(758, 792), const Offset(943, 718), paint);
  }

  // ---------------------------------------------------------------------------
  // NODE
  // ---------------------------------------------------------------------------

  void _drawNode(
    Canvas canvas, {
    required Offset center,
    required double radius,
    required Color color,
    required String label,
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
      label,
      center,
      fontSize: radius * .55,
      fontWeight: FontWeight.w700,
      color: tBlack,
    );
  }

  // TRIANGLE

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

  // LEFT CARD

  void _drawProductCard(
    Canvas canvas, {
    required double x,
    required double y,
    required String title,
    required Color color,
    required String svg,
    required List<String> points,
  }) {
    final linePaint =
        Paint()
          ..color = color
          ..strokeWidth = 2;

    canvas.drawLine(Offset(x, y), Offset(x + 404, y), linePaint);

    canvas.drawLine(Offset(x, y + 157), Offset(x + 404, y + 157), linePaint);

    _drawSvg(
      canvas,
      svg,
      Offset(x + 67, y + 80),
      color: tBlack,
      opacity: 0.15,
      size: 85,
    );

    _drawText(
      canvas,
      title,
      Offset(x + 175, y + 26), //title position
      fontSize: 21,
      fontWeight: FontWeight.w700,
      color: color,
      align: TextAlign.center,
    );

    _drawBulletPoints(
      canvas,
      points,
      Offset(x + 172, y + 62), //points position
      width: 220,
      iconColor: color,
    );
  }

  // RIGHT CARD

  void _drawRightCard(
    Canvas canvas, {
    required double x,
    required double y,
    required String title,
    required Color color,
    required String svg,
    required List<String> points,
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
      fontSize: 21,
      fontWeight: FontWeight.w700,
      color: color,
    );

    _drawBulletPoints(
      canvas,
      points,
      Offset(x + 18, y + 66),
      width: 245,
      iconColor: color,
    );

    _drawSvg(
      canvas,
      svg,
      Offset(x + 325, y + 84),
      size: 85,
      color: tBlack,
      opacity: 0.15,
    );
  }

  // ICON

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

  // void _drawSvg(
  //   Canvas canvas,
  //   String path,
  //   Offset center, {
  //   required double size,
  //   Color? color, // optional single-colour tint
  // }) {
  //   final info = svgs[path];
  //   if (info == null) return; // not loaded yet

  //   final scale = size / math.max(info.size.width, info.size.height);
  //   final w = info.size.width * scale;
  //   final h = info.size.height * scale;

  //   canvas.save();
  //   canvas.translate(center.dx - w / 2, center.dy - h / 2);
  //   canvas.scale(scale);

  //   if (color != null) {
  //     canvas.saveLayer(
  //       Offset.zero & info.size,
  //       Paint()..colorFilter = ColorFilter.mode(color, BlendMode.srcIn),
  //     );
  //   }

  //   canvas.drawPicture(info.picture);

  //   if (color != null) canvas.restore();
  //   canvas.restore();
  // }
  void _drawSvg(
    Canvas canvas,
    String path,
    Offset center, {
    required double size,
    Color? color,
    double opacity = 1,
  }) {
    final info = svgs[path];
    if (info == null) return; // not loaded yet

    final scale = size / math.max(info.size.width, info.size.height);
    final w = info.size.width * scale;
    final h = info.size.height * scale;

    canvas.save();
    canvas.translate(center.dx - w / 2, center.dy - h / 2);
    canvas.scale(scale);

    final layerPaint = Paint();
    if (color != null) {
      layerPaint.colorFilter = ColorFilter.mode(
        color.withOpacity(opacity),
        BlendMode.srcIn,
      );
    } else {
      layerPaint.color = Color.fromRGBO(0, 0, 0, opacity);
    }

    canvas.saveLayer(Offset.zero & info.size, layerPaint);
    canvas.drawPicture(info.picture);
    canvas.restore();

    canvas.restore();
  }
  // TEXT

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
        style: GoogleFonts.manrope(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          height: lineHeight,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: align,
    );

    painter.layout(minWidth: width ?? 0, maxWidth: width ?? double.infinity);

    painter.paint(canvas, offset);
  }

  void _drawBulletPoints(
    Canvas canvas,
    List<String> points,
    Offset origin, {
    required double width,
    required Color iconColor,
    IconData icon = Icons.check_circle,
    double fontSize = 15,
    double iconSize = 16,
    double spacing = 12,
  }) {
    double dy = 0;

    for (final point in points) {
      final tp = TextPainter(
        text: TextSpan(
          text: point,
          style: GoogleFonts.manrope(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: tBlack,
            height: 1.15,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: width - iconSize - 8);

      // icon, vertically aligned with the first line of text
      _drawIcon(
        canvas,
        icon,
        Offset(origin.dx + iconSize / 2, origin.dy + dy + fontSize * 0.65),
        color: iconColor,
        size: iconSize,
      );

      tp.paint(canvas, Offset(origin.dx + iconSize + 8, origin.dy + dy));

      dy += tp.height + spacing;
    }
  }

  // CENTER TEXT

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
        style: GoogleFonts.manrope(
          fontSize: fontSize,
          fontWeight: fontWeight,
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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
