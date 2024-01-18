import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class OskActionsFlex extends StatelessWidget {
  final List<Widget> widgets;
  final Axis direction;
  final double? maxWidth;

  const OskActionsFlex({
    required this.widgets,
    this.direction = Axis.horizontal,
    this.maxWidth,
    super.key,
  });

  bool get _horizontal => direction == Axis.horizontal;

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth ?? MediaQuery.of(context).size.width / 4 * 3,
            ),
            child: Flex(
              direction: direction,
              mainAxisSize: MainAxisSize.min,
              children: widgets
                  .expandIndexed<Widget>(
                    (index, element) => [
                      element,
                      if (index != widgets.length - 1)
                        SizedBox(
                          width: _horizontal ? 8 : 0,
                          height: _horizontal ? 0 : 8,
                        ),
                    ],
                  )
                  .toList(),
            ),
          ),
        ),
      );
}
