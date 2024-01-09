import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/osk_image.dart';
import '../../../components/osk_scaffold.dart';
import '../../../mvvm/feature_widget.dart';
import '../di.dart';
import 'initial_page_view_model.dart';

class InitialPage extends FeatureView<InitialPageViewModel, void> {
  const InitialPage({super.key});

  @override
  FeatureViewBuilder get builder => (_, __) => _InitialPage();

  @override
  StateNotifierProvider<InitialPageViewModel, void> get viewModel =>
      InitialDi.viewModel;
}

class _InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return OskScaffold(
      body: OskImage.splash(
        alignment: AlignmentDirectional.centerStart,
        fit: BoxFit.cover,
        width: mediaQuery.width,
      ),
    );
  }
}
