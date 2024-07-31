import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:expense_tracker/homepage.dart';
import 'package:expense_tracker/screen/TotalExpense.dart';
import 'package:expense_tracker/data/sqlfite/sqflife_helper.dart';
import 'package:expense_tracker/splashScreen.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xffF5F6F7),
);
void main() {
  AwesomeNotifications().initialize(null, []);
  WidgetsFlutterBinding.ensureInitialized();
  SQLHelper.getDatabase;
  runApp(const myExpense());
}

class myExpense extends StatelessWidget {
  const myExpense({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
      initialRoute: Splashscreen.id,
      routes: {
        Splashscreen.id: (context) => const Splashscreen(),
        HomePage.id: (context) => const HomePage(),
        Totalexpense.id: (context) => Totalexpense(),
      },
    );
  }
}
