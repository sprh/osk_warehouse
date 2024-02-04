import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract base class Scope extends StatefulWidget {
  final String initialRoute;
  final GlobalKey<NavigatorState> navigatorKey;
  final Route<dynamic>? Function(RouteSettings) onGenerateRoute;

  const Scope({
    required this.initialRoute,
    required this.navigatorKey,
    required this.onGenerateRoute,
    super.key,
  });

  @override
  @nonVirtual
  State<StatefulWidget> createState() => _ScopeState();
}

class _ScopeState extends State<Scope> {
  @override
  Widget build(BuildContext context) => Navigator(
        key: widget.navigatorKey,
        initialRoute: widget.initialRoute,
        onGenerateRoute: widget.onGenerateRoute,
      );
}
