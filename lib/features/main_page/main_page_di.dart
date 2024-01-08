import 'package:osk_warehouse/features/main_page/presentation/main_page_view_model.dart';
import 'package:riverpod/riverpod.dart';

class MainPageDi {
  MainPageDi._();

  static final viewModel = StateNotifierProvider<MainPageViewModel, void>(
    (_) => MainPageViewModelImpl(),
  );
}
