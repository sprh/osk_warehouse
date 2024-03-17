import 'package:flutter/material.dart';

import '../../../../../common/components/text/osk_text.dart';
import '../../../../../common/utils/date_time_formatted.dart';
import '../../../../../theme/utils/theme_from_context.dart';
import '../../../../../utils/kotlin_utils.dart';
import '../../../models/application/application_status.dart';

class ApplicationInfoStatus extends StatelessWidget {
  final ApplicationStatus status;
  final DateTime? updatedAt;
  final DateTime createdAt;

  const ApplicationInfoStatus({
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    super.key,
  });

  String _statusName(Locale? locale) {
    switch (status) {
      case ApplicationStatus.pending:
        final date = DateTimeFormatter.formatDate(
          date: createdAt,
          outputFormat: DateTimeFormatter.dayFullMonth,
          locale: locale,
        );
        return 'В ожидании с $date';
      case ApplicationStatus.success:
        final date = updatedAt?.let(
          (date) => DateTimeFormatter.formatDate(
            date: date,
            outputFormat: DateTimeFormatter.dayFullMonth,
            locale: locale,
          ),
        );
        return "Подтверждена ${date ?? ''}";
      case ApplicationStatus.rejected:
        final date = updatedAt?.let(
          (date) => DateTimeFormatter.formatDate(
            date: date,
            outputFormat: DateTimeFormatter.dayFullMonth,
            locale: locale,
          ),
        );
        return "Отклонена ${date ?? ''}";
      case ApplicationStatus.deleted:
        final date = updatedAt?.let(
          (date) => DateTimeFormatter.formatDate(
            date: date,
            outputFormat: DateTimeFormatter.dayFullMonth,
            locale: locale,
          ),
        );
        return "Удалена ${date ?? ''}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.requestInfoTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.iconColor.fromStatus(
              status,
            ),
          ),
          child: const SizedBox.square(dimension: 8),
        ),
        const SizedBox(width: 4),
        OskText.caption(text: _statusName(Localizations.localeOf(context))),
      ],
    );
  }
}
