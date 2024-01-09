import 'package:riverpod/riverpod.dart';

import 'presentation/main_page_view_model.dart';

class MainPageDi {
  MainPageDi._();

  static final viewModel = StateNotifierProvider<MainPageViewModel, void>(
    (_) => MainPageViewModelImpl(),
  );
}
