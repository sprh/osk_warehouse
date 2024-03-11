import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:osk_warehouse/common/components/checkbox/osk_checkbox.dart';

import '../common.dart';

void main() {
  testWidgets(
    'OskCheckbox renders correctly',
    (WidgetTester tester) async {
      // Create a test widget with OskCheckbox
      await tester.pumpWidget(
        makeTestableWidget(
          child: OskCheckbox(
            selected: false,
            onSelect: () {},
          ),
        ),
      );

      // Verify that the Checkbox is rendered
      expect(find.byType(Checkbox), findsOneWidget);

      // Verify that the Checkbox is initially unchecked
      expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, false);

      // Tap the Checkbox to select it
      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      // Verify that the Checkbox is still unselected
      expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, false);
    },
  );
}
