import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:osk_warehouse/common/components/loading_effect/loading_effect.dart';

import '../common.dart';

void main() {
  testWidgets(
      'LoadingEffect shows child widget and starts animating when isLoading is true',
      (WidgetTester tester) async {
    const childWidgetKey = Key('childWidget');

    await tester.pumpWidget(
      makeTestableWidget(
        child: LoadingEffect(
          child: Container(key: childWidgetKey),
        ),
      ),
    );

    expect(find.byKey(childWidgetKey), findsOneWidget);

    final state =
        tester.state(find.byType(LoadingEffect)) as LoadingEffectState;
    expect(state.controller.isAnimating, isTrue);
  });

  testWidgets(
    'LoadingEffect stops animating when isLoading is false',
    (WidgetTester tester) async {
      const childWidgetKey = Key('childWidgetStop');

      await tester.pumpWidget(
        makeTestableWidget(
          child: LoadingEffect(
            isLoading: false,
            child: Container(key: childWidgetKey),
          ),
        ),
      );

      expect(find.byKey(childWidgetKey), findsOneWidget);

      final state =
          tester.state(find.byType(LoadingEffect)) as LoadingEffectState;
      expect(state.controller.isAnimating, isFalse);
    },
  );
}
