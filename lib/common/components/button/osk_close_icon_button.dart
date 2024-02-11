import 'package:flutter/material.dart';

import '../../../theme/utils/theme_from_context.dart';
import '../icon/osk_icon_button.dart';
import '../icon/osk_icons.dart';

class OskCloseIconButton extends StatelessWidget {
  final VoidCallback? onClose;

  const OskCloseIconButton({
    this.onClose,
    super.key,
  });

  @override
  Widget build(BuildContext context) => OskIconButton(
        icon: const OskIcon.close(),
        onTap: onClose ?? Navigator.of(context).maybePop,
        backgroundColor: context.textTheme.minorText.withOpacity(0.3),
      );
}
