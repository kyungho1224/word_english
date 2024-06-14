import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/package_info_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    this.title,
    this.showBackButton = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final appName = Provider.of<PackageInfoProvider>(context, listen: false).appName;
    return AppBar(
      elevation: 2,
      backgroundColor: Colors.white,
      shadowColor: Colors.black,
      title: Text(title ?? appName),
      centerTitle: false,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
