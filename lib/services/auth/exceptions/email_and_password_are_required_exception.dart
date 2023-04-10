import 'dart:io';

class EmailAndPasswordAreRequiredException extends HttpException {
  EmailAndPasswordAreRequiredException()
      : super("Email and password are required");
}
