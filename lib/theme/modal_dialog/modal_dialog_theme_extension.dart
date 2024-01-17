import 'package:flutter/material.dart';

class ModalDialogThemeExtension
    extends ThemeExtension<ModalDialogThemeExtension> {
  final Color backgroundColor;
  final Color barrierColor;

  static final light = ModalDialogThemeExtension(
    backgroundColor: Color(0xFFFFFFFF),
    barrierColor: Colors.black.withOpacity(0.5),
  );

  static final dark = light;

  const ModalDialogThemeExtension({
    required this.backgroundColor,
    required this.barrierColor,
  });

  @override
  ThemeExtension<ModalDialogThemeExtension> copyWith({
    Color? backgroundColor,
    Color? barrierColor,
  }) =>
      ModalDialogThemeExtension(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        barrierColor: barrierColor ?? this.barrierColor,
      );

  @override
  ThemeExtension<ModalDialogThemeExtension> lerp(
    covariant ThemeExtension<ModalDialogThemeExtension>? other,
    double t,
  ) =>
      this;
}
