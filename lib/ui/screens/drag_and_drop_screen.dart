import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/stores/drag_and_drop_store.dart';
import 'package:learn_europe/ui/components/app_appbar.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/constants/routes.dart' as routes;
import 'package:learn_europe/ui/components/cta_button.dart';
import 'package:learn_europe/ui/components/dashed_border_container.dart';
import 'package:learn_europe/ui/components/hint_dialog.dart';
import 'package:learn_europe/ui/components/list_fading_shader.dart';

class DragAndDropScreen extends StatefulWidget {
  const DragAndDropScreen({super.key});

  @override
  DragAndDropScreenState createState() => DragAndDropScreenState();
}

class DragAndDropScreenState extends State<DragAndDropScreen> {
  final dragAndDropStore = DragAndDropStore();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppAppBar(
        title: AppStrings.exitQuiz,
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
                    return const HintDialog(scoreReduction: -25);
                  }),
              child: const Icon(Icons.question_mark),
            ),
          ),
        ],
      ),
      body: Observer(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildQuestionCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Which of these countries is part of the EU?'),
                    const SizedBox(height: AppPaddings.padding_8),
                    Text('${dragAndDropStore.selectedItems.length} items selected'),
                    const SizedBox(height: AppPaddings.padding_32),
                    DashedBorderContainer(
                      height: MediaQuery.of(context).size.height * 0.255,
                      backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.light
                          ? AppColors.lightBackground
                          : AppColors.darkBackground,
                      borderColor: MediaQuery.of(context).platformBrightness == Brightness.light
                          ? Colors.black38
                          : Colors.white60,
                      borderRadius: 10,
                      child: DragTarget<Widget>(
                        builder: (context, candidateData, acceptedData) {
                          return Observer(
                            builder: (context) {
                              return dragAndDropStore.selectedItems.isEmpty
                                  ? const Center(
                                      child: Text('Drop your answer(s) here'),
                                    )
                                  : ListView.builder(
                                      padding: const EdgeInsets.all(AppPaddings.padding_12),
                                      itemCount: dragAndDropStore.selectedItems.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: AppPaddings.padding_8),
                                          child: dragAndDropStore.selectedItems[index],
                                        );
                                      },
                                    );
                            },
                          );
                        },
                        onWillAcceptWithDetails: (details) => !dragAndDropStore.selectedItems.contains(details.data),
                        onAcceptWithDetails: (details) => {
                          dragAndDropStore.addSelectedItem(details.data),
                          dragAndDropStore.removeAvailableItem(details.data),
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Flexible(
                flex: 5,
                child: DragTarget<Widget>(
                  builder: (context, candidateData, acceptedData) {
                    return Observer(
                      builder: (context) {
                        return ListFadingShaderWidget(
                          color: MediaQuery.of(context).platformBrightness == Brightness.light
                              ? AppColors.lightBackground
                              : AppColors.darkBackground,
                          child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.symmetric(vertical: AppPaddings.padding_8),
                            itemCount: dragAndDropStore.availableItems.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1.55,
                              crossAxisSpacing: AppPaddings.padding_8,
                              mainAxisSpacing: AppPaddings.padding_8,
                            ),
                            itemBuilder: (context, index) {
                              return dragAndDropStore.availableItems[index];
                            },
                          ),
                        );
                      },
                    );
                  },
                  onWillAcceptWithDetails: (details) => !dragAndDropStore.availableItems.contains(details.data),
                  onAcceptWithDetails: (details) => {
                    dragAndDropStore.addAvailableItem(details.data),
                    dragAndDropStore.removeSelectedItem(details.data),
                  },
                ),
              ),
              const Spacer(),
              CtaButton.primary(
                  onPressed: dragAndDropStore.selectedItems.isEmpty ? null : () => {}, label: 'Antwort bestätigen'),
            ],
          );
        },
      ),
    );
  }

  Widget _buildQuestionCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: MediaQuery.of(context).platformBrightness == Brightness.light ? AppColors.lightCard : AppColors.darkCard,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black12),
      ),
      padding: const EdgeInsets.all(AppPaddings.padding_32),
      child: Center(
        child: child,
      ),
    );
  }
}

class DraggableItem extends StatelessWidget {
  const DraggableItem({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Draggable<Widget>(
      key: Key(text),
      data: this,
      feedback: Material(
        child: _buildContentContainer(context),
      ),
      childWhenDragging: const SizedBox.shrink(),
      child: _buildContentContainer(context),
    );
  }

  Widget _buildContentContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPaddings.padding_8),
      decoration: BoxDecoration(
        color: MediaQuery.of(context).platformBrightness == Brightness.light
            ? AppColors.accentColorLight
            : AppColors.accentColorDark,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(text, style: const TextStyle(color: Colors.black), overflow: TextOverflow.fade),
    );
  }
}
