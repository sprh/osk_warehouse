import 'package:flutter/material.dart';
import 'package:osk_warehouse/theme/theme_constants.dart';

Widget makeTestableWidget({required Widget child}) {
  return MaterialApp(
    home: Theme(
      data: ThemeData(
        extensions: ThemeConstants.extensionsLight,
      ),
      child: Scaffold(body: child),
    ),
  );
}
