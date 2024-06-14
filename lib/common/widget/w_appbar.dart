import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../provider/package_info_provider.dart';

class SimpleAppBar extends StatefulWidget {
  const SimpleAppBar({super.key});

  @override
  State<SimpleAppBar> createState() => _SimpleAppBarState();
}

class _SimpleAppBarState extends State<SimpleAppBar> {
  @override
  Widget build(BuildContext context) {
    final appName =
        Provider.of<PackageInfoProvider>(context, listen: false).appName;
    return AppBar(
      elevation: 2,
      backgroundColor: Colors.white,
      title: appName.text.make(),
      shadowColor: Colors.black,
    );
  }
}
