import 'package:flutter/material.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/stores/hint_dialog_store.dart';
import 'package:learn_europe/ui/components/app_appbar.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/ui/components/cta_button.dart';
import 'package:learn_europe/ui/components/hint_dialog.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

class GappedTextScreen extends StatelessWidget {
  GappedTextScreen({super.key});

  HintDialogStore hintDialogStore = HintDialogStore();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppAppBar(
        title: AppStrings.exitQuiz,
        centerTitle: false,
        leadingIcon: Icons.close,
        leadingIconAction: () => Navigator.of(context).pop(routes.tabSelector),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppPaddings.padding_16),
            child: GestureDetector(
              onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return HintDialog(
                    hintDialogStore: hintDialogStore,
                    scoreReduction: -10,
                    hint: 'THE HINT',
                  );
                },
              ),
              child: const Icon(Icons.question_mark),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Fill in the gaps",
            style: AppTextStyles.questionTextStyle,
          ),
          const SizedBox(height: AppPaddings.padding_16),
          GappedTextWidget(
            textWithGaps: "The capital of France is __. The capital of Germany is __.",
          ),
          const SizedBox(height: AppPaddings.padding_16),
          const Spacer(),
          CtaButton.primary(onPressed: () => {}, label: 'Check result')
        ],
      ),
    );
  }
}

class GappedTextWidget extends StatelessWidget {
  final String textWithGaps;

  const GappedTextWidget({super.key, required this.textWithGaps});

  @override
  Widget build(BuildContext context) {
    List<String> parts = textWithGaps.split('__');
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (int i = 0; i < parts.length; i++) ...[
          Text(parts[i]),
          if (i < parts.length - 1)
            Container(
              width: 100,
              constraints: const BoxConstraints(maxWidth: 120),
              child: TextField(
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  hintText: '...',
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: AppPaddings.padding_8, horizontal: AppPaddings.padding_4),
                  border: const UnderlineInputBorder(),
                ),
              ),
            ),
        ],
      ],
    );
  }
}
