import 'package:expense_tracker/ExpenseItems.dart';
import 'package:expense_tracker/utils/expense.dart';
import 'package:expense_tracker/data/sqlfite/sqflife_helper.dart';
import 'package:flutter/material.dart';

class titleList extends StatefulWidget {
  titleList({
    super.key,
    required this.expense,
    required this.onExpenseDeleted,
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
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) => Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) async {
                try {
                  print("Attempting to delete id: ${snapshot.data![index].id}");
                  String result =
                      await SQLHelper.delete(snapshot.data![index].id);
                  widget.onExpenseDeleted();
                  print(result);
                  setState(() {});
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to delete: $e')),
                  );
                }
              },
              child: ExpenseItems(snapshot.data![index]),
            ),
          );
        }
      },
    );
  }
}
