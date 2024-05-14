import 'package:flutter_test/flutter_test.dart';
import 'package:osk_warehouse/common/components/dropdown/components/osk_dropdown_button.dart';
import 'package:osk_warehouse/common/components/dropdown/components/osk_dropdown_list.dart';
import 'package:osk_warehouse/common/components/dropdown/components/osk_dropdown_menu_item.dart';
import 'package:osk_warehouse/common/components/dropdown/osk_dropdown_menu.dart';

import '../common.dart';

void main() {
  testWidgets(
    'OskDropDown displays label and items',
    (WidgetTester tester) async {
      final items = <OskDropdownMenuItem<String>>[
        OskDropdownMenuItem(value: 'item1', label: 'Item 1'),
        OskDropdownMenuItem(value: 'item2', label: 'Item 2'),
        OskDropdownMenuItem(value: 'item3', label: 'Item 3'),
      ];

      await tester.pumpWidget(
        makeTestableWidget(
          child: OskDropDown<String>(
            label: 'Test Label',
            items: items,
          ),
        ),
      );

      expect(find.text('Test Label'), findsOneWidget);

      expect(find.byType(OskDropdownButton), findsOneWidget);

      await tester.tap(find.byType(OskDropdownButton));
      await tester.pump();

      expect(find.byType(OskDropdownList<String>), findsOneWidget);

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
    },
  );
}
