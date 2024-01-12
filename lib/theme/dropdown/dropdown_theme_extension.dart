import 'package:flutter/material.dart';

class DropdownThemeExtension extends ThemeExtension<DropdownThemeExtension> {
  final Color borderSideColor;
  final Color checkboxBackground;
  final Color checkboxActiveBackground;

  static const light = DropdownThemeExtension(
    borderSideColor: Color(0xFFAEAEAE),
    checkboxActiveBackground: Colors.white,
    checkboxBackground: Color(0xFFFFCFA3),
  );

  static const dark = light;

  const DropdownThemeExtension({
    required this.borderSideColor,
    required this.checkboxBackground,
    required this.checkboxActiveBackground,
  });

  @override
  ThemeExtension<DropdownThemeExtension> copyWith() => this;

  @override
  ThemeExtension<DropdownThemeExtension> lerp(
    covariant ThemeExtension<DropdownThemeExtension>? other,
    double t,
  ) =>
      this;
}
