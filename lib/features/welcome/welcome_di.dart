import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../navigation/navigation_di.dart';
import 'presentation/welcome_page_view_model.dart';

class WelcomeDi {
  static final viewModel = StateNotifierProvider<WelcomePageViewModel, void>(
    (ref) => WelcomePageViewModelImpl(
      navigationManager: ref.watch(NavigationDi.navigationManager),
    ),
  );
}
