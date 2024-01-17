import 'package:flutter/material.dart';

import 'action_block/action_block_theme_extension.dart';
import 'button/main_button_theme_extension.dart';
import 'button/minor_button_theme_extension.dart';
import 'dropdown/dropdown_theme_extension.dart';
import 'icon_button/icon_button_theme_extension.dart';
import 'line_divider/line_divider_theme_extension.dart';
import 'modal_dialog/modal_dialog_theme_extension.dart';
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
    IconButtonThemeExtension.light,
    LineDividerThemeExtension.light,
    DropdownThemeExtension.light,
    MinorButtonThemeExtension.light,
    ModalDialogThemeExtension.light,
  ];

  static final List<ThemeExtension> extensionsDark = [
    TextThemeExtension.dark,
    MainButtonThemeExtension.dark,
    TextFieldThemeExtension.dark,
    ScaffoldThemeExtension.dark,
    ActionBlockThemeExtension.dark,
    IconButtonThemeExtension.dark,
    LineDividerThemeExtension.dark,
    DropdownThemeExtension.dark,
    MinorButtonThemeExtension.dark,
    ModalDialogThemeExtension.dark,
  ];
}
