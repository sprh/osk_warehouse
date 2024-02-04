part of 'navigation_manager.dart';

abstract class AppScopeNavigationManager implements NavigationManager {
  factory AppScopeNavigationManager(GlobalKey<NavigatorState> navigatorKey) =>
      _AppScopeNavigationManager(navigatorKey);

  void openWelcome();

  void openLogin();
}

class _AppScopeNavigationManager extends NavigationManager
    implements AppScopeNavigationManager {
  _AppScopeNavigationManager(super.navigatorKey);

  @override
  void openLogin() => navigatorKey.currentState?.pushReplacementNamed(
        AppScopeRoutes.login.name,
      );
  @override
  void openWelcome() => navigatorKey.currentState?.pushReplacementNamed(
        AppScopeRoutes.welcome.name,
      );
}
