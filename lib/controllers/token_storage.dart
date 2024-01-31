import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String _tokenKey = 'user_token';
  static late SharedPreferences _prefs;

  // İlk defa çağrıldığında çalışacak başlatma fonksiyonu
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    return _prefs.getString(_tokenKey);
  }

  static Future<void> removeToken() async {
    await _prefs.remove(_tokenKey);
  }
}
