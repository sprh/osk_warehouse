import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/login/bloc/login_bloc.dart';
import '../../../features/login/presentation/login_page.dart';
import '../../../features/welcome/bloc/welcome_page_bloc.dart';
import '../../../features/welcome/presentation/welcome_page.dart';
import '../../scopes/app_scope.dart';
import '../logic/models/app_scope_routes.dart';
import 'navigation_manager.dart';

abstract class AppScopeNavigationManager implements NavigationManager {
  void openLogin();
}

class AppScopeNavigationManagerImpl extends RouterDelegate<AppScopeRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin, NavigationManager
    implements AppScopeNavigationManager {
  final GlobalKey<NavigatorState> _navigatorKey;

  AppScopeRoute route = AppScopeRoute.welcome;

  AppScopeNavigationManagerImpl(this._navigatorKey);

  @override
  void openLogin() => route = AppScopeRoute.login;

  @override
  Widget build(BuildContext context) => Navigator(
        pages: [
          MaterialPage(
            child: Builder(
              builder: (_) {
                switch (route) {
                  case AppScopeRoute.welcome:
                    return BlocProvider(
                      create: (context) => WelcomePageBloc(
                        this,
                      ),
                      child: const WelcomePage(),
                    );
                  case AppScopeRoute.login:
                    return BlocProvider(
                      create: (context) => LoginBloc(
                        this,
                        AppScope.of(context).authManager,
                      ),
                      child: const LoginPage(),
                    );
                }
              },
            ),
          ),
        ],
        onPopPage: (_, __) => false,
      );

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(AppScopeRoute configuration) async =>
      route = configuration;

  @override
  void pop() {}
}
