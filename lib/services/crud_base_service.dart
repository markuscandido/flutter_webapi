import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_webapi_first_course/helpers/share_preferences_util.dart';
import 'package:flutter_webapi_first_course/services/auth/exceptions/jwt_expired_exception.dart';
import 'package:flutter_webapi_first_course/services/base_service.dart';
import 'package:flutter_webapi_first_course/services/exceptions/api_base_exception.dart';
import 'package:flutter_webapi_first_course/services/exceptions/api_timeout_exception.dart';
import 'package:flutter_webapi_first_course/services/web_client.dart';
import 'package:http/http.dart' as http;

abstract class BaseCrudService<T> extends BaseService {
  final String resource;

  BaseCrudService({required this.resource})
      : super(
          resource: "users/${SharedPrefsUtils.getLogin().user.id}/$resource",
        );

  ///Dado uma entidade, converter para um map
  Map<String, Object?> toMapEntity({required T entity});

  ///Dado um map, converter para uma entidade
  T fromApi({required Map<String, dynamic> jsonMap});

  Future<bool> post({
    required T entity,
  }) async {
    String entityJson = json.encode(toMapEntity(entity: entity));
    http.Response response = await webClient.httpClient
        .post(Uri.parse(getUrl()), body: entityJson)
        .onError<TimeoutException>(
            (error, stackTrace) => throw ApiTimeoutException());

    _ensureSuccessStatusCode(response, HttpStatus.created);
    return true;
  }

  Future<bool> put({
    required String id,
    required T entity,
  }) async {
    String entityJson = json.encode(toMapEntity(entity: entity));
    http.Response response = await webClient.httpClient
        .put(Uri.parse("${WebClient.baseUrl}$resource/$id"), body: entityJson)
        .onError<TimeoutException>(
            (error, stackTrace) => throw ApiTimeoutException());

    _ensureSuccessStatusCode(response, HttpStatus.ok);
    return true;
  }

  Future<List<T>> getAll() async {
    http.Response response = await webClient.httpClient
        .get(Uri.parse(getUrl()))
        .onError<TimeoutException>(
            (error, stackTrace) => throw ApiTimeoutException());
    _ensureSuccessStatusCode(response, HttpStatus.ok);
    List<T> list = [];
    List<dynamic> listDynamic = json.decode(response.body);

    for (var jsonMap in listDynamic) {
      list.add(fromApi(jsonMap: jsonMap));
    }

    return list;
  }

  ///Para o Delete, não é aplicado o padrão de /users/GUID/resource.
  ///É /resource/id
  Future<bool> delete({
    required String id,
  }) async {
    http.Response response = await webClient.httpClient
        .delete(Uri.parse("${WebClient.baseUrl}$resource/$id"))
        .onError<TimeoutException>(
            (error, stackTrace) => throw ApiTimeoutException());
    _ensureSuccessStatusCode(response, HttpStatus.ok);
    return true;
  }

  void _ensureSuccessStatusCode(http.Response response, int httpStatus) {
    if (response.statusCode == httpStatus) {
      return;
    }
    String bodyContent = json.decode(response.body);
    switch (response.statusCode) {
      case HttpStatus.badRequest:
        _badRequest(bodyContent);
        break;
      default:
        throw ApiBaseException(bodyContent);
    }
    throw ApiBaseException(bodyContent);
  }

  void _badRequest(String bodyContent) {
    switch (bodyContent) {
      case "jwt expired":
        throw JwtExpiredException();
      default:
        throw ApiBaseException(bodyContent);
    }
  }
}
