import 'package:flutter_webapi_first_course/services/exceptions/bad_request_api_base_exception.dart';

class EmailAlreadyExistsException extends BadRequestApiBaseException {
  EmailAlreadyExistsException() : super("Email already exists");
}
