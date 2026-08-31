import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formator =  DateFormat.yMd();

final uuid = const Uuid();

enum Category {
  food , travel , work , leisure
}

const categoryIcons = {
  Category.food : Icons.lunch_dining,
  Category.travel : Icons.flight_takeoff,
  Category.leisure : Icons.movie,
  Category.work : Icons.work
};

class ExpenseModel{
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  ExpenseModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category
  }) : id = uuid.v4();

  String get formattedDate{
    return formator.format(date);
  }
}

class ExpenseBucket{
  final Category category;
  final List<ExpenseModel> expenses;

  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(
      List<ExpenseModel> allExpenses,
      this.category
      ) :
      expenses =
      allExpenses
      .where((expense) =>expense.category==category)
      .toList();

  double get totalExpenses{
    double sum = 0;

    for(final expense in expenses){
      sum = sum + expense.amount;
    }
    return sum;
  }
}