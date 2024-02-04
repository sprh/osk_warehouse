import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/login/bloc/login_bloc.dart';
import '../../../features/login/presentation/login_page.dart';
import '../../../features/welcome/bloc/welcome_page_bloc.dart';
import '../../../features/welcome/presentation/welcome_page.dart';
import '../../scopes/app_scope.dart';
import 'models/routes.dart';

final class AppScopeRoutesBuilder {
  AppScopeRoutesBuilder._();

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final route = AppScopeRoutes.values.firstWhereOrNull(
          (route) => route.name == settings.name,
        ) ??
        AppScopeRoutes.welcome;

    late final Widget screen;

    switch (route) {
      case AppScopeRoutes.welcome:
        screen = BlocProvider(
          create: (context) => WelcomePageBloc(
            AppScope.of(context).navigationManager,
          ),
          child: const WelcomePage(),
        );
      case AppScopeRoutes.login:
        screen = BlocProvider(
          create: (context) => LoginBloc(
            AppScope.of(context).navigationManager,
            AppScope.of(context).authManager,
          ),
          child: const LoginPage(),
        );
    }

    return MaterialPageRoute(
      builder: (_) => screen,
    );
  }
}
