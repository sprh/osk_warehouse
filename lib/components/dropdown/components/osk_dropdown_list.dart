import 'package:flutter/material.dart';

import '../../../theme/utils/theme_from_context.dart';
import '../../osk_line_divider.dart';
import 'osk_dropdown_menu_item.dart';

class OskDropdownList extends StatelessWidget {
  final List<OskDropdownItemWidget> widgets;
  final Animation<double> animation;

  const OskDropdownList({
    required this.widgets,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dropdownTheme;
    final borderSide = BorderSide(color: theme.borderSideColor);

    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: animation,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              left: borderSide,
              right: borderSide,
              bottom: borderSide,
            ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(8),
            ),
            color: Colors.white,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widgets.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 4.0),
                  child: widgets[index],
                ),
                if (index != widgets.length - 1)
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: OskLineDivider(),
                  )
                else
                  SizedBox(height: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
