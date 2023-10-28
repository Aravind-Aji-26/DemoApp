import 'package:flutter/material.dart';
import 'package:sugandh/views/homeDataScreen.dart';
class AppRoutes {
  Map<String, Widget Function(BuildContext)> get(BuildContext context) {
    return {
      HomeDataScreen.routeName: (context) => const HomeDataScreen(),
    };
  }
}
