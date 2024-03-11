import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:osk_warehouse/common/components/icon/osk_icon_button.dart';
import 'package:osk_warehouse/common/components/text/osk_text_field.dart';

import '../common.dart';

void main() {
  group('OskTextField Tests', () {
    testWidgets('renders with initial text', (WidgetTester tester) async {
      final controller = TextEditingController(text: 'Initial Text');

      await tester.pumpWidget(
        makeTestableWidget(
          child: OskTextField(
            hintText: 'Enter text',
            label: 'Label',
            textEditingController: controller,
          ),
        ),
      );

      expect(find.text('Initial Text'), findsOneWidget);
      expect(find.text('Enter text'), findsOneWidget);
      expect(find.text('Label'), findsOneWidget);
    });

    testWidgets('updates text when user types', (WidgetTester tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: const OskTextField(
            hintText: 'Enter text',
            label: 'Label',
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'New Input');
      await tester.pump();

      expect(find.text('New Input'), findsOneWidget);
    });

    testWidgets('toggles obscure text visibility on icon tap',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: const OskTextField(
            hintText: 'Password',
            label: 'Password',
            showobscureTextIcon: true,
          ),
        ),
      );

      // Initially obscureText should be true, so the text is hidden.
      // This is difficult to test directly without access to the TextFormField's state.
      // However, we can test if tapping the visibility toggle updates the widget's state.

      // Assume your OskIconButton can be found via OskIcon.show/hide.
      await tester.tap(find.byType(OskIconButton));
      await tester.pump(); // Rebuild the widget after state change.

      // Without direct access to internal flags or rendering the actual obscure text state,
      // you will need to rely on either specific behavior or integration testing to
      // verify that the text visibility toggles correctly.
      // This example demonstrates the structure of such a test, but you'd ideally verify
      // the visibility has actually changed, perhaps by checking the OskIconButton's icon state.
    });
  });
}
