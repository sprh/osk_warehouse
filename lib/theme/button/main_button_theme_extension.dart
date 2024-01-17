import 'package:flutter/material.dart';

import '../text/text_theme_extension.dart';
import 'button_theme_extension.dart';

final class MainButtonThemeExtension
    extends ThemeExtension<MainButtonThemeExtension>
    implements ButtonThemeExtension {
  static final light = MainButtonThemeExtension(
    backgroundColor: const Color(0xFFFFCFA3),
    disabledBackgroundColor: const Color(0xFFFFF0E3),
    disabledTextColor: TextThemeExtension.light.minorText,
    borderColor: Colors.transparent,
  );

  static final dark = light;

  @override
  final Color backgroundColor;
  @override
  final Color disabledBackgroundColor;
  @override
  final Color disabledTextColor;
  @override
  final Color borderColor;

  const MainButtonThemeExtension({
    required this.backgroundColor,
    required this.disabledBackgroundColor,
    required this.disabledTextColor,
    required this.borderColor,
  });

  @override
  ThemeExtension<MainButtonThemeExtension> lerp(
    covariant ThemeExtension<MainButtonThemeExtension>? other,
    double t,
  ) =>
      this;

  @override
  ThemeExtension<MainButtonThemeExtension> copyWith({
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    Color? disabledTextColor,
    Color? borderColor,
  }) =>
      MainButtonThemeExtension(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        disabledBackgroundColor:
            disabledBackgroundColor ?? this.disabledBackgroundColor,
        disabledTextColor: disabledTextColor ?? this.disabledTextColor,
        borderColor: borderColor ?? this.borderColor,
      );
}
