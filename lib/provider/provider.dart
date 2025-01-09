import 'package:flutter/material.dart';

class NotifierProvider<M extends ChangeNotifier> extends InheritedNotifier {
  final M model;

  const NotifierProvider({
    super.key,
    required this.model,
    required super.child,
  }) : super(notifier: model);

  static M? maybeOf<M extends ChangeNotifier>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<NotifierProvider<M>>()
        ?.model;
  }

  static M watch<M extends ChangeNotifier>(BuildContext context) {
    final M? result = maybeOf(context);
    assert(result != null, 'No NotifierProvider found in context');
    return result!;
  }

  static M? read<M extends ChangeNotifier>(BuildContext context) {
    final element =
        context.getElementForInheritedWidgetOfExactType<NotifierProvider<M>>();
    return (element?.widget as NotifierProvider<M>?)?.model;
  }
}

class Provider<M> extends InheritedWidget {
  final M model;

  const Provider({
    super.key,
    required this.model,
    required super.child,
  });

  static M? maybeOf<M>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider<M>>()?.model;
  }

  static M watch<M>(BuildContext context) {
    final M? result = maybeOf(context);
    assert(result != null, 'No Provider found in context');
    return result!;
  }

  static M? read<M>(BuildContext context) {
    final element =
        context.getElementForInheritedWidgetOfExactType<Provider<M>>();
    return (element?.widget as Provider<M>?)?.model;
  }

  @override
  bool updateShouldNotify(Provider oldWidget) => model != oldWidget.model;
}
