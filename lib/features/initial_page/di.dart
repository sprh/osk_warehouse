import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../navigation/navigation_di.dart';
import 'presentation/initial_page_view_model.dart';

class InitialDi {
  static final viewModel = StateNotifierProvider<InitialPageViewModel, void>(
    (ref) => InitialPageViewModelImpl(
      navigationManager: ref.watch(
        NavigationDi.navigationManager,
      ),
    ),
  );
}
