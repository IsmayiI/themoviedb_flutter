import 'dart:async';

import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/domain/api_client/api_client.dart';
import 'package:themoviedb_flutter/domain/data_providers/session_data_provider.dart';

class AuthModel extends ChangeNotifier {
  final apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get isAuthProgress => _isAuthProgress;
  bool get canStartAuth => !_isAuthProgress;

  Future<void> auth(BuildContext context) async {
    final username = usernameTextController.text;
    final password = passwordTextController.text;
    if (username.isEmpty || password.isEmpty) {
      _errorMessage = 'Fill in your username and password';
      notifyListeners();
      return;
    }

    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();

    String? sessionId;
    try {
      sessionId = await apiClient.auth(username: username, password: password);
    } catch (e) {
      _errorMessage = 'Invalid username or password';
    }

    _isAuthProgress = false;

    if (_errorMessage != null) {
      notifyListeners();
      return;
    }

    if (sessionId == null) {
      _errorMessage = 'Unknown error, try again';
      notifyListeners();
      return;
    }

    await _sessionDataProvider.setSessionId(sessionId);
    unawaited(Navigator.of(context).pushNamed('/main'));
  }
}

class AuthProvider extends InheritedNotifier<AuthModel> {
  final AuthModel model;

  const AuthProvider({
    super.key,
    required this.model,
    required super.child,
  }) : super(notifier: model);

  static AuthModel? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthProvider>()?.model;
  }

  static AuthModel watch(BuildContext context) {
    final AuthModel? result = maybeOf(context);
    assert(result != null, 'No AuthProvider found in context');
    return result!;
  }

  static AuthModel? read(BuildContext context) {
    final element =
        context.getElementForInheritedWidgetOfExactType<AuthProvider>();
    return (element?.widget as AuthProvider?)?.model;
  }
}
