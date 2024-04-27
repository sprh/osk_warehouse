import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:osk_warehouse/common/components/button/osk_button.dart';
import 'package:osk_warehouse/common/components/loading_effect/loading_effect.dart';
import 'package:osk_warehouse/common/components/scaffold/osk_scaffold.dart';
import 'package:osk_warehouse/common/theme/theme_constants.dart';

void main() {
  testWidgets(
    'OskButton widget test',
    (WidgetTester tester) async {
      final Widget oskButton = MaterialApp(
        home: Theme(
          data: ThemeData(
            extensions: ThemeConstants.extensionsLight,
          ),
          child: OskScaffold.slivers(
            slivers: const [],
            actions: [
              OskButton.main(
                title: 'Main Button',
                onTap: () {},
              ),
            ],
          ),
        ),
      );

      await tester.pumpWidget(oskButton);

      final oskTextFinder = find.text('Main Button');
      expect(oskTextFinder, findsOneWidget);

      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);

      final container = tester.widget(containerFinder) as Container;
      expect(container.constraints?.maxHeight, equals(54.0));

      final gestureDetectorFinder = find.byType(GestureDetector);
      expect(gestureDetectorFinder, findsOneWidget);

      final gestureDetector =
          tester.widget(gestureDetectorFinder) as GestureDetector;
      expect(gestureDetector.onTap, isNotNull);

      final loadingEffectFinder = find.byType(LoadingEffect);
      expect(loadingEffectFinder, findsOneWidget);

      final loadingEffect = tester.widget(loadingEffectFinder) as LoadingEffect;
      expect(loadingEffect.isLoading, equals(false));
    },
  );
}
