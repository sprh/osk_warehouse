import 'package:flutter/material.dart';

import '../../../features/requests/models/request.dart';
import '../../../theme/utils/theme_from_context.dart';
import '../osk_line_divider.dart';
import '../tap/osk_tap_animation.dart';
import '../text/osk_text.dart';
import 'request_info_status.dart';

class OskRequestInfo extends StatelessWidget {
  final Request request;
  final VoidCallback onTap;

  const OskRequestInfo({
    required this.request,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.requestInfoTheme;
    final size = MediaQuery.of(context).size;

    return OskTapAnimationBuilder(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: theme.shadow, blurRadius: 8),
          ],
          color: theme.background,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: size.width / 10 * 9,
            maxWidth: size.width / 10 * 9,
            minHeight: size.height / 12,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                OskText.body(
                  text: 'Заявка #${request.id}',
                  fontWeight: OskfontWeight.bold,
                ),
                OskRequestInfoStatus(status: request.status),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: OskLineDivider(),
                ),
                // OskText.body(text: request.worker.name),
                const SizedBox(height: 8),
                OskText.body(text: request.description, maxLines: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
