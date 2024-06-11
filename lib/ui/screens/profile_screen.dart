import 'package:flutter/material.dart';
import 'package:learn_europe/constants/paddings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppPaddings.padding_16),
      child: Center(
        child: Text('Profile'),
      ),
    );
  }
}
