import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../assets/assets_provider.dart';

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
  final Color? color;

  const OskIcon._({
    required this.path,
    required this.size,
    this.color,
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

  const OskIcon.close({
    OskIconSize size = OskIconSize.medium,
  }) : this._(
          path: AssetsProvider.close,
          size: size,
        );

  const OskIcon.hide({
    OskIconSize size = OskIconSize.medium,
    Color? color,
  }) : this._(
          path: AssetsProvider.hide,
          size: size,
          color: color,
        );

  const OskIcon.show({
    OskIconSize size = OskIconSize.medium,
    Color? color,
  }) : this._(
          path: AssetsProvider.show,
          size: size,
          color: color,
        );

  const OskIcon.delete({
    OskIconSize size = OskIconSize.medium,
    Color? color,
  }) : this._(
          path: AssetsProvider.delete,
          size: size,
          color: color,
        );

  const OskIcon.edit({
    OskIconSize size = OskIconSize.medium,
    Color? color,
  }) : this._(
          path: AssetsProvider.edit,
          size: size,
          color: color,
        );

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
        path,
        height: size.size,
        width: size.size,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      );
}
