import 'package:flutter/foundation.dart';
import 'package:flutter_webapi_first_course/services/interceptors/default_headers_interceptor.dart';
import 'package:flutter_webapi_first_course/services/interceptors/expired_token_retry_policy.dart';
import 'package:flutter_webapi_first_course/services/interceptors/logging_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

class TodoService {
  static const int timeoutInSeconds = 30;
  static const String url =
      "https://my-json-server.typicode.com/markuscandido/flutter_webapi_server/";
  static const String resource = "todos/";

  http.Client client = InterceptedClient.build(
    interceptors: [
      DefaultHeadersInterceptor(),
      LoggingInterceptor(),
    ],
    retryPolicy: ExpiredTokenRetryPolicy(),
    requestTimeout: const Duration(seconds: timeoutInSeconds),
  );

  String getUrl() {
    return "$url$resource";
  }

  Future<String> get() async {
    http.Response response = await client.get(Uri.parse(getUrl()));
    if (kDebugMode) {
      print(response.body);
    }
    return response.body;
  }
}
