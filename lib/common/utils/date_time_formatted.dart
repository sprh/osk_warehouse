import 'dart:ui';

import 'package:intl/intl.dart';

class DateTimeFormatter {
  static const dayFullMonth = 'd MMMM';
  static const dayFullMonthYear = 'd MMMM yyyy';

  static const dayShortMonth = 'd MMM';
  static const dayShortMonthYear = 'd MMM yyyy';

  static String formatDate({
    required DateTime date,
    required String outputFormat,
    required Locale? locale,
  }) =>
      DateFormat(
        outputFormat,
        '${locale?.languageCode}-${locale?.countryCode}',
      ).format(date);

  static String formatSelectedPeriod({
    required DateTime currentDate,
    required List<DateTime> selectedPeriod,
    required Locale? locale,
  }) {
    switch (selectedPeriod.length) {
      case 1:
        final date = selectedPeriod.first;
        if (date.year == currentDate.year) {
          return formatDate(
            date: date,
            outputFormat: dayShortMonth,
            locale: locale,
          );
        } else {
          return formatDate(
            date: date,
            outputFormat: dayShortMonthYear,
            locale: locale,
          );
        }
      default:
        final start = selectedPeriod.first;
        final end = selectedPeriod.last;
        final String startDateFormat;
        final String endDateFormat;

        if (start.year == end.year) {
          startDateFormat = dayShortMonth;
          if (start.year == currentDate.year) {
            endDateFormat = dayShortMonthYear;
          } else {
            endDateFormat = dayShortMonthYear;
          }
        } else {
          startDateFormat = dayShortMonthYear;
          endDateFormat = dayShortMonthYear;
        }

        final startFormatted = formatDate(
          date: start,
          outputFormat: startDateFormat,
          locale: locale,
        );

        final endFormatted = formatDate(
          date: end,
          outputFormat: endDateFormat,
          locale: locale,
        );

        return '$startFormatted - $endFormatted';
    }
  }
}
