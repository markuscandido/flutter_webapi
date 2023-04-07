import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_webapi_first_course/models/journal.dart';
import 'package:flutter_webapi_first_course/services/dtos/journal_service_register_request.dart';
import 'package:flutter_webapi_first_course/services/interceptors/default_headers_interceptor.dart';
import 'package:flutter_webapi_first_course/services/interceptors/expired_token_retry_policy.dart';
import 'package:flutter_webapi_first_course/services/interceptors/logging_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

class JournalService {
  static const int timeoutInSeconds = 30;
  //static const String url = "https://my-json-server.typicode.com/markuscandido/flutter_webapi_server/";
  static const String url = "http://192.168.0.108:3000/";
  static const String resource = "journals/";

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

  Future<bool> register({
    required RegisterJournalRequest request,
  }) async {
    Journal journal = Journal.novo(
      content: request.content,
      createdAt: request.createdAt,
    );
    String jsonJournal = json.encode(journal.toMap());
    http.Response response =
        await client.post(Uri.parse(getUrl()), body: jsonJournal);
    return response.statusCode == 201;
  }

  Future<List<Journal>> getAll() async {
    http.Response response = await client.get(Uri.parse(getUrl()));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode != 200) {
      throw Exception();
    }
    List<Journal> list = [];
    List<dynamic> listDynamic = json.decode(response.body);

    for (var jsonMap in listDynamic) {
      list.add(Journal.fromApi(jsonMap: jsonMap));
    }

    return list;
  }
}
