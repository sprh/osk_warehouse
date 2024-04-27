import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:osk_warehouse/common/components/text/osk_text.dart';
import 'package:osk_warehouse/common/theme/text/text_theme_extension.dart';

import '../common.dart';

void main() {
  testWidgets('OskText displays text with specified style',
      (WidgetTester tester) async {
    // Build the OskText widget
    await tester.pumpWidget(
      makeTestableWidget(
        child: OskText.title1(
          text: 'Test Text',
          fontWeight: OskfontWeight.bold,
          textAlign: TextAlign.center,
        ),
      ),
    );

    // Find the text widget
    expect(find.text('Test Text'), findsOneWidget);

    // Verify text style
    final textWidget = tester.widget<Text>(find.text('Test Text'));
    expect(textWidget.style!.fontSize, 20);
    expect(textWidget.style!.fontWeight, FontWeight.bold);
    // You may need to adjust the color comparison based on your test setup
    expect(
      textWidget.style!.color,
      TextThemeExtension.light.mainText,
    ); // Replace with your expected color

    // Verify text alignment
    expect(textWidget.textAlign, TextAlign.center);
  });
}
