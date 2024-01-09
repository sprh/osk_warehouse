import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../theme/theme_constants.dart';
import '../navigation/logic/navigation_manager.dart';
import '../navigation/logic/routes_builder.dart';
import '../navigation/models/routes.dart';

class OskApp extends StatelessWidget {
  const OskApp({super.key});

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
        navigatorKey: NavigationManager.navigatorKey,
        initialRoute: Routes.initialRouteName,
        onGenerateRoute: RoutesBuilder.generateRoutes,
      );
}
