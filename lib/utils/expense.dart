import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final uuid = Uuid();
final formatter = DateFormat('dd/MM/yy');

enum Category { Food, Advertising, Telephone, Travel, Work }

const categoryIcons = {
  Category.Food: Icons.lunch_dining,
  Category.Advertising: Icons.beach_access,
  Category.Telephone: Icons.phone,
  Category.Travel: Icons.place,
  Category.Work: Icons.work
};

class Expense {
  Expense(this.description,
      {String? id,
      required this.title,
      required this.date,
      required this.amount,
      required this.source,
      required this.category})
      : id = id ?? uuid.v4();
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final double amount;
  final String source;
  final Category category;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'amount': amount,
      'source': source,
      'category': category.toString().split('.').last
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      map['description'],
      title: map['title'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      amount: map['amount'],
      source: map['source'],
      category: Category.values
          .firstWhere((e) => e.toString() == 'Category.' + map['category']),
    );
  }

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
