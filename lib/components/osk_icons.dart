import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../assets/assets_provider.dart';

enum OskIconSize {
  medium;

  double get size {
    switch (this) {
      case OskIconSize.medium:
        return 24;
    }
  }
}

class OskIcon extends StatelessWidget {
  final String path;
  final OskIconSize size;

  const OskIcon._({
    required this.path,
    required this.size,
  });

  const OskIcon.notification({
    OskIconSize size = OskIconSize.medium,
  }) : this._(
          path: AssetsProvider.notification,
          size: size,
        );

  const OskIcon.setting({
    OskIconSize size = OskIconSize.medium,
  }) : this._(
          path: AssetsProvider.setting,
          size: size,
        );

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
        path,
        height: size.size,
        width: size.size,
      );
}
