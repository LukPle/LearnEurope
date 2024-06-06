import 'package:flutter/material.dart';
import 'package:learn_europe/constants/paddings.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.hasVerticalPadding = true,
    this.hasHorizontalPadding = true,
  });

  final Widget body;
  final AppBar? appBar;
  final Widget? bottomNavigationBar;
  final bool hasVerticalPadding;
  final bool hasHorizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: hasVerticalPadding ? AppPaddings.padding_16 : 0,
            horizontal: hasHorizontalPadding ? AppPaddings.padding_16 : 0,
          ),
          child: body,
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
