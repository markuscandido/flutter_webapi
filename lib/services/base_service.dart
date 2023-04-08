import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_webapi_first_course/services/interceptors/default_headers_interceptor.dart';
import 'package:flutter_webapi_first_course/services/interceptors/expired_token_retry_policy.dart';
import 'package:flutter_webapi_first_course/services/interceptors/logging_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

///Classe base para integração com a API (Backend)
abstract class BaseService<T> {
  ///Define o timeout padrão
  static const int _timeoutInSeconds = 30;

  ///Define qual a url base do gateway
  //static const String url = "https://my-json-server.typicode.com/markuscandido/flutter_webapi_server/";
  static const String _url = "http://192.168.0.108:3000/";

  ///Define o recurso que a classe concreta irá manipular, seguindo o padrão RestFull.
  final String resource;
  final http.Client _httpClient = InterceptedClient.build(
    interceptors: [
      DefaultHeadersInterceptor(),
      LoggingInterceptor(),
    ],
    requestTimeout: const Duration(seconds: _timeoutInSeconds),
    retryPolicy: ExpiredTokenRetryPolicy(),
  );

  BaseService({required this.resource});

  String _getUrl() => "$_url$resource/";

  ///Dado uma entidade, converter para um map
  Map<String, Object?> toMapEntity({required T entity});

  ///Dado um map, converter para uma entidade
  T fromApi({required Map<String, dynamic> jsonMap});

  Future<bool> post({
    required T entity,
  }) async {
    String entityJson = json.encode(toMapEntity(entity: entity));
    http.Response response =
        await _httpClient.post(Uri.parse(_getUrl()), body: entityJson);
    return response.statusCode == HttpStatus.created;
  }

  Future<bool> put({
    required String id,
    required T entity,
  }) async {
    String entityJson = json.encode(toMapEntity(entity: entity));

    http.Response response =
        await _httpClient.put(Uri.parse("${_getUrl()}$id"), body: entityJson);
    return response.statusCode == HttpStatus.ok;
  }

  Future<List<T>> getAll() async {
    http.Response response = await _httpClient.get(Uri.parse(_getUrl()));
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
        await _httpClient.delete(Uri.parse("${_getUrl()}$id"));
    return response.statusCode == HttpStatus.ok;
  }
}
