import 'dart:async';
import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/domain/api_client/api_exeption.dart';
import 'package:themoviedb_flutter/domain/services/auth_service.dart';
import 'package:themoviedb_flutter/ui/navigation/navigation.dart';

class AuthModel extends ChangeNotifier {
  final _authService = AuthService();

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get isAuthProgress => _isAuthProgress;
  bool get canStartAuth => !_isAuthProgress;

  bool _isAuthValid(String username, String password) =>
      username.isNotEmpty && password.isNotEmpty;

  Future<void> auth(BuildContext context) async {
    final username = usernameTextController.text;
    final password = passwordTextController.text;

    if (_isAuthValid(username, password)) {
      _errorMessage = null;
      _isAuthProgress = true;
      notifyListeners();
    } else {
      _errorMessage = 'Fill in your username and password';
      notifyListeners();
      return;
    }

    try {
      await _authService.auth(username, password);
    } catch (e) {
      if (e is ApiException) {
        _errorMessage = e.message;
      } else {
        _errorMessage = 'Unknown error, try again';
      }
    }

    _isAuthProgress = false;

    if (_errorMessage != null) {
      notifyListeners();
      return;
    }

    // ignore: use_build_context_synchronously
    Navigation.resetNavigation(context);
  }
}
