import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_webapi_first_course/helpers/share_preferences_util.dart';
import 'package:flutter_webapi_first_course/services/base_service.dart';
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

  ///Para o Delete, não é aplicado o padrão de /users/GUID/resource.
  ///É /resource/id
  Future<bool> delete({
    required String id,
  }) async {
    http.Response response =
        await httpClient.delete(Uri.parse("$baseUrl$resource/$id"));
    return response.statusCode == HttpStatus.ok;
  }
}
