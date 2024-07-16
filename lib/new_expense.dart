import 'package:expense_tracker/expense.dart';
import 'package:expense_tracker/homepage.dart';
import 'package:expense_tracker/sqlfite/sqflife_helper.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _subTitleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.Food;
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.day, now.month, now.year - 1);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController
        .text); // tryParse("Hello") => null; tryParse("1.12") => 1.12
    final ammountInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.isEmpty ||
        ammountInvalid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Invalid Input! 🥹"),
                content: const Text("Please make sure a valid!"),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                      },
                      child: Text('Cancel')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'OK');
                      },
                      child: Text('OK'))
                ],
              ));
      return;
    } else {
      Navigator.pushNamed(context, HomePage.id);
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Successfully! 😘"),
                actions: [
                  TextButton(
                      onPressed: () {
                        // Navigator.pop(HomePage.id as BuildContext, "home_page");
                        Navigator.pushNamed(context, HomePage.id);
                      },
                      child: Text("OK"))
                ],
                // content: const Text("Please make sure a valid!"),
              ));
      SQLHelper.insertExpense(Expense(_subTitleController.text,
          title: _titleController.text,
          date: _selectedDate!,
          amount: enteredAmount,
          source: "Levi",
          category: _selectedCategory));
    }
    widget.onAddExpense(Expense(_subTitleController.text,
        title: _titleController.text,
        date: _selectedDate!,
        amount: enteredAmount,
        source: "Levi",
        category: _selectedCategory));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Add Goal",
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
        ),
        TextField(
          controller: _titleController,
          maxLength: 50,
          decoration: InputDecoration(label: Text('Title')),
        ),
        TextField(
          controller: _subTitleController,
          maxLength: 50,
          decoration: InputDecoration(label: Text('Subtitle')),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  maxLength: 50,
                  decoration: InputDecoration(label: Text('vnđ')),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'Dealine'
                        : formatter.format(_selectedDate!),
                    style: TextStyle(fontSize: 16.0),
                  ),
                  IconButton(
                      onPressed: _presentDatePicker,
                      icon: Icon(Icons.date_range))
                ],
              )),
            ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map((category) => DropdownMenuItem(
                        value: category, child: Text(category.name.toString())))
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  ;
                  setState(() {
                    _selectedCategory = value;
                  });
                }),
            Row(
              children: <Widget>[
                TextButton(
                    onPressed: () {
                      // SQLHelper.insertExpense()
                      Navigator.pop(context, 'Cancel');
                    },
                    child: Text('Cancel')),
                ElevatedButton(
                    onPressed: _submitExpenseData,
                    child: const Text('Save Goal'))
              ],
            )
          ],
        )
      ],
    );
    // );
  }
}
