import 'package:flutter_webapi_first_course/models/journal.dart';

class AddJournalScreenArguments {
  final Journal journal;
  //final DateTime createdAt;
  //final String content;
  final bool isEditing;

  AddJournalScreenArguments({
    //required this.createdAt,
    //required this.content,
    required this.journal,
    required this.isEditing,
  });
}
