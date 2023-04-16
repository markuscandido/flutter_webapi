import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/helpers/share_preferences_util.dart';
import 'package:flutter_webapi_first_course/helpers/weekday.dart';
import 'package:flutter_webapi_first_course/models/journal.dart';
import 'package:flutter_webapi_first_course/screens/common/confirmation_dialog.dart';
import 'package:flutter_webapi_first_course/screens/journal_screen/add_journal_screen.dart';
import 'package:flutter_webapi_first_course/screens/journal_screen/add_journal_screen_arguments.dart';
import 'package:flutter_webapi_first_course/services/journal_service.dart';

class JournalCard extends StatelessWidget {
  final Journal? journal;
  final DateTime showedDate;
  final Function refreshFunc;
  const JournalCard({
    Key? key,
    this.journal,
    required this.showedDate,
    required this.refreshFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (journal != null) {
      return InkWell(
        onTap: () {
          callAddJournalScreen(context);
        },
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
              IconButton(
                  onPressed: () => removeItem(context),
                  icon: const Icon(Icons.delete))
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

  void removeItem(BuildContext context) {
    if (journal != null) {
      showConfirmationDialog(context).then((confirm) {
        if (confirm == null) {
          return;
        }
        if (!confirm) {
          return;
        }
        JournalService().delete(id: journal!.id).then((success) {
          if (success) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Removido com sucesso!")));
            refreshFunc();
          }
        });
      });
    }
  }

  void callAddJournalScreen(BuildContext context) {
    String userId = SharedPrefsUtils.getLogin().user.id;
    Journal innnerJournal = Journal.novo(
      userId: userId,
      content: "",
      createdAt: showedDate,
    );
    if (journal != null) {
      innnerJournal = journal!;
    }
    Navigator.pushNamed(
      context,
      AddJournalScreen.routeName,
      arguments: AddJournalScreenArguments(
        journal: innnerJournal,
        isEditing: journal != null,
      ),
    ).then((success) {
      refreshFunc();
      if (success != null && success == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registro feito com sucesso!'),
          ),
        );
      }
    });
  }
}
