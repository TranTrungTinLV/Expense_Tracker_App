// import 'package:expense_tracker/utils/expense.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final uuid = Uuid();
final formatter = DateFormat('dd/MM/yy');

enum TotalExpenseIcons { Wallet, House, Car }

const categoryIcons = {
  TotalExpenseIcons.Wallet: Icons.wallet,
  TotalExpenseIcons.House: Icons.house,
  TotalExpenseIcons.Car: Icons.car_crash,
};

class CategoriesExpense {
  CategoriesExpense(
      {String? id,
      required this.title,
      required this.amount,
      required this.icon})
      : id = id ?? uuid.v4();
  final String id;
  final String title;
  final double amount;
  final TotalExpenseIcons icon;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'icon': icon.toString().split('.').last
    };
  }

  factory CategoriesExpense.fromMap(Map<String, dynamic> map) {
    final iconName = map['icon'];
    final icon = TotalExpenseIcons.values.firstWhere(
      (e) => e.toString().split('.').last == iconName,
      orElse: () =>
          TotalExpenseIcons.Wallet, // Giá trị mặc định nếu không tìm thấy
    );
    return CategoriesExpense(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      icon: icon,
    );
  }
}

class totalExpenseBucket {
  const totalExpenseBucket({
    required this.icon,
    required this.totalExpense,
  });

  totalExpenseBucket.forCategory(List<CategoriesExpense> allExpenses, this.icon)
      : totalExpense =
            allExpenses.where((expense) => expense.icon == icon).toList();

  final TotalExpenseIcons icon;
  final List<CategoriesExpense> totalExpense;

  // double remainingAmount(List<ExpenseBucket> expenses) {
  //   double totalValue =
  //       expenses.fold(0, (sum, bucket) => sum + bucket.totalExpenses);
  //   return totalExpense.fold(0.0, (sum, expense) => sum + expense.amount) -
  //       totalValue;
  // }
  //   // return sum - expenses;
  // }
}
