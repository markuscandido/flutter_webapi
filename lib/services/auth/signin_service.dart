import 'dart:convert';
import 'dart:io';

import 'package:flutter_webapi_first_course/models/auth/login_response.dart';
import 'package:flutter_webapi_first_course/models/auth/signin.dart';
import 'package:flutter_webapi_first_course/services/auth/exceptions/email_and_password_are_required_exception.dart';
import 'package:flutter_webapi_first_course/services/auth/exceptions/email_or_password_invalid_exception.dart';
import 'package:flutter_webapi_first_course/services/auth/exceptions/user_not_found_exception.dart';
import 'package:flutter_webapi_first_course/services/base_service.dart';
import 'package:flutter_webapi_first_course/services/exceptions/api_base_exception.dart';
import 'package:http/http.dart' as http;

class SigninService extends BaseService {
  SigninService() : super(resource: "signin", addAuthorization: false);

  Future<LoginResponse> post(Signin signin) async {
    String entityJson = json.encode(signin.toJsonMap());
    http.Response response =
        await webClient.httpClient.post(Uri.parse(getUrl()), body: entityJson);
    if (response.statusCode != HttpStatus.ok) {
      String bodyContent = json.decode(response.body);
      switch (response.statusCode) {
        case HttpStatus.badRequest:
          _badRequest(bodyContent);
          break;
        default:
          throw ApiBaseException(bodyContent);
      }
      throw ApiBaseException(bodyContent);
    }
    LoginResponse loginResponse =
        LoginResponse.fromJsonMap(json.decode(response.body));
    return loginResponse;
  }

  void _badRequest(String bodyContent) {
    switch (bodyContent) {
      case "Cannot find user":
        throw UserNotFoundException();
      case "Email and password are required":
        throw EmailAndPasswordAreRequiredException();
      case "Password is too short":
        throw EmailOrPasswordInvalidException();
      case "Incorrect password":
        throw EmailOrPasswordInvalidException();
      default:
        throw ApiBaseException(bodyContent);
    }
  }
}
