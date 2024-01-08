import 'package:flutter/material.dart';
import 'package:osk_warehouse/theme/action_block/action_block_theme_extension.dart';
import 'package:osk_warehouse/theme/button/main_button_theme_extension.dart';
import 'package:osk_warehouse/theme/scaffold/scaffold_theme_extension.dart';
import 'package:osk_warehouse/theme/text/text_theme_extension.dart';
import 'package:osk_warehouse/theme/text_field/text_field_theme_extension.dart';

extension ThemeFromContext on BuildContext {
  TextThemeExtension get textTheme =>
      Theme.of(this).extension<TextThemeExtension>()!;

  MainButtonThemeExtension get mainButtonTheme =>
      Theme.of(this).extension<MainButtonThemeExtension>()!;

  TextFieldThemeExtension get textFiledTheme =>
      Theme.of(this).extension<TextFieldThemeExtension>()!;

  ScaffoldThemeExtension get scaffoldTheme =>
      Theme.of(this).extension<ScaffoldThemeExtension>()!;

  ActionBlockThemeExtension get actionBlockTheme =>
      Theme.of(this).extension<ActionBlockThemeExtension>()!;
}
