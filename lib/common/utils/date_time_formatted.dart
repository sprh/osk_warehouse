import 'dart:ui';

import 'package:intl/intl.dart';

class DateTimeFormatter {
  static const dayFullMonth = 'd MMMM';
  static const dayFullMonthYear = 'd MMMM yyyy';

  static String formatDate({
    required DateTime date,
    required String outputFormat,
    required Locale? locale,
  }) =>
      DateFormat(
        outputFormat,
        '${locale?.languageCode}-${locale?.countryCode}',
      ).format(date);
}
