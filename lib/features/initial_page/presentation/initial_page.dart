import 'package:flutter/material.dart';

import '../../../components/osk_image.dart';
import '../../../components/scaffold/osk_scaffold.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return OskScaffold(
      body: OskImage.splash(
        alignment: AlignmentDirectional.centerStart,
        fit: BoxFit.cover,
        width: mediaQuery.width,
      ),
    );
  }
}
