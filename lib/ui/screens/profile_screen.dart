import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/network/data_fetching.dart';
import 'package:learn_europe/network/db_services.dart';
import 'package:learn_europe/service_locator.dart';
import 'package:learn_europe/stores/avatar_selection_dialog_store.dart';
import 'package:learn_europe/stores/cta_button_loading_store.dart';
import 'package:learn_europe/stores/user_store.dart';
import 'package:learn_europe/ui/components/alert_snackbar.dart';
import 'package:learn_europe/ui/components/profile_analytics/score_activity_analytics.dart';
import 'package:learn_europe/ui/components/profile_analytics/categories_progress_analytics.dart';
import 'package:learn_europe/ui/components/cta_button.dart';
import 'package:learn_europe/ui/components/list_fading_shader.dart';
import 'package:learn_europe/ui/components/page_headline.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseServices dbServices = DatabaseServices();
    final CtaButtonLoadingStore ctaButtonLoadingStore = CtaButtonLoadingStore();

    return Observer(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(AppPaddings.padding_16),
          child: Column(
            children: [
              const PageHeadline(title: AppStrings.profileTitle),
              const SizedBox(height: AppPaddings.padding_16),
              Expanded(
                child: ListFadingShaderWidget(
                  color: MediaQuery.of(context).platformBrightness == Brightness.light
                      ? AppColors.lightBackground
                      : AppColors.darkBackground,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppPaddings.padding_16),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: MediaQuery.of(context).platformBrightness == Brightness.light
                                  ? AppColors.lightCard
                                  : AppColors.darkCard,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black12),
                            ),
                            padding: const EdgeInsets.all(AppPaddings.padding_16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () => _selectAvatar(context),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          clipBehavior: Clip.none,
                                          children: [
                                            CircleAvatar(
                                              radius: 45,
                                              backgroundColor:
                                                  MediaQuery.of(context).platformBrightness == Brightness.light
                                                      ? AppColors.lightBackground
                                                      : AppColors.darkBackground,
                                              backgroundImage: AssetImage(
                                                'assets/${getIt<UserStore>().avatar ?? 'avatar_blue'}.png',
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              right: -15,
                                              child: Container(
                                                padding: const EdgeInsets.all(AppPaddings.padding_8),
                                                decoration: BoxDecoration(
                                                  color: MediaQuery.of(context).platformBrightness == Brightness.light
                                                      ? AppColors.primaryColorLight
                                                      : AppColors.primaryColorDark,
                                                  borderRadius: BorderRadius.circular(50),
                                                ),
                                                child: Icon(
                                                  Icons.edit,
                                                  color: MediaQuery.of(context).platformBrightness == Brightness.light
                                                      ? Colors.white
                                                      : Colors.black,
                                                  size: 17.5,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: AppPaddings.padding_12),
                                      Text(
                                        getIt<UserStore>().username.toString(),
                                        style: AppTextStyles.standardTitleTextStyle,
                                      ),
                                      const SizedBox(height: AppPaddings.padding_2),
                                      FutureBuilder<DateTime>(
                                        future: fetchUserRegistrationDate(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return const Center(
                                              child: SizedBox.shrink(),
                                            );
                                          } else {
                                            final registrationDate = snapshot.data;
                                            return Text(
                                              AppStrings.learnerRegistrationText(registrationDate),
                                              style: AppTextStyles.thinDetailTextStyle(
                                                  MediaQuery.of(context).platformBrightness),
                                              textAlign: TextAlign.center,
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: AppPaddings.padding_16),
                                const Divider(height: 0, thickness: 0.5, color: Colors.grey),
                                const SizedBox(height: AppPaddings.padding_16),
                                const Text(
                                  AppStrings.scoreAndActivityAnalyticsTitle,
                                  style: AppTextStyles.sectionTitleTextStyle,
                                ),
                                const SizedBox(height: AppPaddings.padding_8),
                                FutureBuilder(
                                  future: fetchTotalPoints(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting || snapshot.hasError) {
                                      return const Center(
                                        child: SizedBox.shrink(),
                                      );
                                    } else {
                                      final totalPoints = snapshot.data;
                                      return ScoreAndActivityAnalytics(totalPoints: totalPoints, activeDays: 4);
                                    }
                                  },
                                ),
                                const SizedBox(height: AppPaddings.padding_24),
                                const Text(
                                  AppStrings.categoriesAnalyticsTitle,
                                  style: AppTextStyles.sectionTitleTextStyle,
                                ),
                                const SizedBox(height: AppPaddings.padding_8),
                                FutureBuilder(
                                  future: fetchCategoryProgress(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting ||
                                        snapshot.hasError ||
                                        !snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return const SizedBox.shrink();
                                    } else {
                                      final List<double> categoryProgress = snapshot.data!;
                                      return CategoriesProgressAnalytics(
                                        progressEurope101: categoryProgress[0],
                                        progressLanguages: categoryProgress[1],
                                        progressCountryBorders: categoryProgress[2],
                                        progressGeoPosition: categoryProgress[3],
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppPaddings.padding_32),
                          CtaButton.secondary(
                            onPressed: () async => _logout(context, dbServices, ctaButtonLoadingStore),
                            label: AppStrings.logoutButton,
                            loading: ctaButtonLoadingStore.isLoading,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectAvatar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const SelectAvatarDialog();
      },
    );
  }

  Future<void> _logout(
      BuildContext context, DatabaseServices dbServices, CtaButtonLoadingStore ctaButtonLoadingStore) async {
    try {
      ctaButtonLoadingStore.setLoading();
      await dbServices.logout();
      if (context.mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          routes.start,
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      ctaButtonLoadingStore.resetLoading();
      if (context.mounted) {
        showAlertSnackBar(context, AppStrings.logoutFail, isError: true);
      }
    }
  }
}

class SelectAvatarDialog extends StatefulWidget {
  const SelectAvatarDialog({super.key});

  @override
  SelectAvatarDialogState createState() => SelectAvatarDialogState();
}

class SelectAvatarDialogState extends State<SelectAvatarDialog> {
  AvatarSelectionDialogStore avatarSelectionDialogStore = AvatarSelectionDialogStore();

  @override
  void initState() {
    super.initState();
    avatarSelectionDialogStore.setAvatar(getIt<UserStore>().avatar ?? 'avatar_blue');
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Dialog(
          elevation: 1,
          insetPadding: const EdgeInsets.symmetric(horizontal: AppPaddings.padding_16),
          child: Padding(
            padding: const EdgeInsets.all(AppPaddings.padding_16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(AppStrings.selectAvatarTitle, style: AppTextStyles.sectionTitleTextStyle),
                const SizedBox(height: AppPaddings.padding_8),
                Flexible(
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: AppPaddings.padding_8,
                    mainAxisSpacing: AppPaddings.padding_8,
                    children: [
                      AvatarCard(
                        imageUrl: 'assets/avatar_blue.png',
                        isSelected: 'avatar_blue' == avatarSelectionDialogStore.selectedAvatar,
                        onTap: () => avatarSelectionDialogStore.setAvatar('avatar_blue'),
                      ),
                      AvatarCard(
                        imageUrl: 'assets/avatar_yellow.png',
                        isSelected: 'avatar_yellow' == avatarSelectionDialogStore.selectedAvatar,
                        onTap: () => avatarSelectionDialogStore.setAvatar('avatar_yellow'),
                      ),
                      AvatarCard(
                        imageUrl: 'assets/avatar_green.png',
                        isSelected: 'avatar_green' == avatarSelectionDialogStore.selectedAvatar,
                        onTap: () => avatarSelectionDialogStore.setAvatar('avatar_green'),
                      ),
                      AvatarCard(
                        imageUrl: 'assets/avatar_red.png',
                        isSelected: 'avatar_red' == avatarSelectionDialogStore.selectedAvatar,
                        onTap: () => avatarSelectionDialogStore.setAvatar('avatar_red'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppPaddings.padding_24),
                CtaButton.primary(
                  onPressed: () async {
                    await changeUserAvatar(avatarSelectionDialogStore.selectedAvatar);
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  label: AppStrings.selectAvatarButton,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AvatarCard extends StatelessWidget {
  const AvatarCard({super.key, required this.imageUrl, required this.isSelected, required this.onTap});

  final String imageUrl;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: MediaQuery.of(context).platformBrightness == Brightness.light
                  ? AppColors.lightCard
                  : AppColors.darkCard,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isSelected
                    ? MediaQuery.of(context).platformBrightness == Brightness.light
                        ? AppColors.primaryColorLight
                        : AppColors.primaryColorDark
                    : Colors.black12,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 0.5,
                  offset: const Offset(0.5, 0.5),
                ),
              ],
            ),
            padding: const EdgeInsets.all(AppPaddings.padding_4),
            child: Image.asset(imageUrl),
          ),
          if (isSelected)
            Positioned(
              right: 5,
              bottom: 5,
              child: Icon(
                Icons.check_circle,
                color: MediaQuery.of(context).platformBrightness == Brightness.light
                    ? AppColors.primaryColorLight
                    : AppColors.primaryColorDark,
              ),
            ),
        ],
      ),
    );
  }
}
