import 'package:flutter/material.dart';

import 'category_container.dart';

class CategoryScope extends StatefulWidget {
  final Widget child;

  const CategoryScope({
    required this.child,
    super.key,
  });

  static CategoryContainer containerOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_CategoryScope>()!.container;

  @override
  State<StatefulWidget> createState() => _CategoryScopeState();
}

class _CategoryScopeState extends State<CategoryScope> {
  late final container = CategoryContainer.create(
    context,
  );

  @override
  void initState() {
    super.initState();
    container.init();
  }

  @override
  Widget build(BuildContext context) => _CategoryScope(
        container: container,
        child: widget.child,
      );

  @override
  void dispose() {
    container.dispose();
    super.dispose();
  }
}

class _CategoryScope extends InheritedWidget {
  final CategoryContainer container;

  const _CategoryScope({
    required this.container,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant _CategoryScope oldWidget) =>
      oldWidget.container != container;
}
