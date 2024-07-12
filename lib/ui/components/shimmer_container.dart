import 'package:flutter/material.dart';

class CustomShimmer extends StatefulWidget {
  const CustomShimmer({super.key});

  @override
  CustomShimmerState createState() => CustomShimmerState();
}

class CustomShimmerState extends State<CustomShimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    Color baseColor = brightness == Brightness.light ? Colors.grey.shade300 : Colors.grey.shade800;
    Color highlightColor = brightness == Brightness.light ? Colors.grey.shade200 : Colors.grey.shade600;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [baseColor, highlightColor, baseColor],
              stops: const [0.1, 0.5, 0.9],
              begin: Alignment(-1.0 - 3.0 * _controller.value, -0.3),
              end: Alignment(1.0 + 3.0 * _controller.value, 0.3),
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: child,
        );
      },
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black12),
        ),
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: double.infinity, height: 20.0, color: baseColor),
            const SizedBox(height: 8.0),
            Container(width: double.infinity, height: 14.0, color: baseColor),
            const SizedBox(height: 8.0),
            Container(width: double.infinity, height: 14.0, color: baseColor),
            const SizedBox(height: 8.0),
            Container(width: double.infinity, height: 14.0, color: baseColor),
          ],
        ),
      ),
    );
  }
}
