import 'package:flutter/material.dart';

import '../../../../common/components/text/osk_text.dart';
import '../../../../l10n/utils/l10n_from_context.dart';

class MainPageHeader extends StatelessWidget {
  final String name;

  const MainPageHeader({required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OskText.body(
              text: strings.mainPageHi,
              colorType: OskTextColorType.highlightedYellow,
              fontWeight: OskfontWeight.medium,
            ),
            const SizedBox(height: 4),
            OskText.body(
              text: name,
              fontWeight: OskfontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
