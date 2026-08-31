import 'package:demo_project_mohit/custom_widget/custom_text.dart';
import 'package:demo_project_mohit/project_three/model/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final ExpenseModel expense;
  const ExpenseItem({super.key,required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 16.0),
        child: Column(
         children: [
           CustomText(expense.title, fontSize: 14, color: Colors.black,),
           const SizedBox(height: 4,),
           Row(
             children: [
              CustomText("\$${expense.amount}",
                  fontSize: 14,
                  color: Colors.black
              ),
               const Spacer(),
                Icon(categoryIcons[expense.category]),
               const SizedBox(width: 8,),
               CustomText(
                   expense.formattedDate,
                   fontSize: 14,
                   color: Colors.black
               )
             ],
           )
         ],
        ),
      ),
    );
  }
}
