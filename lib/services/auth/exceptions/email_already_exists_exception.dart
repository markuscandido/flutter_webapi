import 'dart:io';

class EmailAlreadyExistsException extends HttpException {
  EmailAlreadyExistsException() : super("Email already exists");
}
