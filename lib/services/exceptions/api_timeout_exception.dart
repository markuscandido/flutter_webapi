import 'package:flutter_webapi_first_course/services/exceptions/api_base_exception.dart';

class ApiTimeoutException extends ApiBaseException {
  ApiTimeoutException()
      : super("O servidor não respondeu, tente novamente mais tarde.");
}
