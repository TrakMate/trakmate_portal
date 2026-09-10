import 'package:flutter/material.dart';

/// Displays [text] character-by-character, animating any character
/// that changes with a vertical roll (like YouTube/Instagram counters).
class RollingDigitText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;

  const RollingDigitText({
    super.key,
    required this.text,
    this.style,
    this.duration = const Duration(milliseconds: 550),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < text.length; i++)
          ClipRect(
            child: AnimatedSwitcher(
              duration: duration,
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) {
                final offset = Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation);
                return SlideTransition(
                  position: offset,
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: Text(
                text[i],
                key: ValueKey<String>('${i}_${text[i]}'),
                style: style,
              ),
            ),
          ),
      ],
    );
  }
}
