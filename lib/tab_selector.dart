import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/screens/home_screen.dart';
import 'package:learn_europe/screens/profile_screen.dart';
import 'package:learn_europe/stores/navigation_store.dart';
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
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
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
        backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? AppColors.darkNavigation
            : AppColors.lightNavigation,
        selectedItemColor: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? AppColors.primaryColorDark
            : AppColors.primaryColorLight,
        unselectedItemColor: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? AppColors.lightNavigation
            : AppColors.darkNavigation,
        selectedLabelStyle: TextStyle(),
        unselectedLabelStyle: TextStyle(),
        iconSize: AppPaddings.padding_24,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: AppStrings.navHome,
            icon: Icon(navigationStore.currentIndex == 0 ? Icons.dashboard : Icons.dashboard_outlined),
          ),
          BottomNavigationBarItem(
            label: AppStrings.navProfile,
            icon: Icon(navigationStore.currentIndex == 1 ? Icons.account_circle : Icons.account_circle_outlined),
          ),
        ],
        currentIndex: navigationStore.currentIndex,
        onTap: (index) {
          navigationStore.switchScreen(index);
        });
  }
}
