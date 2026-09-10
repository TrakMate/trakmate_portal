import 'dart:math';

import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/utils/colors.dart';

class ScrollerButton extends StatefulWidget {
  final bool isVisible;
  final VoidCallback onTap;
  // NEW: lets you reuse this widget with a different icon (e.g. scroll-up arrow)
  final String svgAsset;
  final Color iconColor; // second color
  final Color iconHoverColor;
  final bool rotateIcon;
  const ScrollerButton({
    super.key,
    required this.isVisible,
    required this.onTap,
    this.svgAsset = 'icons/down1.svg', // default keeps old behavior intact
    this.iconColor = tWhite, // second scroller clr
    this.iconHoverColor = tOrange1,
    this.rotateIcon = false,
  });

  @override
  State<ScrollerButton> createState() => _ScrollerButtonState();
}

class _ScrollerButtonState extends State<ScrollerButton>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isPressed = false;

  late final AnimationController _progressController;

  @override
  void initState() {
    super.initState();

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), //duration
    )..repeat();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isPressed = true;
    });

    Future.delayed(const Duration(milliseconds: 120), () {
      if (!mounted) return;

      setState(() {
        _isPressed = false;
      });
    });

    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.isVisible,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        opacity: widget.isVisible ? 1.0 : 0.0,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOutCubic,
          offset: widget.isVisible ? Offset.zero : const Offset(0, 0.25),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) {
              setState(() {
                _isHovered = true;
              });
            },
            onExit: (_) {
              setState(() {
                _isHovered = false;
              });
            },
            child: GestureDetector(
              onTap: _handleTap,
              child: AnimatedScale(
                scale: _isPressed ? 0.90 : (_isHovered ? 1.04 : 1.0),
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOutCubic,
                child: SizedBox(
                  width: 44,
                  height: 44,
                  child: AnimatedBuilder(
                    animation: _progressController,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: _ScrollerPainter(
                          progress: _progressController.value,
                          isHovered: _isHovered,
                          // fillColor: tOrange1.withOpacity(0.2), //fill color
                        ),
                        child: child,
                      );
                    },
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _progressController,
                        builder: (context, child) {
                          // Gentle downward movement.
                          final double movement =
                              _progressController.value < 0.5
                                  ? _progressController.value * 4
                                  : (1 - _progressController.value) * 4;

                          return Transform.translate(
                            offset: Offset(0, movement),
                            child: child,
                          );
                        },
                        child: Transform.rotate(
                          angle:
                              widget.rotateIcon ? pi : 0.0, // static 180° flip
                          child: SvgPicture.asset(
                            widget.svgAsset,
                            width: 27,
                            height: 27,
                            fit: BoxFit.contain,
                            color:
                                _isHovered
                                    ? widget.iconHoverColor
                                    : widget.iconColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ScrollerPainter extends CustomPainter {
  final double progress;
  final bool isHovered;
  // final Color fillColor;
  _ScrollerPainter({
    required this.progress,
    required this.isHovered,
    // this.fillColor = tWhite,//fill color
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);

    final double radius = (size.width / 2) - 2;

    // Base circular border.
    final Paint basePaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4
          ..color = tWhite.withOpacity(0.35);

    canvas.drawCircle(center, radius, basePaint);
    // final Paint fillPaint =
    //     Paint()
    //       ..color = fillColor
    //       ..style = PaintingStyle.fill;

    // canvas.drawCircle(center, radius, fillPaint);//fill color
    // Progress ring.
    final Paint progressPaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = isHovered ? 2.2 : 1.8
          ..strokeCap = StrokeCap.round
          ..color = tOrange1;

    final Rect rect = Rect.fromCircle(center: center, radius: radius);

    // Start at top.
    const double startAngle = -3.14159265359 / 2;

    canvas.drawArc(
      rect,
      startAngle,
      progress * 2 * 3.14159265359,
      false,
      progressPaint,
    );

    // Small glow at the leading edge.
    if (progress > 0.01 && progress < 0.99) {
      final double angle = startAngle + progress * 2 * 3.14159265359;

      final Offset dotPosition = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      final Paint dotPaint =
          Paint()
            ..style = PaintingStyle.fill
            ..color = tOrange1;

      canvas.drawCircle(dotPosition, isHovered ? 2.2 : 1.7, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ScrollerPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.isHovered != isHovered;
  }
}
