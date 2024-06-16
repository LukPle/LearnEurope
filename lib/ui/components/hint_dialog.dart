import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/stores/hint_dialog_store.dart';
import 'package:learn_europe/ui/components/cta_button.dart';
import 'package:learn_europe/ui/components/page_headline.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HintDialog extends Dialog {
  const HintDialog({super.key, required this.scoreReduction});

  final int scoreReduction;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    HintDialogStore hintDialogStore = HintDialogStore();

    return Observer(
      builder: (context) {
        return Dialog(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(AppPaddings.padding_16),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      height: 50,
                      width: 50,
                      brightness == Brightness.light ? 'assets/warning_light.svg' : 'assets/warning_dark.svg',
                    ),
                    const PageHeadline(title: AppStrings.hintDialogTitle),
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
                          TextSpan(
                              text: 'If you look up the hint for this question, this will result in a reduction of '),
                          TextSpan(
                            text: '$scoreReduction points',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: ' that you can earn by correctly answering this question.'),
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
                          child: const Text('THE HINT'),
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
                        label: 'Reveal hint')
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
