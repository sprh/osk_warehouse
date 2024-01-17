import 'package:flutter/material.dart';

import '../action_block/action_block_theme_extension.dart';
import '../button/main_button_theme_extension.dart';
import '../button/minor_button_theme_extension.dart';
import '../checkbox/checkox_theme_extension.dart';
import '../dropdown/dropdown_theme_extension.dart';
import '../icon_button/icon_button_theme_extension.dart';
import '../modal_dialog/modal_dialog_theme_extension.dart';
import '../scaffold/scaffold_theme_extension.dart';
import '../text/text_theme_extension.dart';
import '../text_field/text_field_theme_extension.dart';

extension ThemeFromContext on BuildContext {
  ThemeData get _theme => Theme.of(this);

  TextThemeExtension get textTheme => _theme.extension()!;

  MainButtonThemeExtension get mainButtonTheme => _theme.extension()!;

  TextFieldThemeExtension get textFiledTheme => _theme.extension()!;

  ScaffoldThemeExtension get scaffoldTheme => _theme.extension()!;

  ActionBlockThemeExtension get actionBlockTheme => _theme.extension()!;

  IconButtonThemeExtension get iconButtonTheme => _theme.extension()!;

  DropdownThemeExtension get dropdownTheme => _theme.extension()!;

  MinorButtonThemeExtension get minorButtonTheme => _theme.extension()!;

  ModalDialogThemeExtension get modalDialogTheme => _theme.extension()!;

  CheckboxThemeExtension get checkboxTheme => _theme.extension()!;
}
