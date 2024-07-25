import 'package:expense_tracker/EmptyCart.dart';
import 'package:expense_tracker/utils/categories_expense.dart';
import 'package:expense_tracker/data/sqlfite/sqflife_helper.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  CategoryList({
    super.key,
    required this.expense,
  });
  final List<CategoriesExpense> expense;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SQLHelper.loadCategoriesExpenses(),
      builder: (BuildContext context,
          AsyncSnapshot<List<CategoriesExpense>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'No categories found',
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  snapshot.data!.map((expense) => EmptyCard(expense)).toList(),
            ),
          );
          // return ListView.builder(
          // shrinkWrap: true,
          // itemCount: snapshot.data!.length,
          // itemBuilder: (ctx, index) => Dismissible(
          // key: UniqueKey(),
          // onDismissed: (direction) async {

          // ),
          // );
        }
      },
    );
  }
}
