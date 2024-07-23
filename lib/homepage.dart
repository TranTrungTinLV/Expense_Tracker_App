import 'package:expense_tracker/Carousel.dart';
import 'package:expense_tracker/EmptyCart.dart';
import 'package:expense_tracker/ListTitle.dart';
import 'package:expense_tracker/expense.dart';
import 'package:expense_tracker/new_expense.dart';
import 'package:expense_tracker/screen/TotalExpense.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:popover/popover.dart';

class HomePage extends StatefulWidget {
  static String id = 'home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Expense> _registeredExpense = [];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  //function action add
  void _openAddExpenseOverlay() {
    showMaterialModalBottomSheet(
        context: context,
        barrierColor: Colors.black.withOpacity(0.5),
        // isScrollControlled: true,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        builder: (context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 400,
              padding: EdgeInsets.all(32.0),
              child: NewExpense(
                onAddExpense: _addExpense,
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: IconButton(
          onPressed: _openAddExpenseOverlay,
          icon: Icon(
            Icons.add,
            color: Colors.black,
            size: 35,
          ),
        ),

        // onTap: _openAddExpenseOverlay,
        // ),
        backgroundColor: const Color(0xFFF5F6F7),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 80.0,
          title: const Padding(
              padding: EdgeInsets.only(top: 16, left: 16),
              child: Text(
                'Overview',
                style: TextStyle(fontSize: 24.0),
                textAlign: TextAlign.start,
              )),
          actions: <Widget>[
            Container(
                // width: 10000,
                ),
            Container(
              padding: const EdgeInsets.only(top: 20, right: 30),
              child: PopupMenuButton(
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    
                    child: Text('Light'),
                  ),
                  PopupMenuItem(
                    child: Text('Dark'),
                  ),
                  PopupMenuItem(
                    child: Text('Profile'),
                  ),
                ],
                child: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://static.wikia.nocookie.net/shingekinokyojin/images/0/0a/Levi_Ackermann_%28Anime%29_character_image_%28854%29.png/revision/latest/scale-to-width/360?cb=20231106070611'),
                ),
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 30, bottom: 30),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  // EmptyCard(
                  //   icon: FontAwesomeIcons.wallet,
                  //   amount: '1.000.000',
                  //   title: 'Total Salary',
                  //   vertical: 10.0,
                  //   horizontal: 30.0,
                  //   onTap: () {
                  //     setState(() {
                  //       print("Hello");
                  //     });
                  //   },
                  // ),
                  EmptyCard(
                    icon: FontAwesomeIcons.wallet,
                    amount: '1.000.000',
                    title: 'Total Expense',
                    horizontal: 20.0,
                    vertical: 10.0,
                    onTap: () {
                      print("Total Expense");
                      Navigator.pushNamed(context, Totalexpense.id);
                    },
                  ),
                  Container(),
                  EmptyCard(
                    icon: FontAwesomeIcons.wallet,
                    amount: '1.000.000',
                    title: 'Monthly',
                    vertical: 20.0,
                    horizontal: 10.0,
                    onTap: () {
                      print("Monthly");
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0))),
                child: Column(children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //   icon: Icons.add,
                      //   horizontal: 20,
                      //   vertical: 30,
                      //   title: 'Savings',
                      // ),
                      Carousel(
                        icon: Icons.notifications,
                        horizontal: 0,
                        vertical: 30,
                        title: 'Remind',
                      ),
                      Carousel(
                        icon: Icons.wallet,
                        horizontal: 20,
                        vertical: 30,
                        title: 'Savings',
                      ),
                    ],
                  ),
                  Container(
                    width: 400,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "Latest Entries",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            width: 100,
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                border: Border.all(color: Color(0xFFB0B8BF))),
                            child: Icon(
                              size: 30.0,
                              Icons.more_horiz,
                            ),
                          ),
                        ]),
                  ),
                  Expanded(
                      child: Container(
                          height: 100,
                          margin: EdgeInsets.only(
                              left: 10, right: 10, top: 24, bottom: 50),
                          padding: EdgeInsets.only(bottom: 30),
                          child: titleList(
                            expense: _registeredExpense,
                          )))
                ]),
              ),
            ),
          ],
        ));
  }
}
