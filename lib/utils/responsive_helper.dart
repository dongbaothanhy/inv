import 'package:flutter/material.dart';

class ResponsiveHelper {
  static double getAdaptiveValue({
    BuildContext? context,
    required double desktop,
    required double mobile,
  }) {
    if (context == null) return mobile;
    return MediaQuery.of(context).size.width > 600 ? desktop : mobile;
  }
}
