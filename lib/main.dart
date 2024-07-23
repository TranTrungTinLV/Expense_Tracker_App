import 'package:expense_tracker/homepage.dart';
import 'package:expense_tracker/screen/TotalExpense.dart';
import 'package:expense_tracker/data/sqlfite/sqflife_helper.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xffF5F6F7),
);
void main() {
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
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => const HomePage(),
        Totalexpense.id: (context) => Totalexpense(),
      },
    );
  }
}
