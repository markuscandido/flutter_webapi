import 'package:flutter_webapi_first_course/helpers/share_preferences_util.dart';
import 'package:flutter_webapi_first_course/models/auth/login_response.dart';
import 'package:flutter_webapi_first_course/models/auth/signin.dart';
import 'package:flutter_webapi_first_course/models/auth/signup.dart';
import 'package:flutter_webapi_first_course/services/auth/signin_service.dart';
import 'package:flutter_webapi_first_course/services/auth/signup_service.dart';

class AuthService {
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    LoginResponse loginResponse =
        await SigninService().post(Signin(email: email, password: password));
    _saveUserInfo(loginResponse);
    return true;
  }

  Future<bool> register({
    required String email,
    required String password,
  }) async {
    LoginResponse loginResponse =
        await SignupService().post(Signup(email: email, password: password));
    _saveUserInfo(loginResponse);
    return true;
  }

  _saveUserInfo(LoginResponse? loginResponse) async {
    if (loginResponse == null) {
      return;
    }
    SharedPrefsUtils.setLogin(loginResponse);
  }
}
