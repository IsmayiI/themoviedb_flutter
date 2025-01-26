import 'package:themoviedb_flutter/domain/api/api_clients/auth_api_client.dart';
import 'package:themoviedb_flutter/domain/data_providers/session_data_provider.dart';

class AuthService {
  final _apiClient = AuthApiClient();
  final _sessionDataProvider = SessionDataProvider();

  Future<bool> isAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final isAuth = sessionId != null;
    return isAuth;
  }

  Future<void> auth(String username, String password) async {
    final sessionId =
        await _apiClient.auth(username: username, password: password);

    await _sessionDataProvider.setSessionId(sessionId);
  }
}
