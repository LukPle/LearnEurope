import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';

class AlertSnackBar {
  static SnackBar error({
    required String message,
  }) {
    return SnackBar(
      content: Text(
        message,
        style: const TextStyle().copyWith(color: AppColors.error),
      ),
      duration: const Duration(milliseconds: 1500),
      showCloseIcon: true,
      closeIconColor: AppColors.error,
    );
  }

  static SnackBar informative({
    required String message,
  }) {
    return SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 1500),
      showCloseIcon: true,
    );
  }
}

void showAlertSnackBar(BuildContext context, String message, {bool isError = false}) {
  final snackBar = isError ? AlertSnackBar.error(message: message) : AlertSnackBar.informative(message: message);

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
