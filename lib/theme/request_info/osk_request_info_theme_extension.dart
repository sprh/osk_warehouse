import 'package:flutter/material.dart';

import '../../features/applications/models/application/application_status.dart';

class OskRequestInfoThemeExtension
    extends ThemeExtension<OskRequestInfoThemeExtension> {
  final Color background;
  final Color shadow;
  final RequestStatusIconColor iconColor;

  static const light = OskRequestInfoThemeExtension(
    background: Color(0xFFFFFFFF),
    shadow: Color(0xFFE3E3E3),
    iconColor: RequestStatusIconColor(
      deleted: Color(0xFFF0B9B8),
      pending: Color(0xFFC8A031),
      success: Color(0xFF186D19),
      rejected: Color(0xFFFF4757),
    ),
  );

  static const dark = light;

  const OskRequestInfoThemeExtension({
    required this.background,
    required this.shadow,
    required this.iconColor,
  });

  @override
  ThemeExtension<OskRequestInfoThemeExtension> copyWith() => this;

  @override
  ThemeExtension<OskRequestInfoThemeExtension> lerp(
    covariant ThemeExtension<OskRequestInfoThemeExtension>? other,
    double t,
  ) =>
      this;
}

class RequestStatusIconColor {
  final Color pending;
  final Color deleted;
  final Color success;
  final Color rejected;

  const RequestStatusIconColor({
    required this.pending,
    required this.deleted,
    required this.success,
    required this.rejected,
  });

  Color fromStatus(ApplicationStatus status) {
    switch (status) {
      case ApplicationStatus.pending:
        return success;
      case ApplicationStatus.deleted:
        return pending;
      case ApplicationStatus.rejected:
        return rejected;
      case ApplicationStatus.success:
        return deleted;
    }
  }
}
