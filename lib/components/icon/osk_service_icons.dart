import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../assets/assets_provider.dart';

enum OskServiceIconSize {
  medium;

  double get height {
    switch (this) {
      case OskServiceIconSize.medium:
        return 35;
    }
  }
}

class OskServiceIcon extends StatelessWidget {
  final String path;
  final OskServiceIconSize size;

  const OskServiceIcon._({
    required this.path,
    required this.size,
    super.key,
  });

  const OskServiceIcon.createRequest({
    OskServiceIconSize size = OskServiceIconSize.medium,
  }) : this._(
          path: AssetsProvider.createRequest,
          size: size,
        );

  const OskServiceIcon.request({
    OskServiceIconSize size = OskServiceIconSize.medium,
  }) : this._(
          path: AssetsProvider.request,
          size: size,
        );

  const OskServiceIcon.warehouse({
    OskServiceIconSize size = OskServiceIconSize.medium,
  }) : this._(
          path: AssetsProvider.warehouse,
          size: size,
        );

  const OskServiceIcon.worker({
    OskServiceIconSize size = OskServiceIconSize.medium,
  }) : this._(
          path: AssetsProvider.worker,
          size: size,
        );

  const OskServiceIcon.report({
    OskServiceIconSize size = OskServiceIconSize.medium,
  }) : this._(
          path: AssetsProvider.report,
          size: size,
        );

  const OskServiceIcon.products({
    OskServiceIconSize size = OskServiceIconSize.medium,
  }) : this._(
          path: AssetsProvider.products,
          size: size,
        );

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
        path,
        height: size.height,
      );
}
