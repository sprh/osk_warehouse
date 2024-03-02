import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/authorization/bloc/authorization_data_bloc.dart';
import '../../../core/authorization/bloc/state.dart';
import '../../../core/authorization/data/manager.dart';
import '../../../core/navigation/manager/account_scope_navigation_manager.dart';
import '../../../core/navigation/manager/app_scope_navigation_manager.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/scopes/account_scope.dart';
import '../../../core/scopes/app_scope.dart';
import '../../../theme/theme_constants.dart';

class OskApp extends StatefulWidget {
  final DioClient dio;
  final FlutterSecureStorage secureStorage;
  final AuthorizationDataManager authDataManager;

  const OskApp({
    required this.dio,
    required this.secureStorage,
    required this.authDataManager,
    super.key,
  });

  @override
  State<OskApp> createState() => _OskAppState();
}

class _OskAppState extends State<OskApp> with WidgetsBindingObserver {
  late final appScopeNavigatorKey = GlobalKey<NavigatorState>();
  late final accountScopeNavigatorKey = GlobalKey<NavigatorState>();
  VoidCallback? onPop;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Future<bool> didPopRoute() {
    onPop?.call();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthorizationDataBloc, AuthorizationDataState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          late final RouterDelegate<Object> routerDelegate;
          switch (state) {
            case AuthorizedState():
              final navigationManager =
                  routerDelegate = AccountScopeNavigationManagerImpl(
                accountScopeNavigatorKey,
              );
              onPop = navigationManager.pop;
            case NotAuthorizedState():
              final navigationManager =
                  routerDelegate = AppScopeNavigationManagerImpl(
                appScopeNavigatorKey,
              );
              onPop = navigationManager.pop;
          }

          return _ScopeWrapper(
            state: state,
            secureStorage: widget.secureStorage,
            authDataManager: widget.authDataManager,
            dio: widget.dio,
            child: MaterialApp.router(
              routerDelegate: routerDelegate,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: ThemeData(
                useMaterial3: true,
                fontFamily: ThemeConstants.fontFamily,
                extensions: ThemeConstants.extensionsLight,
                brightness: Brightness.light,
              ),
              darkTheme: ThemeData(
                useMaterial3: true,
                fontFamily: ThemeConstants.fontFamily,
                extensions: ThemeConstants.extensionsDark,
                brightness: Brightness.dark,
              ),
            ),
          );
        },
      );

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

class _ScopeWrapper extends StatelessWidget {
  final AuthorizationDataState state;
  final DioClient dio;
  final FlutterSecureStorage secureStorage;
  final AuthorizationDataManager authDataManager;
  final Widget child;

  const _ScopeWrapper({
    required this.state,
    required this.dio,
    required this.secureStorage,
    required this.authDataManager,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case AuthorizedState():
        return AccountScope(
          authManager: authDataManager,
          dio: dio,
          secureStorage: secureStorage,
          child: child,
        );
      case NotAuthorizedState():
        return AppScope(
          authManager: authDataManager,
          dio: dio,
          secureStorage: secureStorage,
          child: child,
        );
    }
  }
}
