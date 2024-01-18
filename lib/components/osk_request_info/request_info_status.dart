import 'package:flutter/material.dart';

import '../../features/requests/models/request.dart';
import '../../theme/utils/theme_from_context.dart';
import '../text/osk_text.dart';

class OskRequestInfoStatus extends StatelessWidget {
  final RequestStatus status;

  const OskRequestInfoStatus({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.requestInfoTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.iconColor.fromRequestStatus(
              status,
            ),
          ),
          child: const SizedBox.square(dimension: 8),
        ),
        const SizedBox(width: 4),
        OskText.caption(text: status.name), // TODO
      ],
    );
  }
}
