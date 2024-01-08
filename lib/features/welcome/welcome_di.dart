import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:osk_warehouse/features/navigation/navigation_di.dart';
import 'package:osk_warehouse/features/welcome/presentation/welcome_page_view_model.dart';

class WelcomeDi {
  static final viewModel = StateNotifierProvider<WelcomePageViewModel, void>(
    (ref) => WelcomePageViewModelImpl(
      navigationManager: ref.watch(NavigationDi.navigationManager),
    ),
  );
}
