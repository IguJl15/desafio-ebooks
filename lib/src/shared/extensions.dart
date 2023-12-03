import 'package:flutter/material.dart';

extension EasyTheme on BuildContext {
  ThemeData get themeData => Theme.of(this);
}

extension EdgeInsetsExtension on EdgeInsets {
  static EdgeInsets centerOnBoxConstraints({
    required BoxConstraints constraints,
    required double maxWidth,
  }) =>
      EdgeInsets.symmetric(
        horizontal: (constraints.maxWidth - maxWidth).clamp(0, double.maxFinite) / 2,
      );
}
