import 'package:themoviedb_flutter/domain/api_client/api_client.dart';
import 'package:themoviedb_flutter/domain/data_providers/session_data_provider.dart';

class AuthService {
  final apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  Future<bool> isAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final isAuth = sessionId != null;
    return isAuth;
  }

  Future<void> auth(String username, String password) async {
    final sessionId =
        await apiClient.auth(username: username, password: password);

    await _sessionDataProvider.setSessionId(sessionId);
  }
}
