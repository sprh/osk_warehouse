import 'package:flutter/material.dart';
import 'package:osk_warehouse/theme/button/main_button_theme_extension.dart';
import 'package:osk_warehouse/theme/text/text_theme_extension.dart';

extension ThemeFromContext on BuildContext {
  TextThemeExtension get textTheme =>
      Theme.of(this).extension<TextThemeExtension>()!;

  MainButtonThemeExtension get mainButtonTheme =>
      Theme.of(this).extension<MainButtonThemeExtension>()!;
}
