import 'dart:io';

class UserNotFoundException extends HttpException {
  UserNotFoundException() : super("Cannot find user");
}
