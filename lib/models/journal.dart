import 'dart:convert';

import 'package:uuid/uuid.dart';

class Journal {
  final String id;
  String content;
  final DateTime createdAt;
  DateTime updatedAt;

  Journal.novo({
    required this.content,
    required this.createdAt,
  })  : id = const Uuid().v1(),
        updatedAt = DateTime.now();

  Journal.fromDatabase({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  Journal.fromApi({required Map<String, dynamic> jsonMap})
      : id = jsonMap["id"],
        content = jsonMap["content"],
        createdAt = DateTime.parse(jsonMap["createdAt"]),
        updatedAt = DateTime.parse(jsonMap["updatedAt"]);

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "content": content,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return json.encode(toMap());
  }
}
