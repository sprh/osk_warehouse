import 'package:flutter/material.dart';

import '../theme/utils/theme_from_context.dart';
import 'osk_icon_button.dart';
import 'osk_icons.dart';

class OskCloseIconButton extends StatelessWidget {
  final VoidCallback onClose;

  const OskCloseIconButton({
    required this.onClose,
    super.key,
  });

  @override
  Widget build(BuildContext context) => OskIconButton(
        icon: OskIcon.close(),
        onTap: onClose,
        backgroundColor: context.textTheme.minorText.withOpacity(0.3),
      );
}
