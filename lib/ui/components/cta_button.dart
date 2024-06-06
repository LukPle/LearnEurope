import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';

class CtaButton extends StatelessWidget {
  const CtaButton.primary({
    required this.onPressed,
    required this.label,
    super.key,
    this.onLongPress,
    this.light = false,
    this.loading = false,
    this.horizontalPadding = false,
    this.color,
    this.overlayColor = Colors.transparent,
  }) : _primary = true;

  const CtaButton.secondary({
    required this.onPressed,
    required this.label,
    super.key,
    this.onLongPress,
    this.loading = false,
    this.horizontalPadding = false,
    this.overlayColor = Colors.transparent,
  })  : _primary = false,
        light = false,
        color = null;

  final void Function()? onPressed;
  final void Function()? onLongPress;
  final String label;
  final bool _primary;
  final bool light;
  final bool loading;
  final bool horizontalPadding;
  final Color? color;
  final Color overlayColor;

  @override
  Widget build(BuildContext context) {
    final opacity = onPressed != null ? (loading ? 0.5 : 1.0) : 0.25;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding ? AppPaddings.padding_16 : 0),
        child: TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(overlayColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(
                vertical: 13,
                horizontal: 20,
              ),
            ),
            backgroundColor: !_primary
                ? null
                : MaterialStateProperty.all(
                    color == Colors.transparent
                        ? Colors.transparent
                        : (color ?? (light ? Colors.white : AppColors.primaryColorLight)).withOpacity(
                            opacity,
                          ),
                  ),
          ),
          onPressed: loading ? null : onPressed,
          onLongPress: loading ? null : onLongPress,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: loading
                ? const SizedBox(
                    width: AppPaddings.padding_16,
                    height: AppPaddings.padding_16,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2,
                    ),
                  )
                : Container(
                    decoration: _primary
                        ? null
                        : const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                    child: Text(
                      label,
                      /**style: SEVTexts.copyBigMedium.copyWith(
                    color: (light ? getIt<ColorTheme>().primaryAccentColor : Colors.white).withOpacity(
                    opacity,**/
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
