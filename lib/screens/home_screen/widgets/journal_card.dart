import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/helpers/weekday.dart';
import 'package:flutter_webapi_first_course/models/journal.dart';
import 'package:flutter_webapi_first_course/screens/journal_screen/add_journal_screen.dart';
import 'package:flutter_webapi_first_course/screens/journal_screen/add_journal_screen_arguments.dart';

class JournalCard extends StatelessWidget {
  final Journal? journal;
  final DateTime showedDate;
  final Function refreshFunc;
  const JournalCard(
      {Key? key,
      this.journal,
      required this.showedDate,
      required this.refreshFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (journal != null) {
      return InkWell(
        onTap: () {},
        child: Container(
          height: 115,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black87,
            ),
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    height: 75,
                    width: 75,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      border: Border(
                          right: BorderSide(color: Colors.black87),
                          bottom: BorderSide(color: Colors.black87)),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      journal!.createdAt.day.toString(),
                      style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 38,
                    width: 75,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Colors.black87),
                      ),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Text(WeekDay(journal!.createdAt.weekday).short),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    journal!.content,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          callAddJournalScreen(context);
        },
        child: Container(
          height: 115,
          alignment: Alignment.center,
          child: Text(
            "${WeekDay(showedDate.weekday).short} - ${showedDate.day}",
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  void callAddJournalScreen(BuildContext context) {
    Navigator.pushNamed(
      context,
      AddJournalScreen.routeName,
      arguments: AddJournalScreenArguments(
        createdAt: showedDate,
      ),
    ).then((value) {
      refreshFunc();
      if (value != null && value == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registro feito com sucesso!'),
          ),
        );
      }
    });
  }
}
