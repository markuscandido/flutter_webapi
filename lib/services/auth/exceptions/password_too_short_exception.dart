import 'dart:io';

class PasswordTooShortException extends HttpException {
  PasswordTooShortException() : super("Password is too short");
}
