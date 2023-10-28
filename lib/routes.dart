import 'package:aravind/views/homeDataScreen.dart';
import 'package:flutter/material.dart';
class AppRoutes {
  Map<String, Widget Function(BuildContext)> get(BuildContext context) {
    return {
      HomeDataScreen.routeName: (context) => const HomeDataScreen(),
    };
  }
}
