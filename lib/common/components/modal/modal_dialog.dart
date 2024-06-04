import 'package:flutter/material.dart';

import '../../theme/utils/theme_from_context.dart';
import '../text/osk_text.dart';

class ModalDialog extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? actions;

  const ModalDialog({
    required this.title,
    this.subtitle,
    this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.modalDialogTheme.backgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OskText.title2(
                      text: title,
                      textAlign: TextAlign.center,
                      fontWeight: OskfontWeight.bold,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      OskText.body(
                        text: subtitle!,
                        textAlign: TextAlign.center,
                        fontWeight: OskfontWeight.medium,
                        colorType: OskTextColorType.minor,
                      ),
                    ],
                    const SizedBox(height: 10),
                    if (actions != null) actions!,
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
