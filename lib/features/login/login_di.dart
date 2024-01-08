import 'package:osk_warehouse/features/login/presentation/login_page_view_model.dart';
import 'package:riverpod/riverpod.dart';

class LoginDi {
  static final viewModel = StateNotifierProvider<LoginPageViewModel, void>(
    (_) => LoginPageViewModelImpl(),
  );
}
