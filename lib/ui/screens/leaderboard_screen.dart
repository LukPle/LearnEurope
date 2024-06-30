import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/models/leaderboard_entry_model.dart';
import 'package:learn_europe/network/db_services.dart';
import 'package:learn_europe/network/firebase_constants.dart';
import 'package:learn_europe/ui/components/alert_snackbar.dart';
import 'package:learn_europe/ui/components/leaderboard_card.dart';
import 'package:learn_europe/ui/components/list_fading_shader.dart';
import 'package:learn_europe/ui/components/page_headline.dart';

class LeaderboardScreen extends StatelessWidget {
  LeaderboardScreen({super.key});

  final draggableScrollableController = DraggableScrollableController();

  Future<List<LeaderboardEntryModel>> _fetchLeaderboardEntries() async {
    final DatabaseServices dbServices = DatabaseServices();
    final docs = await dbServices.getAllDocuments(collection: FirebaseConstants.usersCollection);
    List<LeaderboardEntryModel> leaderboardEntries = docs
        .map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          if (data.containsKey('name') && data.containsKey('totalPoints')) {
            return LeaderboardEntryModel.fromMap(data);
          } else {
            return null;
          }
        })
        .where((entry) => entry != null)
        .cast<LeaderboardEntryModel>()
        .toList();

    leaderboardEntries.sort((a, b) => b.totalPoints.compareTo(a.totalPoints));
    return leaderboardEntries;
  }

  @override
  Widget build(BuildContext context) {
    bool isSheetExpanded = false;

    return FutureBuilder<List<LeaderboardEntryModel>>(
      future: _fetchLeaderboardEntries(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showAlertSnackBar(context, AppStrings.leaderboardLoadingError, isError: true);
          });
          return SizedBox.shrink(); //_buildEmptyListComponent(context);
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return SizedBox.shrink(); //_buildEmptyListComponent(context);
        } else {
          final leaderboardEntries = snapshot.data!;
          final podiumEntries = leaderboardEntries.take(3).toList();
          final sheetEntries = leaderboardEntries.skip(3).toList();

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppPaddings.padding_16),
                child: Column(
                  children: [
                    const PageHeadline(title: AppStrings.leaderboardTitle),
                    const SizedBox(height: AppPaddings.padding_32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildPodiumPlace(
                          context: context,
                          rank: 2,
                          username: podiumEntries[1].username,
                          totalPoints: podiumEntries[1].totalPoints,
                        ),
                        const SizedBox(width: AppPaddings.padding_12),
                        _buildPodiumPlace(
                          context: context,
                          rank: 1,
                          username: podiumEntries[0].username,
                          totalPoints: podiumEntries[0].totalPoints,
                        ),
                        const SizedBox(width: AppPaddings.padding_12),
                        _buildPodiumPlace(
                          context: context,
                          rank: 3,
                          username: podiumEntries[2].username,
                          totalPoints: podiumEntries[2].totalPoints,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.5,
                minChildSize: 0.5,
                maxChildSize: 0.8,
                snap: true,
                snapSizes: const [0.5, 0.8],
                controller: draggableScrollableController,
                builder: (BuildContext context, ScrollController scrollController) {
                  return GestureDetector(
                    onDoubleTap: () {
                      isSheetExpanded = !isSheetExpanded;
                      draggableScrollableController.animateTo(isSheetExpanded ? 0.5 : 0.8,
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
                                      itemCount: sheetEntries.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              top: AppPaddings.padding_12,
                                              left: AppPaddings.padding_12,
                                              right: AppPaddings.padding_12),
                                          child: LeaderboardCard(
                                            rank: index + 4,
                                            name: sheetEntries[index].username,
                                            points: sheetEntries[index].totalPoints,
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
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildPodiumPlace({
    required BuildContext context,
    required int rank,
    required String username,
    required int totalPoints,
  }) {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '#$rank',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: AppPaddings.padding_4),
            Text(
              username,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppPaddings.padding_4),
            Text(
              '${totalPoints.toString()} Points',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
