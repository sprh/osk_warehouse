import 'package:flutter/material.dart';

import 'button_theme_extension.dart';

final class MinorButtonThemeExtension
    extends ThemeExtension<MinorButtonThemeExtension>
    implements ButtonThemeExtension {
  static final light = MinorButtonThemeExtension(
    backgroundColor: Color(0xFFFFFFFF),
    disabledBackgroundColor: Color(0xFFCAC8C8),
    disabledTextColor: Color(0xFF787D80),
    borderColor: Color(0xFF515B60),
  );

  static final dark = light;

  final Color backgroundColor;
  final Color disabledBackgroundColor;
  final Color disabledTextColor;
  final Color borderColor;

  const MinorButtonThemeExtension({
    required this.backgroundColor,
    required this.disabledBackgroundColor,
    required this.disabledTextColor,
    required this.borderColor,
  });

  @override
  ThemeExtension<MinorButtonThemeExtension> lerp(
    covariant ThemeExtension<MinorButtonThemeExtension>? other,
    double t,
  ) =>
      this;

  @override
  ThemeExtension<MinorButtonThemeExtension> copyWith({
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    Color? disabledTextColor,
    Color? borderColor,
  }) =>
      MinorButtonThemeExtension(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        disabledBackgroundColor:
            disabledBackgroundColor ?? this.disabledBackgroundColor,
        disabledTextColor: disabledTextColor ?? this.disabledTextColor,
        borderColor: borderColor ?? this.borderColor,
      );
}
