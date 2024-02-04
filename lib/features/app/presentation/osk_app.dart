import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/authorization/bloc/authorization_data_bloc.dart';
import '../../../core/authorization/bloc/state.dart';
import '../../../core/authorization/data/manager.dart';
import '../../../core/navigation/manager/navigation_manager.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/scopes/account_scope.dart';
import '../../../core/scopes/app_scope.dart';
import '../../../theme/theme_constants.dart';

class OskApp extends StatefulWidget {
  final DioClient dio;
  final FlutterSecureStorage secureStorage;
  final AuthorizationDataManager authDataManager;
  // final AppScopeNavigationManager appScopeNavigationManager;
  // final AccountScopeNavigationManager accountScopeNavigationManager;

  const OskApp({
    required this.dio,
    required this.secureStorage,
    required this.authDataManager,
    super.key,
  });

  @override
  State<OskApp> createState() => _OskAppState();
}

class _OskAppState extends State<OskApp> {
  late final appScopeNavigatorKey = GlobalKey<NavigatorState>();
  late final accountScopeNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) => MaterialApp(
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
        builder: (_, __) =>
            BlocBuilder<AuthorizationDataBloc, AuthorizationDataState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            switch (state) {
              case AuthorizedState():
                return AccountScope(
                  secureStorage: widget.secureStorage,
                  authManager: widget.authDataManager,
                  dio: widget.dio,
                  navigatorKey: accountScopeNavigatorKey,
                  navigationManager: AccountScopeNavigationManager(
                    accountScopeNavigatorKey,
                  ),
                );
              case NotAuthorizedState():
                return AppScope(
                  secureStorage: widget.secureStorage,
                  authManager: widget.authDataManager,
                  dio: widget.dio,
                  navigatorKey: appScopeNavigatorKey,
                  navigationManager: AppScopeNavigationManager(
                    appScopeNavigatorKey,
                  ),
                );
            }
          },
        ),
      );
}
