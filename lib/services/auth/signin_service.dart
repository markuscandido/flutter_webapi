import 'dart:convert';
import 'dart:io';

import 'package:flutter_webapi_first_course/models/auth/login_response.dart';
import 'package:flutter_webapi_first_course/models/auth/signin.dart';
import 'package:flutter_webapi_first_course/services/auth/exceptions/email_and_password_are_required_exception.dart';
import 'package:flutter_webapi_first_course/services/auth/exceptions/user_not_found_exception.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_webapi_first_course/services/base_crud_service.dart';

class SigninService extends BaseService {
  SigninService() : super(resource: "signin");

  Future<LoginResponse> post(Signin signin) async {
    String entityJson = json.encode(signin.toJsonMap());
    http.Response response =
        await httpClient.post(Uri.parse(getUrl()), body: entityJson);
    if (response.statusCode != HttpStatus.ok) {
      String bodyContent = json.decode(response.body);
      if (response.statusCode == HttpStatus.badRequest) {
        switch (bodyContent) {
          case "Cannot find user":
            throw UserNotFoundException();
          case "Email and password are required":
            throw EmailAndPasswordAreRequiredException();
          default:
        }
      }
      throw HttpException(bodyContent);
    }
    LoginResponse loginResponse =
        LoginResponse.fromJsonMap(json.decode(response.body));
    return loginResponse;
  }
}
