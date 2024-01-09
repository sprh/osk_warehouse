import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../assets/assets_provider.dart';

class OskImage extends StatelessWidget {
  final String name;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final double? width;

  const OskImage._({
    required this.name,
    required this.fit,
    required this.alignment,
    this.width,
  });

  const OskImage.welcomeHeader({
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    double? width,
  }) : this._(
          name: AssetsProvider.welcomeHeader,
          fit: fit,
          alignment: alignment,
          width: width,
        );

  const OskImage.splash({
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    double? width,
  }) : this._(
          name: AssetsProvider.splash,
          fit: fit,
          alignment: alignment,
          width: width,
        );

  const OskImage.loginPageHeader({
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    double? width,
  }) : this._(
          name: AssetsProvider.loginPageHeader,
          fit: fit,
          alignment: alignment,
          width: width,
        );

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
        name,
        fit: fit,
        alignment: alignment,
        width: width,
      );
}
