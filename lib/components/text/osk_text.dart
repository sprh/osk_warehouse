import 'package:flutter/material.dart';

import '../../theme/text/text_theme_extension.dart';
import '../../theme/utils/theme_from_context.dart';

enum OskfontWeight {
  regular,
  medium,
  bold;

  FontWeight get fontWeight {
    switch (this) {
      case OskfontWeight.regular:
        return FontWeight.normal;
      case OskfontWeight.medium:
        return FontWeight.w500;
      case OskfontWeight.bold:
        return FontWeight.bold;
    }
  }
}

enum OskTextColorType {
  main,
  minor,
  highlightedYellow;

  Color colorFromTheme(TextThemeExtension textTheme) {
    switch (this) {
      case OskTextColorType.main:
        return textTheme.mainText;
      case OskTextColorType.minor:
        return textTheme.minorText;
      case OskTextColorType.highlightedYellow:
        return textTheme.highlightedYellow;
    }
  }
}

class OskText extends StatelessWidget {
  final String text;
  final OskfontWeight fontWeight;
  final OskTextColorType colorType;
  final double fontSize;
  final TextAlign textAlign;
  final int? maxLines;

  const OskText._({
    required this.text,
    required this.fontWeight,
    required this.fontSize,
    required this.colorType,
    required this.textAlign,
    this.maxLines,
    super.key,
  });

  factory OskText.header({
    required String text,
    OskfontWeight fontWeight = OskfontWeight.regular,
    OskTextColorType colorType = OskTextColorType.main,
    TextAlign textAlign = TextAlign.start,
    Key? key,
  }) =>
      OskText._(
        text: text,
        fontWeight: fontWeight,
        fontSize: 24,
        colorType: colorType,
        textAlign: textAlign,
        key: key,
      );

  factory OskText.title1({
    required String text,
    OskfontWeight fontWeight = OskfontWeight.regular,
    OskTextColorType colorType = OskTextColorType.main,
    TextAlign textAlign = TextAlign.start,
    Key? key,
  }) =>
      OskText._(
        text: text,
        fontWeight: fontWeight,
        fontSize: 20,
        colorType: colorType,
        textAlign: textAlign,
        key: key,
      );

  factory OskText.title2({
    required String text,
    OskfontWeight fontWeight = OskfontWeight.regular,
    OskTextColorType colorType = OskTextColorType.main,
    TextAlign textAlign = TextAlign.start,
    Key? key,
  }) =>
      OskText._(
        text: text,
        fontWeight: fontWeight,
        fontSize: 18,
        colorType: colorType,
        textAlign: textAlign,
        key: key,
      );

  factory OskText.body({
    required String text,
    OskfontWeight fontWeight = OskfontWeight.regular,
    OskTextColorType colorType = OskTextColorType.main,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    Key? key,
  }) =>
      OskText._(
        text: text,
        fontWeight: fontWeight,
        fontSize: 16,
        colorType: colorType,
        textAlign: textAlign,
        maxLines: maxLines,
        key: key,
      );

  factory OskText.caption({
    required String text,
    OskfontWeight fontWeight = OskfontWeight.regular,
    OskTextColorType colorType = OskTextColorType.main,
    TextAlign textAlign = TextAlign.start,
    Key? key,
  }) =>
      OskText._(
        text: text,
        fontWeight: fontWeight,
        fontSize: 14,
        colorType: colorType,
        textAlign: textAlign,
        key: key,
      );

  @override
  Widget build(BuildContext context) {
    final theme = context.textTheme;

    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight.fontWeight,
        color: colorType.colorFromTheme(theme),
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
