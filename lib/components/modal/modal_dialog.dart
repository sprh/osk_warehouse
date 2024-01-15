import 'package:flutter/material.dart';

import '../text/osk_text.dart';

class ModalDialog extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? actions;

  const ModalDialog({
    required this.title,
    this.subtitle,
    this.actions,
  });

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OskText.title2(
                      text: title,
                      textAlign: TextAlign.center,
                      fontWeight: OskfontWeight.bold,
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: 4),
                      OskText.caption(
                        text: subtitle!,
                        textAlign: TextAlign.center,
                        fontWeight: OskfontWeight.medium,
                        colorType: OskTextColorType.minor,
                      ),
                    ],
                    if (actions != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: actions,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
