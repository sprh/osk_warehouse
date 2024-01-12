import 'package:flutter/material.dart';

class OskLineDivider extends StatelessWidget {
  final bool withMargin;

  const OskLineDivider({this.withMargin = false});

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          color: Color(0xFFA3A3A3).withOpacity(0.5),
          height: 0.5,
        ),
      );
}
