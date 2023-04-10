import 'dart:convert';
import 'dart:io';

import 'package:flutter_webapi_first_course/models/auth/login_response.dart';
import 'package:flutter_webapi_first_course/services/auth/exceptions/email_already_exists_exception.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_webapi_first_course/models/auth/signup.dart';
import 'package:flutter_webapi_first_course/services/base_crud_service.dart';

class SignupService extends BaseService {
  SignupService() : super(resource: "signup");

  Future<LoginResponse> post(Signup signup) async {
    String entityJson = json.encode(signup.toJsonMap());
    http.Response response =
        await httpClient.post(Uri.parse(getUrl()), body: entityJson);
    if (response.statusCode != HttpStatus.created) {
      String body = json.decode(response.body);
      if (response.statusCode == HttpStatus.badRequest) {
        switch (body) {
          case "Email already exists":
            throw EmailAlreadyExistsException();
        }
      }
      throw HttpException(body);
    }
    LoginResponse loginResponse =
        LoginResponse.fromJsonMap(json.decode(response.body));
    return loginResponse;
  }
}
