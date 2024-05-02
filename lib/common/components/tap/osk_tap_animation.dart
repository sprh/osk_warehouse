import 'package:flutter/material.dart';

class OskTapAnimationBuilder extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Duration duration;
  final bool disabled;

  const OskTapAnimationBuilder({
    required this.child,
    required this.onTap,
    this.disabled = false,
    this.duration = const Duration(milliseconds: 200),
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _TapAnimationBuilderState();
}

class _TapAnimationBuilderState extends State<OskTapAnimationBuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _opacityAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) => _controller.forward();

  void _onTapUp(TapUpDetails details) => _controller.reverse();

  void _onTapCancel() => _controller.reverse();

  void _onTap() {
    widget.onTap?.call();
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) => IgnorePointer(
        ignoring: widget.disabled || widget.onTap == null,
        child: GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          onTap: _onTap,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: child,
                ),
              );
            },
            child: Material(
              color: Colors.transparent,
              child: widget.child,
            ),
          ),
        ),
      );
}
