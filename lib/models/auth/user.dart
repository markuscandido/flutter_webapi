class User {
  final String id;
  final String email;

  User({
    required this.id,
    required this.email,
  });

  User.fromJsonMap({required Map<String, dynamic> jsonMap})
      : id = jsonMap["id"],
        email = jsonMap["email"];

  Map<String, dynamic> toJsonMap() => {"id": id, "email": email};
}
