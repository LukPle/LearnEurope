import 'package:flutter/material.dart';

class ListFadingShaderWidget extends StatelessWidget {
  const ListFadingShaderWidget({super.key, required this.color, required this.child});

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color,
            color.withOpacity(0.5),
            color.withOpacity(0.35),
            color.withOpacity(0.25),
            Colors.transparent,
            Colors.transparent,
            color.withOpacity(0.25),
            color.withOpacity(0.35),
            color.withOpacity(0.5),
            color,
          ],
          stops: const [0.0, 0.02, 0.025, 0.03, 0.035, 0.965, 0.97, 0.975, 0.98, 1.0],
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: child,
    );
  }
}
