import 'package:flutter/material.dart';
import 'package:learn_europe/constants/textstyles.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    this.title,
    this.centerTitle,
    this.leadingIcon,
    this.leadingIconAction,
    this.actions,
  });

  final String? title;
  final bool? centerTitle;
  final IconData? leadingIcon;
  final VoidCallback? leadingIconAction;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      forceMaterialTransparency: true,
      elevation: 0,
      title: title != null ? Text(title!) : null,
      centerTitle: centerTitle,
      titleSpacing: 0,
      titleTextStyle: AppTextStyles.appBarTextStyle(brightness: MediaQuery.of(context).platformBrightness),
      leading: leadingIcon != null
          ? GestureDetector(
              onTap: leadingIconAction,
              child: Icon(leadingIcon),
            )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
