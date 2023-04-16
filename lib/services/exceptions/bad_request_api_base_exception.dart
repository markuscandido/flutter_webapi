import 'package:flutter_webapi_first_course/services/exceptions/api_base_exception.dart';

abstract class BadRequestApiBaseException extends ApiBaseException {
  BadRequestApiBaseException(super.message);
}
