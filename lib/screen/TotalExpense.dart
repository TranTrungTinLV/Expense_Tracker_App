import 'package:expense_tracker/ListTitle.dart';
import 'package:expense_tracker/expense.dart';
import 'package:expense_tracker/utils/chart_graph.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Totalexpense extends StatefulWidget {
  static String id = 'total_expense';
  const Totalexpense({super.key});

  @override
  State<Totalexpense> createState() => _TotalexpenseState();
}

class _TotalexpenseState extends State<Totalexpense> {
  DateTime today = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  final List<Expense> _registeredExpense = [
    Expense(
      'Description 1',
      title: 'Expense 1',
      date: DateTime.now(),
      amount: 100,
      source: 'Source 1',
      category: Category.Food,
    ),
    Expense(
      'Description 2',
      title: 'Expense 2',
      date: DateTime.now(),
      amount: 200,
      source: 'Source 2',
      category: Category.Advertising,
    ),
    Expense(
      'Description 3',
      title: 'Expense 3',
      date: DateTime.now(),
      amount: 150,
      source: 'Source 3',
      category: Category.Travel,
    ),
    Expense(
      'Description 4',
      title: 'Expense 4',
      date: DateTime.now(),
      amount: 50,
      source: 'Source 4',
      category: Category.Work,
    ),
    Expense(
      'Description 5',
      title: 'Expense 5',
      date: DateTime.now(),
      amount: 75,
      source: 'Source 5',
      category: Category.Telephone,
    ),
  ];
  List<ExpenseBucket> getDailyExpenseBuckets() {
    // Tạo các ExpenseBucket từ chi phí hàng ngày
    List<ExpenseBucket> buckets = [];
    for (Category category in Category.values) {
      buckets.add(ExpenseBucket.forCategory(
        _registeredExpense
            .where((expense) => isSameDay(expense.date, today))
            .toList(),
        category,
      ));
    }
    return buckets;
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

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
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            margin: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            // color: Colors.red,
            // width: 400,
            height: 200,
            child: Column(children: [
              TableCalendar(
                calendarFormat: _calendarFormat,
                calendarStyle: CalendarStyle(
                    isTodayHighlighted: true,
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    )),
                locale: 'en_US',
                focusedDay: today,
                headerStyle: HeaderStyle(
                    formatButtonVisible: false, titleCentered: true),
                availableGestures: AvailableGestures.all,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 12, 29),
                onDaySelected: _onDaySelected,
                selectedDayPredicate: (day) => isSameDay(day, today),
              ),
            ]),
          ),
          Container(
            width: 200.0,
            height: 200.0,
            padding: EdgeInsets.symmetric(vertical: 82, horizontal: 21),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment(1, 1),
                    end: Alignment(-1, 1),
                    stops: <double>[0, 1],
                    colors: [Color(0xFF2FDAFF), Color(0xFF0E33F3)]),
                border: Border.all(color: Color(0x662FD9FF), width: 2.0)),
            child: Text(
              '12,000 vnđ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, color: Colors.white),
            ),
          ),
          Container(
            width: 200.0,
            margin: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'You have Spend total 60% of you budget',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
          ),
          // Expanded(
          Container(
            // color: Colors.white,
            height: 800,
            margin: EdgeInsets.only(top: 32),
            padding: EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0))),
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(
                        child: Text("Spends"),
                      ),
                      Tab(
                        child: Text("Categories"),
                      )
                    ],
                  ),
                  // SizedBox(
                  // height: 450,
                  // color: Colors.black,
                  // color: Colors.pink,
                  Expanded(
                    child: TabBarView(
                      children: [
                        Container(
                            child: titleList(
                          expense: _registeredExpense,
                        )),
                        // SingleChildScrollView(

                        SingleChildScrollView(
                          child: Container(
                            height: 450, // Adjusted height for ChartGraph
                            child: ChartGraph(
                              expenseBuckets: getDailyExpenseBuckets(),
                            ),
                          ),
                        ),
                        // )
                      ],
                    ),
                  ),
                  // ),
                ],
              ),
            ),
          ),
          // )
        ]),
      ),
    );
  }
}
