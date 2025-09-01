import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  // static const String _tokenkey = 'access_token';
  static Future<void> saveToken({
    required String token,
    required String key,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, token);
  }

  static Future<String?> getToken(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> removeToken(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
