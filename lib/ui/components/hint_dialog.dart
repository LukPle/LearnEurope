import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/stores/hint_dialog_store.dart';
import 'package:learn_europe/ui/components/cta_button.dart';

class HintDialog extends Dialog {
  const HintDialog({super.key, required this.scoreReduction, required this.hint});

  final int scoreReduction;
  final String hint;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    HintDialogStore hintDialogStore = HintDialogStore();

    return Observer(
      builder: (context) {
        return Dialog(
          elevation: 1,
          insetPadding: const EdgeInsets.symmetric(horizontal: AppPaddings.padding_16),
          child: Padding(
            padding: const EdgeInsets.all(AppPaddings.padding_16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LimitedBox(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                      child: const Text(
                        AppStrings.hintDialogTitle,
                        style: AppTextStyles.standardTitleTextStyle,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close)),
                  ],
                ),
                const SizedBox(height: AppPaddings.padding_24),
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style.copyWith(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                          color: brightness == Brightness.light ? Colors.black : Colors.white,
                        ),
                    children: [
                      const TextSpan(text: 'If you look up the hint for this question, this will result in a reduction of '),
                      TextSpan(
                        text: '$scoreReduction points',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: ' that you can earn by correctly answering this question.'),
                    ],
                  ),
                ),
                const SizedBox(height: AppPaddings.padding_24),
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppPaddings.padding_8),
                      decoration: BoxDecoration(
                        color: brightness == Brightness.light ? AppColors.lightCard : AppColors.darkCard,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(hint, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    if (!hintDialogStore.isHintRevealed)
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: AnimatedSwitcher(
                            duration: const Duration(seconds: 2),
                            switchInCurve: Curves.easeIn,
                            switchOutCurve: Curves.easeOut,
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            child: BackdropFilter(
                              key: ValueKey<bool>(hintDialogStore.isHintRevealed),
                              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                    colors: [
                                      Colors.grey.shade300.withOpacity(0.5),
                                      Colors.grey.shade600.withOpacity(0.5),
                                      Colors.grey.shade300.withOpacity(0.5),
                                    ],
                                    stops: const [0.0, 0.5, 1.0],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    tileMode: TileMode.mirror,
                                  ).createShader(bounds);
                                },
                                child: Container(
                                  color: Colors.white.withOpacity(0.1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppPaddings.padding_24),
                CtaButton.primary(
                  onPressed: hintDialogStore.isHintRevealed ? null : () => hintDialogStore.revealHint(),
                  label: 'Yes, reveal the hint',
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
