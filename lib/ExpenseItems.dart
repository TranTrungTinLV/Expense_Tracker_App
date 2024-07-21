import 'package:expense_tracker/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseItems extends StatelessWidget {
  const ExpenseItems(
    this.expense, {
    super.key,
  });
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    // final formatter = NumberFormat('#,##0.000', 'vi_VN');
    final formatter = NumberFormat.decimalPattern();
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          // border: Border(bottom: BorderSide(width: 1, color: Colors.grey))
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(children: [
            Container(
                width: 40,
                height: 40,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                    color: Color(0xFFEBEEF0),
                    border: Border(
                        bottom: BorderSide(width: 4, color: Colors.grey)),
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                child: Icon(
                  categoryIcons[expense.category],
                  size: 30,
                )),
            Container(
              width: 10,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                expense.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              Text(
                expense.formattedDate,
                style: TextStyle(fontSize: 12),
              ),
            ]),
          ]),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${formatter.format(expense.amount)}đ",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
                ),
                Text(
                  expense.description,
                  style: TextStyle(fontSize: 12),
                ),
              ]),
        ],
      ),
    );
  }
}
