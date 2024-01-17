import 'package:flutter/material.dart';

class DropdownThemeExtension extends ThemeExtension<DropdownThemeExtension> {
  final Color borderSideColor;

  static const light = DropdownThemeExtension(
    borderSideColor: Color(0xFFAEAEAE),
  );

  static const dark = light;

  const DropdownThemeExtension({
    required this.borderSideColor,
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
