import 'package:flutter/material.dart';
import 'package:osk_warehouse/theme/utils/theme_from_context.dart';

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

class OskText extends StatelessWidget {
  final String text;
  final OskfontWeight fontWeight;
  final bool minorText;
  final double fontSize;

  const OskText._({
    required this.text,
    required this.fontWeight,
    required this.fontSize,
    required this.minorText,
    super.key,
  });

  factory OskText.header({
    required String text,
    OskfontWeight fontWeight = OskfontWeight.regular,
    bool minorText = false,
    Key? key,
  }) =>
      OskText._(
        text: text,
        fontWeight: fontWeight,
        fontSize: 24,
        minorText: minorText,
        key: key,
      );

  factory OskText.title1({
    required String text,
    OskfontWeight fontWeight = OskfontWeight.regular,
    bool minorText = false,
    Key? key,
  }) =>
      OskText._(
        text: text,
        fontWeight: fontWeight,
        fontSize: 18,
        minorText: minorText,
        key: key,
      );

  factory OskText.title2({
    required String text,
    OskfontWeight fontWeight = OskfontWeight.regular,
    bool minorText = false,
    Key? key,
  }) =>
      OskText._(
        text: text,
        fontWeight: fontWeight,
        fontSize: 16,
        minorText: minorText,
        key: key,
      );

  factory OskText.body({
    required String text,
    OskfontWeight fontWeight = OskfontWeight.regular,
    bool minorText = false,
    Key? key,
  }) =>
      OskText._(
        text: text,
        fontWeight: fontWeight,
        fontSize: 14,
        minorText: minorText,
        key: key,
      );

  factory OskText.caption({
    required String text,
    OskfontWeight fontWeight = OskfontWeight.regular,
    bool minorText = false,
    Key? key,
  }) =>
      OskText._(
        text: text,
        fontWeight: fontWeight,
        fontSize: 12,
        minorText: minorText,
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
        color: minorText ? theme.minorText : theme.mainText,
      ),
    );
  }
}
