import 'package:hive_flutter/hive_flutter.dart';

class TokenStorage {
  static const String _tokenBoxKey = 'tokenBox';
  static const String _sessionBoxKey = 'sessionBox';

  // Initialize Hive
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<String>(_tokenBoxKey);
    await Hive.openBox<String>(_sessionBoxKey);
  }

  static Future<void> saveToken(String token) async {
    final tokenBox = await Hive.openBox<String>(_tokenBoxKey);
    await tokenBox.put('token', token);
  }

  static Future<void> saveSession(String session) async {
    final sessionBox = await Hive.openBox<String>(_sessionBoxKey);
    await sessionBox.put('session', session);
  }

  static Future<String?> getToken() async {
    final tokenBox = await Hive.openBox<String>(_tokenBoxKey);
    return tokenBox.get('token');
  }

  static Future<String?> getSession() async {
    final sessionBox = await Hive.openBox<String>(_sessionBoxKey);
    return sessionBox.get('session');
  }

  static Future<void> removeToken() async {
    final tokenBox = await Hive.openBox<String>(_tokenBoxKey);
    await tokenBox.delete('token');
  }

  static Future<void> removeSession() async {
    final sessionBox = await Hive.openBox<String>(_sessionBoxKey);
    await sessionBox.delete('session');
  }
}
