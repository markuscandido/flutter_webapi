import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_webapi_first_course/services/interceptors/default_headers_interceptor.dart';
import 'package:flutter_webapi_first_course/services/interceptors/expired_token_retry_policy.dart';
import 'package:flutter_webapi_first_course/services/interceptors/logging_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

abstract class BaseService {
  ///Define o timeout padrão
  static const int _timeoutInSeconds = 30;

  ///Define qual a url base do gateway
  //static const String url = "https://my-json-server.typicode.com/markuscandido/flutter_webapi_server/";
  static const String _url = "http://192.168.0.108:3000/";

  final String resource;

  BaseService({required this.resource});

  final http.Client httpClient = InterceptedClient.build(
    interceptors: [
      DefaultHeadersInterceptor(),
      LoggingInterceptor(),
    ],
    requestTimeout: const Duration(seconds: _timeoutInSeconds),
    retryPolicy: ExpiredTokenRetryPolicy(),
  );

  String getUrl() => "$_url$resource/";
}

abstract class BaseCrudService<T> extends BaseService {
  BaseCrudService({required String resource}) : super(resource: resource);

  ///Dado uma entidade, converter para um map
  Map<String, Object?> toMapEntity({required T entity});

  ///Dado um map, converter para uma entidade
  T fromApi({required Map<String, dynamic> jsonMap});

  Future<bool> post({
    required T entity,
  }) async {
    String entityJson = json.encode(toMapEntity(entity: entity));
    http.Response response =
        await httpClient.post(Uri.parse(getUrl()), body: entityJson);
    return response.statusCode == HttpStatus.created;
  }

  Future<bool> put({
    required String id,
    required T entity,
  }) async {
    String entityJson = json.encode(toMapEntity(entity: entity));

    http.Response response =
        await httpClient.put(Uri.parse("${getUrl()}$id"), body: entityJson);
    return response.statusCode == HttpStatus.ok;
  }

  Future<List<T>> getAll() async {
    http.Response response = await httpClient.get(Uri.parse(getUrl()));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode != HttpStatus.ok) {
      throw Exception();
    }
    List<T> list = [];
    List<dynamic> listDynamic = json.decode(response.body);

    for (var jsonMap in listDynamic) {
      list.add(fromApi(jsonMap: jsonMap));
    }

    return list;
  }

  Future<bool> delete({
    required String id,
  }) async {
    http.Response response =
        await httpClient.delete(Uri.parse("${getUrl()}$id"));
    return response.statusCode == HttpStatus.ok;
  }
}
