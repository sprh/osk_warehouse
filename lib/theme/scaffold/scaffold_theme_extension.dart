import 'package:flutter/material.dart';

class ScaffoldThemeExtension extends ThemeExtension<ScaffoldThemeExtension> {
  final Color backgroundColor;
  final Color floatingActionsBackgroundColor;

  static const light = ScaffoldThemeExtension(
    backgroundColor: Color(0xFFFFFFFF),
    floatingActionsBackgroundColor: Color(0xFFFFFFFF),
  );

  static const dark = light;

  const ScaffoldThemeExtension({
    required this.backgroundColor,
    required this.floatingActionsBackgroundColor,
  });

  @override
  ThemeExtension<ScaffoldThemeExtension> copyWith({
    Color? backgroundColor,
    Color? floatingActionsBackgroundColor,
  }) =>
      ScaffoldThemeExtension(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        floatingActionsBackgroundColor: floatingActionsBackgroundColor ??
            this.floatingActionsBackgroundColor,
      );

  @override
  ThemeExtension<ScaffoldThemeExtension> lerp(
    covariant ThemeExtension<ScaffoldThemeExtension>? other,
    double t,
  ) {
    // TODO: implement lerp
    throw UnimplementedError();
  }
}
