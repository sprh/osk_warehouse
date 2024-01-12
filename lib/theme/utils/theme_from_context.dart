import 'package:flutter/material.dart';

import '../action_block/action_block_theme_extension.dart';
import '../button/main_button_theme_extension.dart';
import '../dropdown/dropdown_theme_extension.dart';
import '../icon_button/icon_button_theme_extension.dart';
import '../scaffold/scaffold_theme_extension.dart';
import '../text/text_theme_extension.dart';
import '../text_field/text_field_theme_extension.dart';

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

  IconButtonThemeExtension get iconButtonTheme =>
      Theme.of(this).extension<IconButtonThemeExtension>()!;

  DropdownThemeExtension get dropdown =>
      Theme.of(this).extension<DropdownThemeExtension>()!;
}
