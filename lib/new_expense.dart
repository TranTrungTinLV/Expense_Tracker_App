import 'package:expense_tracker/expense.dart';
import 'package:expense_tracker/homepage.dart';
import 'package:expense_tracker/data/sqlfite/sqflife_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _formatterAmount = NumberFormat.decimalPattern();

  DateTime? _selectedDate;
  Category _selectedCategory = Category.Food;
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.day, now.month, now.year - 1);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: DateTime(2030));
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text.replaceAll(
        ',', '')); // tryParse("Hello") => null; tryParse("1.12") => 1.12
    print("giá trị: ${enteredAmount}");

    final ammountInvalid = enteredAmount == null || enteredAmount <= 1000;
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
                        Navigator.pop(context, HomePage.id);
                      },
                      child: Text("OK"))
                ],
              ));
      SQLHelper.insertExpense(Expense(_descriptionController.text,
          title: _titleController.text,
          date: _selectedDate!,
          amount: enteredAmount,
          source: "Levi",
          category: _selectedCategory));
    }
    widget.onAddExpense(Expense(_descriptionController.text,
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
          decoration: InputDecoration(label: Text('title')),
        ),
        TextField(
          controller: _descriptionController,
          maxLength: 50,
          decoration: InputDecoration(label: Text('description')),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      String cleanValue = value.replaceAll(',', '');

                      final parsedValue = double.tryParse(cleanValue) ?? 0;
                      final formattedValue =
                          _formatterAmount.format(parsedValue);
                      _amountController.value = TextEditingValue(
                        text: formattedValue,
                        selection: TextSelection.collapsed(
                          offset: formattedValue.length,
                        ),
                      );
                      print("giá trị formatted ${_formatterAmount}");
                    }
                  },
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
