import 'package:flutter_webapi_first_course/services/exceptions/bad_request_api_base_exception.dart';

class UserNotFoundException extends BadRequestApiBaseException {
  UserNotFoundException() : super("Cannot find user");
}
