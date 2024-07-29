import 'package:auto_size_text/auto_size_text.dart';
import 'package:expense_tracker/screen/TotalExpense.dart';
import 'package:expense_tracker/utils/categories_expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const Color colorText = Color(0xFF242D35);
Color _color = Colors.white;

class EmptyCard extends StatefulWidget {
  final VoidCallback? onTap;
  const EmptyCard(this.expense, {this.onTap});
  final CategoriesExpense expense;
  @override
  State<EmptyCard> createState() => _EmptyCardState();
}

class _EmptyCardState extends State<EmptyCard> {
  final formatter = NumberFormat.decimalPattern();
  // bool _isTapped = false;
  @override
  Widget build(BuildContext context) {
    print("formatter ${formatter.runtimeType}");
    return GestureDetector(
      onTap: () => {
        Navigator.pushNamed(
          context,
          Totalexpense.id,
          arguments: widget.expense,
        )
      },
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 10),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(1, -1),
                end: Alignment(-1, 1),
                stops: <double>[0, 1],
                colors: [Colors.white, Colors.white]),
            // color: widget.cardCoulor,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
        height: 160.0,
        width: 200.0,
        child: Container(
          width: 90,
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(categoryIcons[widget.expense.icon], color: Colors.black),
              Container(
                  height: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(),
                      Container(
                        height: 8,
                      ),
                      Text(
                        widget.expense.title,
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                    ],
                  )),
              AutoSizeText(
                "${formatter.format(widget.expense.amount)}",
                style: TextStyle(
                    fontSize: 24.0, letterSpacing: 0.32, color: Colors.black),
                maxLines: 1,
                minFontSize: 8,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
