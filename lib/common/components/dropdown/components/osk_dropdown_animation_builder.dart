import 'package:flutter/material.dart';

typedef OskDropdownBuilder = Widget Function(
  Animation<double> iconTurns,
  Animation<double> listExpand,
);

mixin OskDropdownAnimationBuilder<T extends StatefulWidget> on State<T> {
  static final _halfTween = Tween<double>(begin: 0, end: 0.5);

  late final AnimationController animationController;
  late final Animation<double> iconTurns;
  late final Animation<double> listExpand;

  bool expanded = false;

  TickerProvider get vsync;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: vsync,
    );
    iconTurns = animationController.drive(
      _halfTween.chain(
        CurveTween(curve: Curves.easeIn),
      ),
    );
    listExpand = animationController.drive(
      CurveTween(
        curve: Curves.fastOutSlowIn,
      ),
    );
  }

  void onChangeExpansion() => setState(
        () {
          expanded = !expanded;
          if (expanded) {
            animationController.forward();
          } else {
            animationController.reverse().then<void>((void value) {
              if (!mounted) {
                return;
              }
              setState(() {});
            });
          }
        },
      );

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
