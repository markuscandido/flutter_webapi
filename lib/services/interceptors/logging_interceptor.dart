import 'package:flutter/foundation.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor implements InterceptorContract {
  Logger logger = Logger();

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    if (kDebugMode) {
      logger.v(
        "${methodToString(data.method)} ${data.baseUrl}\nencoding: ${data.encoding?.name}\nheaders: ${data.headers}\nbody: ${data.body}",
      );
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (kDebugMode) {
      if (data.statusCode >= 200 && data.statusCode <= 299) {
        logger.i(
          "statusCode: ${data.statusCode}\nheaders: ${data.headers}\nurl: ${data.url}\nBody: ${data.body}",
        );
      } else {
        logger.e(
          "statusCode: ${data.statusCode}\nheaders: ${data.headers}\nurl: ${data.url}\nBody: ${data.body}",
        );
      }
    }
    return data;
  }
}
