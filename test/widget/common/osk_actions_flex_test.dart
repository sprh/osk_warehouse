import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:osk_warehouse/common/components/actions/actions_flex.dart';

import '../common.dart';

void main() {
  testWidgets(
    'OskActionsFlex widget test',
    (WidgetTester tester) async {
      final testWidgets = [
        const Text('Widget 1'),
        const Text('Widget 2'),
        const Text('Widget 3'),
      ];

      await tester.pumpWidget(
        makeTestableWidget(
          child: OskActionsFlex(
            widgets: testWidgets,
            direction: Axis.vertical,
            maxWidth: 200,
          ),
        ),
      );

      final text1Finder = find.text('Widget 1');
      final text2Finder = find.text('Widget 2');
      final text3Finder = find.text('Widget 3');

      expect(text1Finder, findsOneWidget);
      expect(text2Finder, findsOneWidget);
      expect(text3Finder, findsOneWidget);

      final flexWidget = find.byType(OskActionsFlex);

      expect(flexWidget, findsOneWidget);
    },
  );
}
