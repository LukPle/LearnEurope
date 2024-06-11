import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/ui/components/app_appbar.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/constants/routes.dart' as routes;
import 'dart:math' as math;

class MultipleChoiceScreen extends StatefulWidget {
  const MultipleChoiceScreen({super.key});

  @override
  MultipleChoiceScreenState createState() => MultipleChoiceScreenState();
}

class MultipleChoiceScreenState extends State<MultipleChoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppAppBar(
        title: 'Quiz abbrechen',
        centerTitle: false,
        leadingIcon: Icons.close,
        leadingIconAction: () => {
          Navigator.of(context).pop(routes.tabSelector),
        },
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppPaddings.padding_16),
            child: GestureDetector(
              onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const Dialog(
                      child: Padding(
                        padding: EdgeInsets.all(AppPaddings.padding_16),
                        child: Text('Hint'),
                      ),
                    );
                  }),
              child: const Icon(Icons.question_mark),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _buildMultipleChoiceQuestionCard(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Welches Land ist hier zu sehen?"),
                  const SizedBox(height: AppPaddings.padding_24),
                  SizedBox(
                    height: 225,
                    child: Transform.rotate(
                      angle: 0 * (math.pi / 180),
                      child:
                          Image.network('https://i.pinimg.com/originals/de/cd/15/decd15e39360f7ba7acd4077b79912de.gif'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppPaddings.padding_32),
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 2 / 1.65,
            mainAxisSpacing: AppPaddings.padding_16,
            crossAxisSpacing: AppPaddings.padding_16,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(4, (index) {
              return _buildMultipleChoiceAnswerCard(child: Text("Antwort"), index: index);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildMultipleChoiceQuestionCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: MediaQuery.of(context).platformBrightness == Brightness.light ? AppColors.lightCard : AppColors.darkCard,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black12),
      ),
      padding: const EdgeInsets.all(AppPaddings.padding_16),
      child: Center(
        child: child,
      ),
    );
  }

  Widget _buildMultipleChoiceAnswerCard({required Widget child, required int index}) {
    return GestureDetector(
      onTap: () => {
        print('Click $index'),
      },
      child: Container(
        decoration: BoxDecoration(
          color:
              MediaQuery.of(context).platformBrightness == Brightness.light ? AppColors.lightCard : AppColors.darkCard,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 1,
              offset: const Offset(0.5, 1.5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(AppPaddings.padding_8),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
