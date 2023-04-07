import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/screens/journal_screen/add_journal_screen.dart';
import 'package:flutter_webapi_first_course/screens/journal_screen/add_journal_screen_arguments.dart';

MaterialPageRoute<dynamic> launchAddJournalScreen(RouteSettings settings) {
  final AddJournalScreenArguments arguments =
      settings.arguments as AddJournalScreenArguments;
  return MaterialPageRoute(
      builder: (context) => AddJournalScreen(arguments: arguments));
}
