import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/network/db_services.dart';
import 'package:learn_europe/network/service_locator.dart';
import 'package:learn_europe/stores/cta_button_loading_store.dart';
import 'package:learn_europe/stores/user_store.dart';
import 'package:learn_europe/ui/components/alert_snackbar.dart';
import 'package:learn_europe/ui/components/categories_progress_analytics.dart';
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
                                      CircleAvatar(
                                        radius: 45,
                                        backgroundImage:
                                            NetworkImage('https://mighty.tools/mockmind-api/content/human/2.jpg'),
                                      ),
                                      const SizedBox(height: AppPaddings.padding_12),
                                      Text(
                                        getIt<UserStore>().username.toString(),
                                        style: AppTextStyles.standardTitleTextStyle,
                                      ),
                                      const SizedBox(height: AppPaddings.padding_2),
                                      Text(
                                        'Student of Europe\nsince 12.06.2024',
                                        style: AppTextStyles.quizCardDetailsTextStyle(
                                            MediaQuery.of(context).platformBrightness),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: AppPaddings.padding_16),
                                const Divider(height: 0, thickness: 0.5, color: Colors.grey),
                                const SizedBox(height: AppPaddings.padding_16),
                                Text('Score', style: AppTextStyles.profileSectionTitles),
                                const SizedBox(height: AppPaddings.padding_8),
                                Padding(
                                  padding: const EdgeInsets.all(AppPaddings.padding_8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${760.toString()} Points',
                                        style: AppTextStyles.standardTitleTextStyle.copyWith(
                                          color: MediaQuery.of(context).platformBrightness == Brightness.light
                                              ? AppColors.primaryColorLight
                                              : AppColors.primaryColorDark,
                                        ),
                                      ),
                                      Text(
                                        '#2 on Leaderboard',
                                        style: AppTextStyles.standardTitleTextStyle.copyWith(
                                          color: MediaQuery.of(context).platformBrightness == Brightness.light
                                              ? AppColors.primaryColorLight
                                              : AppColors.primaryColorDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: AppPaddings.padding_24),
                                Text('Categories Progress', style: AppTextStyles.profileSectionTitles),
                                const SizedBox(height: AppPaddings.padding_8),
                                const CategoriesProgressAnalytics(),
                                const SizedBox(height: AppPaddings.padding_24),
                                Text('Activity Streak', style: AppTextStyles.profileSectionTitles),
                                const SizedBox(height: AppPaddings.padding_8),
                                Padding(
                                  padding: const EdgeInsets.all(AppPaddings.padding_8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.local_fire_department_rounded,
                                        size: MediaQuery.of(context).size.width * 0.05,
                                        color: AppColors.activityFlameColors[1],
                                      ),
                                      const SizedBox(width: AppPaddings.padding_8),
                                      Text(
                                        '4 Consecutive Days',
                                        style: TextStyle(
                                          color: AppColors.activityFlameColors[1],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
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
