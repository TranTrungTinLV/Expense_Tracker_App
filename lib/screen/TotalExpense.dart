import 'package:flutter/material.dart';

class Totalexpense extends StatefulWidget {
  static String id = 'total_expense';
  const Totalexpense({super.key});

  @override
  State<Totalexpense> createState() => _TotalexpenseState();
}

class _TotalexpenseState extends State<Totalexpense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        child: Container(
          width: 50,
          height: 50,
          child: Icon(
            Icons.add,
            size: 40,
          ),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [Color(0xff2fdaff), Color(0xff0E33F3)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft)),
        ),
        onTap: () {
          print("floatingActionButton");
        },
      ),
      backgroundColor: const Color(0xFFF5F6F7),
      appBar: AppBar(
          toolbarHeight: 80.0,
          centerTitle: true,
          title: Text(
            'Total Expense',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
          )),
    );
  }
}
