import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:osk_warehouse/common/components/modal/modal_dialog.dart';

import '../common.dart';

void main() {
  testWidgets(
    'ModalDialog displays title, subtitle, and actions',
    (WidgetTester tester) async {
      // Build the ModalDialog widget
      await tester.pumpWidget(
        makeTestableWidget(
          child: ModalDialog(
            title: 'Test Title',
            subtitle: 'Test Subtitle',
            actions: ElevatedButton(
              onPressed: () {},
              child: const Text('Action Button'),
            ),
          ),
        ),
      );

      // Find the title text widget
      expect(find.text('Test Title'), findsOneWidget);

      // Find the subtitle text widget
      expect(find.text('Test Subtitle'), findsOneWidget);

      // Find the action button widget
      expect(find.text('Action Button'), findsOneWidget);
    },
  );
}
