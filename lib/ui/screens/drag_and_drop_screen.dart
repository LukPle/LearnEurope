import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/stores/drag_and_drop_store.dart';
import 'package:learn_europe/ui/components/app_appbar.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/constants/routes.dart' as routes;
import 'package:learn_europe/ui/components/cta_button.dart';
import 'package:learn_europe/ui/components/dashed_border_container.dart';

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
          _buildQuestionCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Which of these countries is part of the EU?'),
                const SizedBox(height: AppPaddings.padding_32),
                DashedBorderContainer(
                  height: MediaQuery.of(context).size.height * 0.225,
                  backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.light
                      ? AppColors.lightBackground
                      : AppColors.darkBackground,
                  borderColor:
                      MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.black38 : Colors.white60,
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
                                  itemCount: dragAndDropStore.selectedItems.length,
                                  itemBuilder: (context, index) {
                                    return dragAndDropStore.selectedItems[index];
                                  },
                                );
                        },
                      );
                    },
                    onWillAcceptWithDetails: (details) => true,
                    onAcceptWithDetails: (details) => {
                      dragAndDropStore.addSelectedItem(details.data),
                      dragAndDropStore.removeAvailableItem(details.data),
                    },
                  ),
                ),
                /**const SizedBox(height: AppPaddings.padding_24),
                    Text('0 items selected'),**/
              ],
            ),
          ),
          const Spacer(),
          Flexible(
            child: DragTarget<Widget>(
              builder: (context, candidateData, acceptedData) {
                return Observer(
                  builder: (context) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dragAndDropStore.availableItems.length,
                      itemBuilder: (context, index) {
                        return dragAndDropStore.availableItems[index];
                      },
                    );
                  },
                );
              },
              onWillAcceptWithDetails: (details) => true,
              onAcceptWithDetails: (details) => {
                dragAndDropStore.addAvailableItem(details.data),
                dragAndDropStore.removeSelectedItem(details.data),
              },
            ),
          ),
          const Spacer(),
          CtaButton.primary(onPressed: () => {}, label: 'Antwort bestätigen'),
        ],
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
        child: _buildContentContainer(),
      ),
      childWhenDragging: const SizedBox.shrink(),
      child: _buildContentContainer(),
    );
  }

  Widget _buildContentContainer() {
    return Container(
      padding: const EdgeInsets.all(AppPaddings.padding_8),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(text),
    );
  }
}
