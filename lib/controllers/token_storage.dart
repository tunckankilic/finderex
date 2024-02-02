import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static String sTokenKey = 'token_key';
  static String sSessionKey = "session_key";
  static late SharedPreferences _prefs;

  // İlk defa çağrıldığında çalışacak başlatma fonksiyonu
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveToken(String token) async {
    await _prefs.setString(sTokenKey, token);
  }

  static Future<void> saveSession(String session) async {
    await _prefs.setString(sSessionKey, session);
  }

  static Future<String?> getToken() async {
    return _prefs.getString(sTokenKey);
  }

  static Future<String?> getSession() async {
    return _prefs.getString(sSessionKey);
  }

  static Future<void> removeToken() async {
    await _prefs.remove(sTokenKey);
  }

  static Future<void> removeSession() async {
    await _prefs.remove(sSessionKey);
  }
}
