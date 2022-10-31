import 'dart:io';

import 'package:flutter/foundation.dart';

enum AppPlatform {
  mobile('http://10.0.2.2:8080', 'home'),
  web('http://localhost:8080', 'admin'),
  desktop('http://localhost:8080', 'admin');

  const AppPlatform(this.baseUrl, this.defaultRoute);

  final String baseUrl;
  final String defaultRoute;

  static AppPlatform get current {
    if (kIsWeb) {
      return AppPlatform.web;
    } else if (Platform.isAndroid || Platform.isIOS) {
      return AppPlatform.mobile;
    }
    return AppPlatform.desktop;
  }

  bool get isMobile => this == AppPlatform.mobile;
}
