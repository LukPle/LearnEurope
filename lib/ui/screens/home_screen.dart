import 'package:flutter/material.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/ui/components/cta_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Home sweet home'),
        SizedBox(height: AppPaddings.padding_8),
        CtaButton.primary(onPressed: () => {}, label: "Click for good luck",),
        SizedBox(height: AppPaddings.padding_8),
        CtaButton.secondary(onPressed: () => {}, label: "Click for bad luck"),
      ],
    );
  }
}
