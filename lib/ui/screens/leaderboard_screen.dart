import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/stores/leaderboard_store.dart';
import 'package:learn_europe/ui/components/leaderboard_card.dart';
import 'package:learn_europe/ui/components/list_fading_shader.dart';
import 'package:learn_europe/ui/components/page_headline.dart';

class LeaderboardScreen extends StatelessWidget {
  LeaderboardScreen({super.key});

  final leaderboardStore = LeaderboardStore();
  final draggableScrollableController = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPaddings.padding_16),
          child: Column(
            children: [
              const PageHeadline(title: "Your place on the leaderboard"),
              const SizedBox(height: AppPaddings.padding_32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildPodiumPlace(context: context, rank: 2),
                  const SizedBox(width: AppPaddings.padding_12),
                  _buildPodiumPlace(context: context, rank: 1),
                  const SizedBox(width: AppPaddings.padding_12),
                  _buildPodiumPlace(context: context, rank: 3),
                ],
              ),
            ],
          ),
        ),
        Observer(
          builder: (context) {
            return DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.5,
              maxChildSize: 0.8,
              snap: true,
              snapSizes: const [0.5, 0.8],
              controller: draggableScrollableController,
              builder: (BuildContext context, ScrollController scrollController) {
                return GestureDetector(
                  onDoubleTap: () {
                    leaderboardStore.toggleSheetExpansion();
                    draggableScrollableController.animateTo(leaderboardStore.isSheetExpanded ? 0.5 : 0.8,
                        duration: const Duration(milliseconds: 300), curve: Curves.ease);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: MediaQuery.of(context).platformBrightness == Brightness.light
                          ? AppColors.lightCard
                          : AppColors.darkCard,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 40,
                          height: 5,
                          margin: const EdgeInsets.symmetric(vertical: AppPaddings.padding_12),
                          decoration: BoxDecoration(
                            color: MediaQuery.of(context).platformBrightness == Brightness.light
                                ? Colors.grey
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        Expanded(
                          child: ListFadingShaderWidget(
                            color: MediaQuery.of(context).platformBrightness == Brightness.light
                                ? AppColors.lightCard
                                : AppColors.darkCard,
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Column(
                                children: [
                                  ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 30,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: AppPaddings.padding_12,
                                            left: AppPaddings.padding_12,
                                            right: AppPaddings.padding_12),
                                        child: LeaderboardCard(
                                          rank: index + 4,
                                          name: 'Amiin der Ficker',
                                          points: 69,
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: AppPaddings.padding_12),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildPodiumPlace({required BuildContext context, required int rank}) {
    return Container(
      width: 100,
      height: (MediaQuery.of(context).size.height * 0.275) - (rank - 1) * 25,
      decoration: BoxDecoration(
        color: (MediaQuery.of(context).platformBrightness == Brightness.light
                ? AppColors.primaryColorLight
                : AppColors.primaryColorDark)
            .withOpacity(
          rank == 1 ? 1 : (rank == 2 ? 0.8 : 0.6),
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      ),
      child: Center(
        child: Text(
          'Rank $rank',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
