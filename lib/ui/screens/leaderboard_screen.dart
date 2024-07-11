import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/models/leaderboard_entry_model.dart';
import 'package:learn_europe/network/db_services.dart';
import 'package:learn_europe/network/firebase_constants.dart';
import 'package:learn_europe/service_locator.dart';
import 'package:learn_europe/stores/user_store.dart';
import 'package:learn_europe/ui/components/alert_snackbar.dart';
import 'package:learn_europe/ui/components/leaderboard_card.dart';
import 'package:learn_europe/ui/components/leaderboard_podium.dart';
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
            return LeaderboardEntryModel.fromMap(doc.id, data);
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
    bool isSmallScreen = MediaQuery.of(context).size.height < 700;
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
          return _buildEmptyLeaderboardComponent(context);
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return _buildEmptyLeaderboardComponent(context);
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
                        LeaderboardPodium(
                          rank: 2,
                          username: podiumEntries[1].username,
                          totalPoints: podiumEntries[1].totalPoints,
                          isUser: podiumEntries[1].id == getIt<UserStore>().userId,
                        ),
                        const SizedBox(width: AppPaddings.padding_12),
                        LeaderboardPodium(
                          rank: 1,
                          username: podiumEntries[0].username,
                          totalPoints: podiumEntries[0].totalPoints,
                          isUser: podiumEntries[0].id == getIt<UserStore>().userId,
                        ),
                        const SizedBox(width: AppPaddings.padding_12),
                        LeaderboardPodium(
                          rank: 3,
                          username: podiumEntries[2].username,
                          totalPoints: podiumEntries[2].totalPoints,
                          isUser: podiumEntries[2].id == getIt<UserStore>().userId,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: isSmallScreen ? 0.4 : 0.5,
                minChildSize: isSmallScreen ? 0.4 : 0.5,
                maxChildSize: 0.8,
                snap: true,
                snapSizes: isSmallScreen ? [0.4, 0.8] : [0.5, 0.8],
                controller: draggableScrollableController,
                builder: (BuildContext context, ScrollController scrollController) {
                  return GestureDetector(
                    onDoubleTap: () {
                      isSheetExpanded = !isSheetExpanded;
                      draggableScrollableController.animateTo(
                          isSheetExpanded
                              ? isSmallScreen
                                  ? 0.4
                                  : 0.5
                              : 0.8,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease);
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
                                            isUser: sheetEntries[index].id == getIt<UserStore>().userId,
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

  Widget _buildEmptyLeaderboardComponent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.leaderboard,
            size: MediaQuery.of(context).size.width * 0.075,
            color: MediaQuery.of(context).platformBrightness == Brightness.light
                ? AppColors.primaryColorLight
                : AppColors.primaryColorDark,
          ),
          const SizedBox(height: AppPaddings.padding_8),
          const Text(AppStrings.noLeaderboardAvailable),
        ],
      ),
    );
  }
}
