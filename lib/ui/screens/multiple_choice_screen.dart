import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/ui/components/app_appbar.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

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
            child: _buildMultipleChoiceQuestionCard(),
          ),
          const SizedBox(height: AppPaddings.padding_24),
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: AppPaddings.padding_12,
            crossAxisSpacing: AppPaddings.padding_12,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(4, (index) {
              return _buildMultipleChoiceAnswerCard(index);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildMultipleChoiceQuestionCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black12),
      ),
      padding: const EdgeInsets.all(AppPaddings.padding_16),
      child: const Center(
        child: Text('Frage'),
      ),
    );
  }

  Widget _buildMultipleChoiceAnswerCard(int index) {
    return GestureDetector(
      onTap: () => {
        print('Click $index'),
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 1,
            offset: const Offset(0.5, 1.5),
          ),
        ]),
        padding: const EdgeInsets.all(AppPaddings.padding_8),
        child: const Center(
          child: Text('Antwort'),
        ),
      ),
    );
  }
}
