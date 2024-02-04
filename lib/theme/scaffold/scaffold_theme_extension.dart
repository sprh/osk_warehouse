import 'package:flutter/material.dart';

class ScaffoldThemeExtension extends ThemeExtension<ScaffoldThemeExtension> {
  final Color backgroundColor;
  final Color floatingActionsBackgroundColor;
  final Color actionsShadow;

  static const light = ScaffoldThemeExtension(
    backgroundColor: Color(0xFFFFFFFF),
    floatingActionsBackgroundColor: Color(0xFFFFFFFF),
    actionsShadow: Color(0xFFCCC7C7),
  );

  static const dark = light;

  const ScaffoldThemeExtension({
    required this.backgroundColor,
    required this.floatingActionsBackgroundColor,
    required this.actionsShadow,
  });

  @override
  ThemeExtension<ScaffoldThemeExtension> copyWith({
    Color? backgroundColor,
    Color? floatingActionsBackgroundColor,
    Color? actionsShadow,
  }) =>
      ScaffoldThemeExtension(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        floatingActionsBackgroundColor: floatingActionsBackgroundColor ??
            this.floatingActionsBackgroundColor,
        actionsShadow: actionsShadow ?? this.actionsShadow,
      );

  @override
  ThemeExtension<ScaffoldThemeExtension> lerp(
    covariant ThemeExtension<ScaffoldThemeExtension>? other,
    double t,
  ) =>
      this;
}
