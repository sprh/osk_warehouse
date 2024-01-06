import 'package:flutter/material.dart';
import 'package:osk_warehouse/theme/button/main_button_theme_extension.dart';
import 'package:osk_warehouse/theme/text/text_theme_extension.dart';

class ThemeConstants {
  ThemeConstants._();

  static const fontFamily = 'Nunito';

  static final List<ThemeExtension> extensionsLight = [
    TextThemeExtension.light,
    MainButtonThemeExtension.light,
  ];

  static final extensionsDark = extensionsLight;
}
