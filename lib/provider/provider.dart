import 'package:flutter/material.dart';

class NotifierProvider<M extends ChangeNotifier> extends StatefulWidget {
  final Widget child;
  final bool isManagingModel;
  final M Function() create;

  const NotifierProvider(
      {super.key,
      required this.create,
      required this.child,
      this.isManagingModel = true});

  @override
  State<NotifierProvider<M>> createState() => _NotifierProviderState<M>();

  static M? maybeOf<M extends ChangeNotifier>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedNotifierProvider<M>>()
        ?.model;
  }

  static M watch<M extends ChangeNotifier>(BuildContext context) {
    final M? result = maybeOf(context);
    assert(result != null, 'No InheritedNotifierProvider found in context');
    return result!;
  }

  static M? read<M extends ChangeNotifier>(BuildContext context) {
    final element = context.getElementForInheritedWidgetOfExactType<
        _InheritedNotifierProvider<M>>();
    return (element?.widget as _InheritedNotifierProvider<M>?)?.model;
  }
}

class _NotifierProviderState<M extends ChangeNotifier>
    extends State<NotifierProvider<M>> {
  late final M _model;

  @override
  void initState() {
    super.initState();
    _model = widget.create();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedNotifierProvider<M>(model: _model, child: widget.child);
  }

  @override
  void dispose() {
    if (widget.isManagingModel) {
      _model.dispose();
    }
    super.dispose();
  }
}

class _InheritedNotifierProvider<M extends ChangeNotifier>
    extends InheritedNotifier {
  final M model;

  const _InheritedNotifierProvider({
    super.key,
    required this.model,
    required super.child,
  }) : super(notifier: model);
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
