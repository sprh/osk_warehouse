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

      await tester.tap(find.byType(OskIconButton));
      await tester.pump();
    });
  });
}
