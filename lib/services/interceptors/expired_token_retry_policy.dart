import 'dart:io';

import 'package:flutter_webapi_first_course/main.dart';
import 'package:flutter_webapi_first_course/screens/login_screen/login_screen.dart';
import 'package:flutter_webapi_first_course/services/auth/navigation_service.dart';
import 'package:http_interceptor/http_interceptor.dart';

class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  int get maxRetryAttempts => 3;

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    if (response.statusCode == HttpStatus.unauthorized) {
      locator<NavigationService>().navigateTo(LoginScreen.routeName);
      return false;
    }
    return false;
  }
}
