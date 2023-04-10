import 'package:flutter_webapi_first_course/models/journal.dart';
import 'package:flutter_webapi_first_course/services/base_crud_service.dart';

class JournalService extends BaseCrudService<Journal> {
  JournalService() : super(resource: "journals");

  @override
  Map<String, Object?> toMapEntity({required Journal entity}) => entity.toMap();

  @override
  Journal fromApi({required Map<String, dynamic> jsonMap}) =>
      Journal.fromApi(jsonMap: jsonMap);
}
