import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'logic/navigation_manager.dart';

class NavigationDi {
  NavigationDi._();

  static final navigationManager = Provider((ref) => NavigationManagerImpl());
}
