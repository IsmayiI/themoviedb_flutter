import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/domain/services/auth_service.dart';
import 'package:themoviedb_flutter/ui/navigation/route_names.dart';

class LoaderModel {
  final BuildContext context;
  final _authService = AuthService();

  LoaderModel(this.context) {
    asyncInit();
  }

  Future<void> asyncInit() async {
    await checkAuth();
  }

  Future<void> checkAuth() async {
    final isAuth = await _authService.isAuth();
    final nextScreen = isAuth ? RouteNames.main : RouteNames.main;

    if (!context.mounted) return;
    Navigator.of(context).pushReplacementNamed(nextScreen);
  }
}
