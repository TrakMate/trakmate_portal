import 'package:flutter/material.dart';

class HeroAnimatedText extends StatefulWidget {
  final Widget child;
  final int delay;
  final bool isActive;

  const HeroAnimatedText({
    super.key,
    required this.child,
    required this.delay,
    required this.isActive,
  });

  @override
  State<HeroAnimatedText> createState() => _HeroAnimatedTextState();
}

class _HeroAnimatedTextState extends State<HeroAnimatedText> {
  bool _animationStarted = false;

  @override
  void initState() {
    super.initState();

    if (widget.isActive) {
      _startAnimation();
    }
  }

  @override
  void didUpdateWidget(covariant HeroAnimatedText oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Replay animation whenever the tab becomes active again.
    if (!oldWidget.isActive && widget.isActive) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    setState(() {
      _animationStarted = false;
    });

    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted && widget.isActive) {
        setState(() {
          _animationStarted = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: ValueKey('${widget.isActive}_${_animationStarted}_${widget.delay}'),
      tween: Tween<double>(begin: 0, end: _animationStarted ? 1 : 0),
      duration: Duration(milliseconds: 1000 + widget.delay),
      curve: Curves.easeOutCubic,
      child: widget.child,
      builder: (context, value, child) {
        final double animationValue =
            ((value * (650 + widget.delay) - widget.delay) / 650).clamp(
              0.0,
              1.0,
            );

        final curvedValue = Curves.easeOutCubic.transform(animationValue);

        return Opacity(
          opacity: curvedValue,
          child: Transform.translate(
            offset: Offset(60 * (1 - curvedValue), 0),
            child: child,
          ),
        );
      },
    );
  }
}
