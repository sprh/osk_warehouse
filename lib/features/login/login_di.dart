import 'package:riverpod/riverpod.dart';

import '../navigation/navigation_di.dart';
import 'presentation/login_page_view_model.dart';

class LoginDi {
  static final viewModel = StateNotifierProvider<LoginPageViewModel, void>(
    (ref) => LoginPageViewModelImpl(
      navigationManager: ref.watch(NavigationDi.navigationManager),
    ),
  );
}
