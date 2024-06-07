import 'package:flutter/material.dart';

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
      elevation: 0,
      title: title != null ? Text(title!) : null,
      centerTitle: centerTitle,
      //titleTextStyle: TextStyle(fontSize: 20, color: Colors.black),
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
