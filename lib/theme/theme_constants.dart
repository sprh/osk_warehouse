import 'package:flutter/material.dart';
import 'package:osk_warehouse/theme/button/main_button_theme_extension.dart';
import 'package:osk_warehouse/theme/scaffold/scaffold_theme_extension.dart';
import 'package:osk_warehouse/theme/text/text_theme_extension.dart';
import 'package:osk_warehouse/theme/text_field/text_field_theme_extension.dart';

class ThemeConstants {
  ThemeConstants._();

  static const fontFamily = 'Nunito';

  static final List<ThemeExtension> extensionsLight = [
    TextThemeExtension.light,
    MainButtonThemeExtension.light,
    TextFieldThemeExtension.light,
    ScaffoldThemeExtension.light,
  ];

  static final List<ThemeExtension> extensionsDark = [
    TextThemeExtension.dark,
    MainButtonThemeExtension.dark,
    TextFieldThemeExtension.dark,
    ScaffoldThemeExtension.dark,
  ];
}
