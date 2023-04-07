import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/screens/journal_screen/add_journal_screen.dart';
import 'package:flutter_webapi_first_course/screens/journal_screen/add_journal_screen_page_route.dart';
import 'screens/home_screen/home_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MVC::Simple Journal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.white,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        //textTheme: GoogleFonts.robotoTextTheme(),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      //themeMode: ThemeMode.system,
      initialRoute: 'homeScreen',
      routes: {
        'homeScreen': (context) => const HomeScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AddJournalScreen.routeName) {
          return launchAddJournalScreen(settings);
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}
