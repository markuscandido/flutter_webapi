import 'package:flutter_webapi_first_course/helpers/share_preferences_util.dart';
import 'package:flutter_webapi_first_course/models/auth/login_response.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

class AuthorizationBearerInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    LoginResponse login = SharedPrefsUtils.getLogin();
    data.headers["Authorization"] = "Bearer ${login.accessToken}";
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}
