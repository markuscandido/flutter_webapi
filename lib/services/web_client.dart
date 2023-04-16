import 'package:flutter_webapi_first_course/services/interceptors/authorization_bearer_interceptor.dart';
import 'package:flutter_webapi_first_course/services/interceptors/default_headers_interceptor.dart';
import 'package:flutter_webapi_first_course/services/interceptors/expired_token_retry_policy.dart';
import 'package:flutter_webapi_first_course/services/interceptors/logging_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

class WebClient {
  ///Define o timeout padrão
  static const int _timeoutInSeconds = 30;

  ///Define qual a url base do gateway
  //static const String url = "https://my-json-server.typicode.com/markuscandido/flutter_webapi_server/";
  static const String baseUrl = "http://192.168.0.108:3000/";

  final bool addAuthorization;
  final List<InterceptorContract> interceptors = [
    DefaultHeadersInterceptor(),
    LoggingInterceptor(),
  ];

  late http.Client httpClient;

  WebClient({this.addAuthorization = true}) {
    if (addAuthorization) {
      interceptors.insert(1, AuthorizationBearerInterceptor());
    }
    httpClient = InterceptedClient.build(
      interceptors: interceptors,
      requestTimeout: const Duration(seconds: _timeoutInSeconds),
      retryPolicy: ExpiredTokenRetryPolicy(),
    );
  }
}
