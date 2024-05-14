import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:osk_warehouse/common/components/text/osk_text.dart';
import 'package:osk_warehouse/common/theme/text/text_theme_extension.dart';

import '../common.dart';

void main() {
  testWidgets('OskText displays text with specified style',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      makeTestableWidget(
        child: OskText.title1(
          text: 'Test Text',
          fontWeight: OskfontWeight.bold,
          textAlign: TextAlign.center,
        ),
      ),
    );

    expect(find.text('Test Text'), findsOneWidget);

    final textWidget = tester.widget<Text>(find.text('Test Text'));
    expect(textWidget.style!.fontSize, 20);
    expect(textWidget.style!.fontWeight, FontWeight.bold);

    expect(
      textWidget.style!.color,
      TextThemeExtension.light.mainText,
    );

    expect(textWidget.textAlign, TextAlign.center);
  });
}
