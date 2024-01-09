import 'package:flutter/material.dart';

import 'action_block/action_block_theme_extension.dart';
import 'button/main_button_theme_extension.dart';
import 'scaffold/scaffold_theme_extension.dart';
import 'text/text_theme_extension.dart';
import 'text_field/text_field_theme_extension.dart';

class ThemeConstants {
  ThemeConstants._();

  static const fontFamily = 'Nunito';

  static final List<ThemeExtension> extensionsLight = [
    TextThemeExtension.light,
    MainButtonThemeExtension.light,
    TextFieldThemeExtension.light,
    ScaffoldThemeExtension.light,
    ActionBlockThemeExtension.light,
  ];

  static final List<ThemeExtension> extensionsDark = [
    TextThemeExtension.dark,
    MainButtonThemeExtension.dark,
    TextFieldThemeExtension.dark,
    ScaffoldThemeExtension.dark,
    ActionBlockThemeExtension.dark,
  ];
}
