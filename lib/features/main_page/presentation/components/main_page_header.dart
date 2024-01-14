import 'package:flutter/material.dart';

import '../../../../components/text/osk_text.dart';
import '../../../../l10n/utils/l10n_from_context.dart';

class MainPageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Padding(
      padding: EdgeInsets.only(left: 24),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OskText.body(
              text: strings.mainPageHi,
              colorType: OskTextColorType.highlightedYellow,
              fontWeight: OskfontWeight.medium,
            ),
            SizedBox(height: 4),
            OskText.body(
              text: 'Марина Марьина',
              colorType: OskTextColorType.main,
              fontWeight: OskfontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
