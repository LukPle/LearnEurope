import 'package:flutter/material.dart';
import 'package:learn_europe/constants/paddings.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.hasVerticalPadding = true,
    this.hasHorizontalPadding = true,
    this.hasBottomSafeArea = true,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool hasVerticalPadding;
  final bool hasHorizontalPadding;
  final bool hasBottomSafeArea;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        bottom: hasBottomSafeArea,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: hasVerticalPadding ? AppPaddings.padding_16 : 0,
            horizontal: hasHorizontalPadding ? AppPaddings.padding_16 : 0,
          ),
          child: body,
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
