import 'package:flutter/material.dart';

import '../../../components/osk_image.dart';
import '../../../components/osk_scaffold.dart';

class InitialPage extends StatelessWidget {
  const InitialPage();

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
