import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/helpers/weekday.dart';
import 'package:flutter_webapi_first_course/screens/journal_screen/add_journal_screen_arguments.dart';
import 'package:flutter_webapi_first_course/services/dtos/journal_service_register_request.dart';
import 'package:flutter_webapi_first_course/services/journal_service.dart';

class AddJournalScreen extends StatelessWidget {
  final AddJournalScreenArguments arguments;
  static const routeName = 'addJournalScreen';

  final TextEditingController _contentController = TextEditingController();
  final JournalService _journalService = JournalService();

  AddJournalScreen({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${WeekDay(arguments.createdAt.weekday).long.toLowerCase()}, ${arguments.createdAt.day} | ${arguments.createdAt.month} | ${arguments.createdAt.year}",
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

  registerNewJournal(BuildContext context) async {
    String content = _contentController.text;
    bool success = await _journalService.register(
      request: RegisterJournalRequest(
        content: content,
        createdAt: arguments.createdAt,
      ),
    );
    if (context.mounted) {
      Navigator.of(context).pop(success);
    }
  }
}
