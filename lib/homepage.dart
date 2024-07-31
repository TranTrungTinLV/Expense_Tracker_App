import 'package:expense_tracker/Carousel.dart';
import 'package:expense_tracker/EmptyCart.dart';
import 'package:expense_tracker/ListTitle.dart';
import 'package:expense_tracker/category_list.dart';
import 'package:expense_tracker/new_totalExpense.dart';
import 'package:expense_tracker/utils/categories_expense.dart';
import 'package:expense_tracker/utils/expense.dart';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  static String id = 'home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Expense> _registeredExpense = [];
  final List<CategoriesExpense> _registeredCategories = [];
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  //Total Expense
  void _addCategoriesExpense(CategoriesExpense categories_expense) {
    setState(() {
      _registeredCategories.add(categories_expense);
    });
  }

  //function action add
  void _openAddExpenseOverlay() {
    showMaterialModalBottomSheet(
        context: context,
        barrierColor: Colors.black.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        builder: (context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 600,
              padding: EdgeInsets.all(32.0),
              child: NewTotalexpense(
                onAddExpense: _addCategoriesExpense,
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: IconButton(
        //   onPressed: _openAddExpenseOverlay,
        //   icon: Icon(
        //     Icons.add,
        //     color: Colors.black,
        //     size: 35,
        //   ),
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
            Container(),
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
            Container(
              padding: EdgeInsets.only(top: 30, bottom: 30),
              // scrollDirection: Axis.horizontal,
              child: CategoryList(
                expense: _registeredCategories,
                onTap: _openAddExpenseOverlay,
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
                  // Expanded(
                  //     child: Container(
                  //         height: 100,
                  //         margin: EdgeInsets.only(
                  //             left: 10, right: 10, top: 24, bottom: 50),
                  //         padding: EdgeInsets.only(bottom: 30),
                  //         child: titleList(
                  //           expense: _registeredExpense,
                  //           onExpenseDeleted: () {},
                  //           // selectedDate: ,
                  //         )))
                ]),
              ),
            ),
          ],
        ));
  }
}
