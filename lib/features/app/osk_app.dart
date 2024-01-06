import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:osk_warehouse/navigation/navigation_manager.dart';
import 'package:osk_warehouse/navigation/routes.dart';
import 'package:osk_warehouse/navigation/routes_builder.dart';
import 'package:osk_warehouse/theme/theme_constants.dart';

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
        initialRoute: Routes.initial.name,
        onGenerateRoute: RoutesBuilder.generateRoutes,
        home: const Scaffold(),
      );
}
