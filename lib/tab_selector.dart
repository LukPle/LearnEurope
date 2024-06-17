import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/stores/navigation_store.dart';
import 'package:learn_europe/ui/components/app_scaffold.dart';
import 'package:learn_europe/ui/screens/categories_screen.dart';
import 'package:learn_europe/ui/screens/home_screen.dart';
import 'package:learn_europe/ui/screens/leaderboard_screen.dart';
import 'package:learn_europe/ui/screens/profile_screen.dart';
import 'constants/colors.dart';
import 'constants/strings.dart';

class TabSelector extends StatefulWidget {
  const TabSelector({super.key});

  @override
  TabSelectorState createState() => TabSelectorState();
}

class TabSelectorState extends State<TabSelector> {
  final navigationStore = NavigationStore();

  final screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    LeaderboardScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return AppScaffold(
        hasVerticalPadding: false,
        hasHorizontalPadding: false,
        body: IndexedStack(
          index: navigationStore.currentIndex,
          children: screens,
        ),
        bottomNavigationBar: SizedBox(
          height: MediaQuery.of(context).size.height * 0.125,
          child: _buildBottomNavigationBar(context),
        ),
      );
    });
  }

  BottomNavigationBar _buildBottomNavigationBar(context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor:
            MediaQuery.of(context).platformBrightness == Brightness.dark ? AppColors.darkCard : AppColors.lightCard,
        selectedItemColor: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? AppColors.primaryColorDark
            : AppColors.primaryColorLight,
        unselectedItemColor:
            MediaQuery.of(context).platformBrightness == Brightness.dark ? AppColors.lightCard : AppColors.darkCard,
        selectedLabelStyle: AppTextStyles.bottomNavigationActive,
        unselectedLabelStyle: AppTextStyles.bottomNavigationPassive,
        iconSize: AppPaddings.padding_24,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: AppStrings.navHome,
            icon: Icon(navigationStore.currentIndex == 0 ? Icons.home : Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: AppStrings.navCategories,
            icon: Icon(navigationStore.currentIndex == 1 ? Icons.category : Icons.category_outlined),
          ),
          BottomNavigationBarItem(
            label: AppStrings.navLeaderboard,
            icon: Icon(navigationStore.currentIndex == 2 ? Icons.leaderboard : Icons.leaderboard_outlined),
          ),
          BottomNavigationBarItem(
            label: AppStrings.navProfile,
            icon: Icon(navigationStore.currentIndex == 3 ? Icons.account_circle : Icons.account_circle_outlined),
          ),
        ],
        currentIndex: navigationStore.currentIndex,
        onTap: (index) {
          navigationStore.switchScreen(index);
        });
  }
}
