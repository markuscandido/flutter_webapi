import 'package:flutter_webapi_first_course/models/auth/login_response.dart';
import 'package:flutter_webapi_first_course/models/auth/signin.dart';
import 'package:flutter_webapi_first_course/models/auth/signup.dart';
import 'package:flutter_webapi_first_course/services/auth/signin_service.dart';
import 'package:flutter_webapi_first_course/services/auth/signup_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _acessToken = "access_token";
  static const String _userId = "user_id";
  static const String _userEmail = "user_email";

  Future<LoginResponse?> login({
    required String email,
    required String password,
  }) async {
    LoginResponse loginResponse =
        await SigninService().post(Signin(email: email, password: password));
    _saveUserInfo(loginResponse);
    return loginResponse;
  }

  Future<LoginResponse?> register({
    required String email,
    required String password,
  }) async {
    LoginResponse loginResponse =
        await SignupService().post(Signup(email: email, password: password));
    _saveUserInfo(loginResponse);
    return loginResponse;
  }

  Future<LoginResponse> getLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString(_acessToken) ?? "";
    String userEmail = sharedPreferences.getString(_userEmail) ?? "";
    String userId = sharedPreferences.getString(_userId) ?? "";
    return LoginResponse(
        accessToken: accessToken, id: userId, email: userEmail);
  }

  _saveUserInfo(LoginResponse? loginResponse) async {
    if (loginResponse == null) {
      return;
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_acessToken, loginResponse.accessToken);
    sharedPreferences.setString(_userEmail, loginResponse.user.email);
    sharedPreferences.setString(_userId, loginResponse.user.id);
  }
}
