import 'package:flutter/material.dart';

import '../../features/requests/models/request.dart';

class OskRequestInfoThemeExtension
    extends ThemeExtension<OskRequestInfoThemeExtension> {
  final Color background;
  final Color shadow;
  final RequestStatusIconColor iconColor;

  static const light = OskRequestInfoThemeExtension(
    background: Color(0xFFFFFFFF),
    shadow: Color(0xFFE3E3E3),
    iconColor: RequestStatusIconColor(
      accepted: Color(0xFFAEFF47),
      cancelled: Color(0xFFE3E3E3),
      waiting: Color(0xFFFFCE38),
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
  final Color cancelled;
  final Color accepted;
  final Color waiting;
  final Color rejected;

  const RequestStatusIconColor({
    required this.cancelled,
    required this.accepted,
    required this.waiting,
    required this.rejected,
  });

  Color fromRequestStatus(RequestStatus status) {
    switch (status) {
      case RequestStatus.waiting:
        return waiting;
      case RequestStatus.cancelled:
        return cancelled;
      case RequestStatus.rejected:
        return rejected;
      case RequestStatus.accepted:
        return accepted;
    }
  }
}
