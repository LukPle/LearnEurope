import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/firebase/db_services.dart';
import 'package:learn_europe/ui/components/altert_snackbar.dart';
import 'package:learn_europe/ui/components/cta_button.dart';
import 'package:learn_europe/ui/components/page_headline.dart';
import 'package:learn_europe/constants/routes.dart' as routes;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseServices dbServices = DatabaseServices();
    bool isLoading = false;

    return Padding(
      padding: const EdgeInsets.all(AppPaddings.padding_16),
      child: Column(
        children: [
          const PageHeadline(title: 'Profile'),
          const SizedBox(height: AppPaddings.padding_16),
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage('https://mighty.tools/mockmind-api/content/human/2.jpg'),
                ),
                SizedBox(height: AppPaddings.padding_12),
                Text('Amiin the brain', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                SizedBox(height: AppPaddings.padding_12),
                Divider(height: 0, thickness: 0.5, color: Colors.grey),
                SizedBox(height: AppPaddings.padding_12),
                Text('Stats'),
                SizedBox(height: AppPaddings.padding_12),
                Divider(height: 0, thickness: 0.5, color: Colors.grey),
                SizedBox(height: AppPaddings.padding_12),
                Text('Settings'),
              ],
            ),
          ),
          const Spacer(),
          CtaButton.secondary(
            onPressed: () async => _logout(context, dbServices),
            label: AppStrings.logoutButton,
            loading: isLoading,
          ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context, DatabaseServices dbServices) async {
    try {
      await dbServices.logout();
      Navigator.of(context).pushNamedAndRemoveUntil(
        routes.start,
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      showAlertSnackBar(context, AppStrings.logoutFail, isError: true);
    }
  }
}
