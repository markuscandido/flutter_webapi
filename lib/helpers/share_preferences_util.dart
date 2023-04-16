import 'package:flutter_webapi_first_course/models/auth/login_response.dart';
import 'package:flutter_webapi_first_course/models/auth/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtils {
  static const String _accessToken = "access_token";
  static const String _dateLastAccessToken = "date_last_access_token";
  static const String _userId = "user_id";
  static const String _userEmail = "user_email";
  static const int _expiredAccessTokenMinutes = 90;

  static late final SharedPreferences _instance;

  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();

  static LoginResponse getLogin() {
    String dateLastAccessToken =
        _instance.getString(_dateLastAccessToken) ?? "";
    bool hasDateLastAccessToken = dateLastAccessToken.isNotEmpty;
    if (!hasDateLastAccessToken) {
      _instance.remove(_accessToken);
    } else {
      DateTime now = DateTime.now();
      DateTime lastAccess = DateTime.parse(dateLastAccessToken);
      int diff = now.difference(lastAccess).inMinutes;
      if (diff > _expiredAccessTokenMinutes) {
        _instance.remove(_accessToken);
      }
    }

    String accessToken = _instance.getString(_accessToken) ?? "";
    String userEmail = _instance.getString(_userEmail) ?? "";
    String userId = _instance.getString(_userId) ?? "";
    return LoginResponse(
      accessToken: accessToken,
      user: User(
        id: userId,
        email: userEmail,
      ),
    );
  }

  static void setLogin(LoginResponse loginResponse) {
    _instance.setString(_accessToken, loginResponse.accessToken);
    _instance.setString(_userEmail, loginResponse.user.email);
    _instance.setString(_userId, loginResponse.user.id);
    _instance.setString(_dateLastAccessToken, DateTime.now().toIso8601String());
  }

  static void setLogout() {
    _instance.remove(_accessToken);
    _instance.remove(_userEmail);
    _instance.remove(_userId);
    _instance.remove(_dateLastAccessToken);
  }

  static String getString(String key, [String defValue = ""]) {
    return _instance.getString(key) ?? defValue;
  }

  static Future<bool> setString(String key, String value) async {
    return _instance.setString(key, value);
  }
}
