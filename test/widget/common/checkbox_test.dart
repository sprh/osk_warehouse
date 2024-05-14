import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:osk_warehouse/common/components/checkbox/osk_checkbox.dart';

import '../common.dart';

void main() {
  testWidgets(
    'OskCheckbox renders correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: Builder(
            builder: (context) {
              var selected = false;

              return StatefulBuilder(
                builder: (
                  BuildContext context,
                  void Function(void Function()) setState,
                ) =>
                    OskCheckbox(
                  selected: selected,
                  onSelect: () => setState(() => selected = !selected),
                ),
              );
            },
          ),
        ),
      );

      expect(find.byType(Checkbox), findsOneWidget);

      expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, false);

      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, true);
    },
  );
}
