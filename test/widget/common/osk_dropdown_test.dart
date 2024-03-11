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
      // Create a list of items for the dropdown
      final items = <OskDropdownMenuItem<String>>[
        OskDropdownMenuItem(value: 'item1', label: 'Item 1'),
        OskDropdownMenuItem(value: 'item2', label: 'Item 2'),
        OskDropdownMenuItem(value: 'item3', label: 'Item 3'),
      ];

      // Build the OskDropDown widget
      await tester.pumpWidget(
        makeTestableWidget(
          child: OskDropDown<String>(
            label: 'Test Label',
            items: items,
          ),
        ),
      );

      // Find the label text widget
      expect(find.text('Test Label'), findsOneWidget);

      // Find the dropdown button widget
      expect(find.byType(OskDropdownButton), findsOneWidget);

      // Tap on the dropdown button
      await tester.tap(find.byType(OskDropdownButton));
      await tester.pump();

      // Find the dropdown list widget
      expect(find.byType(OskDropdownList<String>), findsOneWidget);

      // Find the items in the dropdown list
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
    },
  );
}
