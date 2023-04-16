import 'package:flutter_webapi_first_course/services/exceptions/bad_request_api_base_exception.dart';

class EmailAndPasswordAreRequiredException extends BadRequestApiBaseException {
  EmailAndPasswordAreRequiredException()
      : super("Email and password are required");
}
