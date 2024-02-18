import 'package:flutter/material.dart';

import '../../../../theme/utils/theme_from_context.dart';
import '../../osk_line_divider.dart';
import 'osk_dropdown_menu_item.dart';

class OskDropdownList<T> extends StatelessWidget {
  final List<OskDropdownItemWidget<T>> widgets;
  final Animation<double> animation;

  const OskDropdownList({
    required this.widgets,
    required this.animation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dropdownTheme;
    final borderSide = BorderSide(color: theme.borderSideColor);

    return SizeTransition(
      axisAlignment: 1,
      sizeFactor: animation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              left: borderSide,
              right: borderSide,
              bottom: borderSide,
            ),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(8),
            ),
            color: Colors.white,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widgets.length,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: widgets[index],
                ),
                if (index != widgets.length - 1)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: OskLineDivider(),
                  )
                else
                  const SizedBox(height: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
