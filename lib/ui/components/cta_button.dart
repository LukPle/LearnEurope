import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/textstyles.dart';

class CtaButton extends StatelessWidget {
  const CtaButton.primary({
    super.key,
    required this.onPressed,
    required this.label,
    this.onLongPress,
    this.loading = false,
    this.color,
  }) : _primary = true;

  const CtaButton.secondary({
    super.key,
    required this.onPressed,
    required this.label,
    this.onLongPress,
    this.loading = false,
  })  : _primary = false,
        color = null;

  final void Function()? onPressed;
  final void Function()? onLongPress;
  final String label;
  final bool _primary;
  final bool loading;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    final opacity = onPressed != null ? (loading ? 0.5 : 1.0) : 0.25;
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: _primary
                  ? BorderSide.none
                  : BorderSide(
                      width: 1,
                      color: brightness == Brightness.light ? AppColors.primaryColorLight : AppColors.primaryColorDark,
                    ),
            ),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              vertical: AppPaddings.padding_16,
              horizontal: AppPaddings.padding_16,
            ),
          ),
          backgroundColor: _primary
              ? MaterialStateProperty.all(
                  color ??
                      (brightness == Brightness.light ? AppColors.primaryColorLight : AppColors.primaryColorDark)
                          .withOpacity(opacity),
                )
              : null,
        ),
        onPressed: loading ? null : onPressed,
        onLongPress: loading ? null : onLongPress,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: loading
              ? const SizedBox(
                  width: AppPaddings.padding_20,
                  height: AppPaddings.padding_20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  label,
                  style: AppTextStyles.buttonTextStyle(
                    isPrimary: _primary,
                    brightness: brightness,
                  ),
                ),
        ),
      ),
    );
  }
}
