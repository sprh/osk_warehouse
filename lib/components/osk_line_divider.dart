import 'package:flutter/material.dart';

class OskLineDivider extends StatelessWidget {
  final bool withMargin;

  const OskLineDivider({
    this.withMargin = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: withMargin
            ? const EdgeInsets.symmetric(horizontal: 16)
            : EdgeInsets.zero,
        child: Container(
          color: const Color(0xFFA3A3A3).withOpacity(0.5),
          height: 0.5,
        ),
      );
}
