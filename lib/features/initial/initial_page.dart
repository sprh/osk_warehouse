import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:osk_warehouse/assets/assets_provider.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: SvgPicture.asset(
        AssetsProvider.splash,
        alignment: AlignmentDirectional.centerStart,
        fit: BoxFit.cover,
        width: mediaQuery.width,
      ),
    );
  }
}
