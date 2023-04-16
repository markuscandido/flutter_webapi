import 'package:flutter_webapi_first_course/models/journal.dart';

class AddJournalScreenArguments {
  final Journal journal;
  final bool isEditing;

  AddJournalScreenArguments({
    required this.journal,
    required this.isEditing,
  });
}
