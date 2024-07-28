import 'package:expense_tracker/ExpenseItems.dart';
import 'package:expense_tracker/utils/expense.dart';
import 'package:expense_tracker/data/sqlfite/sqflife_helper.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class titleList extends StatefulWidget {
  final DateTime selectedDate;
  final String categoryId; // Change this to String

  titleList({
    super.key,
    required this.expense,
    required this.onExpenseDeleted,
    required this.selectedDate,
    required this.categoryId,
  });
  final List<Expense> expense;
  final VoidCallback onExpenseDeleted; // Add this callback

  @override
  State<titleList> createState() => _titleListState();
}

class _titleListState extends State<titleList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SQLHelper.loadExpenses(),
      builder: (BuildContext context, AsyncSnapshot<List<Expense>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No expenses found'));
        } else {
          final filteredExpenses = snapshot.data!
              .where((expense) => expense.categoryId == widget.categoryId)
              .where((expense) => isSameDay(expense.date, widget.selectedDate))
              .toList();
          print("filteredExpenses ${filteredExpenses}");
          if (filteredExpenses.isEmpty) {
            return Center(child: Text('No expenses found'));
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) {
                if (index < 0 || index >= filteredExpenses.length) {
                  return Container(); // Return an empty container if the index is invalid
                }
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) async {
                    try {
                      print(
                          "Attempting to delete id: ${snapshot.data![index].id}");
                      String result =
                          await SQLHelper.delete(filteredExpenses[index].id);
                      widget.onExpenseDeleted();
                      print(result);
                      setState(() {});
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to delete: $e')),
                      );
                    }
                  },
                  child: ExpenseItems(filteredExpenses[index]),
                );
              });
        }
      },
    );
  }
}
