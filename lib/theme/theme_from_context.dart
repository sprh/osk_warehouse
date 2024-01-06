import 'package:flutter/material.dart';
import 'package:osk_warehouse/theme/text_theme_extension.dart';

extension ThemeFromContext on BuildContext {
  TextThemeExtension get textTheme =>
      Theme.of(this).extension<TextThemeExtension>()!;
}
