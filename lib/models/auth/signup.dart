import 'package:uuid/uuid.dart';

class Signup {
  final String id;
  final String email;
  final String password;
  Signup({
    required this.email,
    required this.password,
  }) : id = const Uuid().v1();

  Map<String, dynamic> toJsonMap() => {
        "id": id,
        "email": email,
        "password": password,
      };
}
