import 'package:flutter_webapi_first_course/models/api_entity.dart';

class Signin implements ApiEntityRequest<Signin> {
  final String email;
  final String password;

  Signin({required this.email, required this.password});

  @override
  Map<String, dynamic> toJsonMap() => {
        "email": email,
        "password": password,
      };
}
