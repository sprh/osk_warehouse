import 'package:flutter/material.dart';

class ActionBlockThemeExtension
    extends ThemeExtension<ActionBlockThemeExtension> {
  final Color blockShadowColor;
  final Color blockBackgroundColor;

  final Color notificationIconBackgroundColor;
  final Color notificationIconBorderColor;

  static const light = ActionBlockThemeExtension(
    blockShadowColor: Color(0xFFE3E3E3),
    blockBackgroundColor: Color(0xFFFFFFFF),
    notificationIconBackgroundColor: Color(0xFFFFFFFF),
    notificationIconBorderColor: Color(0xFFAEAEAE),
  );

  static const dark = light;

  const ActionBlockThemeExtension({
    required this.blockBackgroundColor,
    required this.blockShadowColor,
    required this.notificationIconBackgroundColor,
    required this.notificationIconBorderColor,
  });

  @override
  ThemeExtension<ActionBlockThemeExtension> copyWith({
    Color? blockShadowColor,
    Color? blockBackgroundColor,
    Color? notificationIconBackgroundColor,
    Color? notificationIconBorderColor,
  }) =>
      ActionBlockThemeExtension(
        blockShadowColor: blockBackgroundColor ?? this.blockBackgroundColor,
        blockBackgroundColor: blockBackgroundColor ?? this.blockBackgroundColor,
        notificationIconBackgroundColor: notificationIconBackgroundColor ??
            this.notificationIconBackgroundColor,
        notificationIconBorderColor:
            notificationIconBorderColor ?? this.notificationIconBorderColor,
      );

  @override
  ThemeExtension<ActionBlockThemeExtension> lerp(
    covariant ThemeExtension<ActionBlockThemeExtension>? other,
    double t,
  ) =>
      this;
}
