import 'package:demo_project_mohit/project_three/model/expense_model.dart';
import 'package:demo_project_mohit/project_three/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final List<ExpenseModel> expense;
  final void Function(ExpenseModel value) removeExpense;
  const ExpenseList({super.key,required this.expense,required this.removeExpense});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expense.length,
        itemBuilder: (ctx , i){
          return Dismissible(
            key: ValueKey(expense[i]),
            background: Container(
              color: Colors.red,
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 30,
              ),
            ),

            onDismissed: (direction) {
              removeExpense(expense[i]);
            },

            child: ExpenseItem(
              expense: expense[i],
            ),
          );
        }
    );
  }
}
