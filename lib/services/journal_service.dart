import 'package:flutter/foundation.dart';
import 'package:flutter_webapi_first_course/services/interceptors/default_headers_interceptor.dart';
import 'package:flutter_webapi_first_course/services/interceptors/expired_token_retry_policy.dart';
import 'package:flutter_webapi_first_course/services/interceptors/logging_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

class JournalService {
  static const int timeoutInSeconds = 30;
  static const String url = "http://192.168.0.142:3000/";
  static const String resource = "learnhttp/";

  http.Client client = InterceptedClient.build(
      interceptors: [
        DefaultHeadersInterceptor(),
        LoggingInterceptor(),
      ],
      retryPolicy: ExpiredTokenRetryPolicy(),
      requestTimeout: const Duration(seconds: timeoutInSeconds));

  String getUrl() {
    return "$url$resource";
  }

  void register(String content) {
    client.post(Uri.parse(getUrl()), body: {
      "content": content,
    });
  }

  Future<String> get() async {
    http.Response response = await client.get(Uri.parse(getUrl()));
    if (kDebugMode) {
      print(response.body);
    }
    return response.body;
  }
}
