import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:osk_warehouse/features/navigation/logic/navigation_manager.dart';

class NavigationDi {
  NavigationDi._();

  static final navigationManager = Provider((ref) => NavigationManagerImpl());
}
