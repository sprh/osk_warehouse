import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:osk_warehouse/features/initial_page/presentation/initial_page_view_model.dart';
import 'package:osk_warehouse/features/navigation/navigation_di.dart';

class InitialDi {
  static final viewModel = StateNotifierProvider<InitialPageViewModel, void>(
    (ref) => InitialPageViewModelImpl(
      navigationManager: ref.watch(
        NavigationDi.navigationManager,
      ),
    ),
  );
}
