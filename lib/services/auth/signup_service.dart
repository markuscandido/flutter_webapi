import 'dart:convert';
import 'dart:io';

import 'package:flutter_webapi_first_course/models/auth/login_response.dart';
import 'package:flutter_webapi_first_course/services/auth/exceptions/email_already_exists_exception.dart';
import 'package:flutter_webapi_first_course/services/base_service.dart';
import 'package:flutter_webapi_first_course/services/exceptions/api_base_exception.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_webapi_first_course/models/auth/signup.dart';

class SignupService extends BaseService {
  SignupService() : super(resource: "signup", addAuthorization: false);

  Future<LoginResponse> post(Signup signup) async {
    String entityJson = json.encode(signup.toJsonMap());
    http.Response response =
        await webClient.httpClient.post(Uri.parse(getUrl()), body: entityJson);
    if (response.statusCode != HttpStatus.created) {
      String body = json.decode(response.body);
      switch (response.statusCode) {
        case HttpStatus.badRequest:
          _badRequest(body: body);
          break;
        default:
          throw ApiBaseException(body);
      }
    }
    LoginResponse loginResponse =
        LoginResponse.fromJsonMap(json.decode(response.body));
    return loginResponse;
  }

  void _badRequest({required String body}) {
    switch (body) {
      case "Email already exists":
        throw EmailAlreadyExistsException();
      default:
        throw ApiBaseException(body);
    }
  }
}
