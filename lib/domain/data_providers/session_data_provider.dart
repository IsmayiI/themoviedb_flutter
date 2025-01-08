import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys {
  static const sessionId = 'session_id';
}

class SessionDataProvider {
  static const storage = FlutterSecureStorage();

  Future<String?> getSessionId() => storage.read(key: _Keys.sessionId);
  Future<void> setSessionId(String sessionId) =>
      storage.write(key: _Keys.sessionId, value: sessionId);
}
