import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/helpers/weekday.dart';
import 'package:flutter_webapi_first_course/models/journal.dart';
import 'package:flutter_webapi_first_course/screens/journal_screen/add_journal_screen_arguments.dart';
import 'package:flutter_webapi_first_course/services/journal_service.dart';

class AddJournalScreen extends StatelessWidget {
  final AddJournalScreenArguments arguments;
  static const routeName = 'addJournalScreen';

  final TextEditingController _contentController = TextEditingController();
  final JournalService _journalService = JournalService();

  AddJournalScreen({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    _contentController.text = arguments.journal.content;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${WeekDay(arguments.journal.createdAt.weekday).long.toLowerCase()}, ${arguments.journal.createdAt.day} | ${arguments.journal.createdAt.month} | ${arguments.journal.createdAt.year}",
        ),
        actions: [
          IconButton(
            onPressed: () => registerNewJournal(context),
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _contentController,
          keyboardType: TextInputType.multiline,
          style: const TextStyle(fontSize: 24.0),
          expands: true,
          maxLines: null,
          minLines: null,
        ),
      ),
    );
  }

  registerNewJournal(BuildContext context) {
    Journal journal = arguments.journal;
    String content = _contentController.text;
    journal.content = content;
    if (arguments.isEditing) {
      _journalService.put(id: journal.id, entity: journal).then((success) {
        Navigator.of(context).pop(success);
      });
    } else {
      _journalService.post(entity: journal).then((success) {
        Navigator.of(context).pop(success);
      });
    }
  }
}
