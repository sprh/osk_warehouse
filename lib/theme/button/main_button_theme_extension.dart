import 'package:flutter/material.dart';
import 'package:osk_warehouse/theme/button/button_theme_extension.dart';
import 'package:osk_warehouse/theme/text/text_theme_extension.dart';

final class MainButtonThemeExtension
    extends ThemeExtension<MainButtonThemeExtension>
    implements ButtonThemeExtension {
  static final light = MainButtonThemeExtension(
    backgroundColor: Color(0xFFFFCFA3),
    disabledBackgroundColor: Color(0xFFFFF0E3),
    textColor: TextThemeExtension.light.mainText,
    disabledTextColor: TextThemeExtension.light.minorText,
  );

  static final dark = light;

  final Color backgroundColor;
  final Color disabledBackgroundColor;
  final Color textColor;
  final Color disabledTextColor;

  const MainButtonThemeExtension({
    required this.backgroundColor,
    required this.disabledBackgroundColor,
    required this.textColor,
    required this.disabledTextColor,
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
    Color? textColor,
    Color? disabledTextColor,
  }) =>
      MainButtonThemeExtension(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        disabledBackgroundColor:
            disabledBackgroundColor ?? this.disabledBackgroundColor,
        textColor: textColor ?? this.textColor,
        disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      );
}
