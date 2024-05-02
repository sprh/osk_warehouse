import 'package:flutter/material.dart';

class LoadingEffect extends StatefulWidget {
  final Widget child;
  final bool isLoading;

  const LoadingEffect({required this.child, this.isLoading = true, super.key});

  @override
  State<StatefulWidget> createState() => LoadingEffectState();
}

class LoadingEffectState extends State<LoadingEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: duration,
  );
  late final Tween<double> _shimmerTween = Tween<double>(
    begin: -waveLength / 2,
    end: 1.0 + waveLength,
  );
  late Animation<double> _shimmerAnimation;

  final _childKey = GlobalKey();

  static const waveLength = 1.2;
  static const duration = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    _updateAnimation();
  }

  @override
  void didUpdateWidget(covariant LoadingEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading != oldWidget.isLoading) {
      _updateAnimation();
    }
  }

  @override
  Widget build(BuildContext context) {
    final child = KeyedSubtree(
      key: _childKey,
      child: widget.child,
    );

    return AnimatedBuilder(
      animation: _shimmerAnimation,
      child: child,
      builder: (context, child) => ShaderMask(
        blendMode: BlendMode.dstIn,
        shaderCallback: (rect) => LinearGradient(
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.1),
            Colors.white,
          ],
          stops: [
            _shimmerAnimation.value - waveLength / 2,
            _shimmerAnimation.value,
            _shimmerAnimation.value + waveLength / 2,
          ],
          begin: const Alignment(-waveLength, 0),
          end: const Alignment(waveLength, 0),
        ).createShader(rect),
        child: RepaintBoundary(
          child: IgnorePointer(
            ignoring: widget.isLoading,
            child: child,
          ),
        ),
      ),
    );
  }

  void _updateAnimation() {
    if (widget.isLoading) {
      controller.repeat();
    } else {
      controller.reset();
    }
    _shimmerAnimation = _shimmerTween.animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
