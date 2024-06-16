import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoProvider with ChangeNotifier {
  PackageInfoProvider() {
    loadAppName();
  }

  String _appName = '';

  String get appName => _appName;

  Future<String> loadAppName() async {
    final info = await PackageInfo.fromPlatform();
    _appName = info.appName;
    notifyListeners();
    return _appName;
  }
}
