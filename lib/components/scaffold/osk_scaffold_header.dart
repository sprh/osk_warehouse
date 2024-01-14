import 'package:flutter/material.dart';

import '../icon/osk_service_icons.dart';
import '../text/osk_text.dart';

class OskScaffoldHeader extends StatelessWidget {
  final OskServiceIcon icon;
  final String title;

  const OskScaffoldHeader({
    required this.icon,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 24),
          icon,
          SizedBox(width: 12),
          OskText.header(
            text: title,
            fontWeight: OskfontWeight.bold,
          ),
        ],
      );
}
