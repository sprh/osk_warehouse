import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:osk_warehouse/mvvm/feature_view_model.dart';

typedef FeatureViewBuilder<ViewModel, FeatureState> = Widget Function(
  ViewModel manager,
  FeatureState state,
);

abstract class FeatureView<ViewModel extends FeatureViewModel<FeatureState>,
    FeatureState> extends ConsumerWidget {
  const FeatureView({super.key});

  StateNotifierProvider<ViewModel, FeatureState> get viewModel;

  FeatureViewBuilder<ViewModel, FeatureState> get builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(this.viewModel.notifier);

    return _FeatureView(
      viewModel,
      builder,
    );
  }
}

class _FeatureView<ViewModel extends FeatureViewModel<FeatureState>,
    FeatureState> extends StatefulWidget {
  final ViewModel viewModel;
  final FeatureViewBuilder<ViewModel, FeatureState> builder;

  const _FeatureView(
    this.viewModel,
    this.builder,
  );

  @override
  State<StatefulWidget> createState() =>
      _FeatureViewState<ViewModel, FeatureState>();
}

class _FeatureViewState<ViewModel extends FeatureViewModel<FeatureState>,
    FeatureState> extends State<_FeatureView<ViewModel, FeatureState>> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => widget.viewModel.featureInit(),
    );
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<FeatureState>(
        initialData: widget.viewModel.state,
        stream: widget.viewModel.stream,
        builder: (context, snapshot) {
          final data = snapshot.data;

          return widget.builder(
            widget.viewModel,
            data ?? widget.viewModel.state,
          );
        },
      );

  @override
  void dispose() {
    widget.viewModel.featureDispose();
    super.dispose();
  }
}
