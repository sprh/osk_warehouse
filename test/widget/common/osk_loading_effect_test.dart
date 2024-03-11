import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:osk_warehouse/common/components/loading_effect/loading_effect.dart';

import '../common.dart';

void main() {
  testWidgets(
      'LoadingEffect shows child widget and starts animating when isLoading is true',
      (WidgetTester tester) async {
    const childWidgetKey = Key('childWidget');

    // Widget to test
    await tester.pumpWidget(
      makeTestableWidget(
        child: LoadingEffect(
          child: Container(key: childWidgetKey),
        ),
      ),
    );

    // Confirm child widget is present
    expect(find.byKey(childWidgetKey), findsOneWidget);

    // Since animations in tests do not work in real-time as in a live app, we do a rough verification that the animation controller is active.
    final state =
        tester.state(find.byType(LoadingEffect)) as LoadingEffectState;
    expect(state.controller.isAnimating, isTrue);
  });

  // For stopping the animation when isLoading is false, you can also add similar test
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

      // Confirm the child widget is present.
      expect(find.byKey(childWidgetKey), findsOneWidget);

      // Verify that the animation controller is not active.
      final state =
          tester.state(find.byType(LoadingEffect)) as LoadingEffectState;
      expect(state.controller.isAnimating, isFalse);
    },
  );
}
