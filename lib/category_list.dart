import 'package:expense_tracker/EmptyCart.dart';
import 'package:expense_tracker/utils/categories_expense.dart';
import 'package:expense_tracker/data/sqlfite/sqflife_helper.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class CategoryList extends StatefulWidget {
  CategoryList({
    super.key,
    required this.expense,
    required this.onTap,
  });
  final List<CategoriesExpense> expense;
  final VoidCallback? onTap;
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
                  DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(20),
                    child: GestureDetector(
                      onTap: widget.onTap,
                      child: Container(
                        width: 300,
                        height: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffFAFAFB)),
                        child:
                            // onPressed: (),
                            Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 35,
                        ),
                        // ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 10),
            child: Row(children: [
              GestureDetector(
                  onTap: widget.onTap,
                  child: DottedBorder(
                    // padding: EdgeInsets.only(left: 10.0),
                    borderType: BorderType.RRect,
                    radius: Radius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      width: 100,
                      height: 160,
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                  )),
              SizedBox(
                width: 20,
              ),
              ...snapshot.data!.map((expense) => EmptyCard(expense)).toList(),
            ]),
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
