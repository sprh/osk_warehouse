import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:osk_warehouse/common/components/info_slot/osk_info_slot.dart';
import 'package:osk_warehouse/common/theme/theme_constants.dart';

void main() {
  testWidgets('OskInfoSlot displays title and content correctly',
      (WidgetTester tester) async {
    const testTitle = 'Test Title';
    const testContent = 'Test Content';

    await tester.pumpWidget(
      MaterialApp(
        home: Theme(
          data: ThemeData(
            extensions: ThemeConstants.extensionsLight,
          ),
          child: Scaffold(
            body: OskInfoSlot(
              title: testTitle,
              subtitle: testContent,
              onTap: () {},
            ),
          ),
        ),
      ),
    );

    expect(
      find.text(testTitle),
      findsOneWidget,
      reason: 'The title should be displayed',
    );
    expect(
      find.text(testContent),
      findsOneWidget,
      reason: 'The content should be displayed',
    );
  });
}
