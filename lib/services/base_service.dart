import 'package:flutter_webapi_first_course/services/web_client.dart';

abstract class BaseService {
  final String _resource;
  final bool addAuthorization;
  late final WebClient webClient;

  BaseService({
    required String resource,
    this.addAuthorization = true,
  }) : _resource = resource {
    webClient = WebClient(addAuthorization: addAuthorization);
  }

  String getUrl() => "${WebClient.baseUrl}$_resource/";
}
