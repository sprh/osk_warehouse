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
    Key? key,
  }) : this._(
          path: AssetsProvider.createRequest,
          size: size,
          key: key,
        );

  const OskServiceIcon.request({
    OskServiceIconSize size = OskServiceIconSize.medium,
    Key? key,
  }) : this._(
          path: AssetsProvider.request,
          size: size,
          key: key,
        );

  const OskServiceIcon.warehouse({
    OskServiceIconSize size = OskServiceIconSize.medium,
    Key? key,
  }) : this._(
          path: AssetsProvider.warehouse,
          size: size,
          key: key,
        );

  const OskServiceIcon.worker({
    OskServiceIconSize size = OskServiceIconSize.medium,
    Key? key,
  }) : this._(
          path: AssetsProvider.worker,
          size: size,
          key: key,
        );

  const OskServiceIcon.report({
    OskServiceIconSize size = OskServiceIconSize.medium,
    Key? key,
  }) : this._(
          path: AssetsProvider.report,
          size: size,
          key: key,
        );

  const OskServiceIcon.products({
    OskServiceIconSize size = OskServiceIconSize.medium,
    Key? key,
  }) : this._(
          path: AssetsProvider.products,
          size: size,
          key: key,
        );

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
        path,
        height: size.height,
      );
}
