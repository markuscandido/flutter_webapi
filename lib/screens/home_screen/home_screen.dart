import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/helpers/share_preferences_util.dart';
import 'package:flutter_webapi_first_course/models/journal.dart';
import 'package:flutter_webapi_first_course/screens/common/confirmation_dialog.dart';
import 'package:flutter_webapi_first_course/screens/home_screen/widgets/home_screen_list.dart';
import 'package:flutter_webapi_first_course/screens/login_screen/login_screen.dart';
import 'package:flutter_webapi_first_course/services/journal_service.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'homeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // O último dia apresentado na lista
  DateTime currentDay = DateTime.now();

  // Tamanho da lista
  int windowPage = 7;

  // A base de dados mostrada na lista
  Map<String, Journal> database = {};

  final ScrollController _listScrollController = ScrollController();
  final JournalService _service = JournalService();

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Título basado no dia atual
        title: Text(
          "${currentDay.day}  |  ${currentDay.month}  |  ${currentDay.year}",
        ),
        actions: [
          IconButton(
            onPressed: () => refresh(),
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                _logout();
              },
              title: const Text("Sair"),
              leading: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
      body: ListView(
        controller: _listScrollController,
        children: generateListJournalCards(
          refreshFunc: refresh,
          windowPage: windowPage,
          currentDay: currentDay,
          database: database,
        ),
      ),
    );
  }

  void refresh() async {
    List<Journal> listJournal = await _service.getAll();
    setState(() {
      database = {};
      for (Journal journal in listJournal) {
        database[journal.id] = journal;
      }
    });
  }

  void _logout() {
    showConfirmationDialog(
      context,
      title: "Sair",
      content: "Deseja mesmo sair?",
      affirmativeActionTitle: "Sair",
    ).then((confirm) {
      if (confirm == null || confirm == false) {
        return;
      }
      SharedPrefsUtils.setLogout();
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });
  }
}
