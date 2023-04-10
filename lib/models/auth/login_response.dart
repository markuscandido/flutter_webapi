import 'package:flutter_webapi_first_course/models/auth/user.dart';

class LoginResponse {
  final String accessToken;
  final User user;

  LoginResponse({
    required this.accessToken,
    required String id,
    required String email,
  }) : user = User(id: id, email: email);

  LoginResponse.fromJsonMap(Map<String, dynamic> jsonMap)
      : accessToken = jsonMap["accessToken"],
        user = User.fromJsonMap(
          jsonMap: jsonMap["user"],
        );
}
