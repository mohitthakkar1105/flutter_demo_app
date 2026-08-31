import 'package:demo_project_mohit/custom_widget/custom_appbar.dart';
import 'package:demo_project_mohit/custom_widget/custom_text.dart';
import 'package:demo_project_mohit/project_three/widgets/expenses_list/expense_list.dart';
import 'package:demo_project_mohit/project_three/model/expense_model.dart';
import 'package:demo_project_mohit/project_three/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import 'chart/chart.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final List<ExpenseModel> _registeredExpense = [
    ExpenseModel(title: "flutter courese",
        amount: 100,
        date: DateTime.now(),
        category: Category.work
    ),
    ExpenseModel(title: "Cinema",
        amount: 200,
        date: DateTime.now(),
        category: Category.leisure
    ),
  ];
  void _openAddExpenseOverlay(){
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled:true ,
      context: context,
      builder: (ctx)=> NewExpense(expense: addExpenses,)
    );
  }
  void addExpenses(ExpenseModel value){
    setState(() {
      _registeredExpense.add(value);
    });
  }
  void _removeExpense(ExpenseModel expense) {
    final expenseIndex = _registeredExpense.indexOf(expense);
    setState(() {
      _registeredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense deleted"),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(30),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        persist: false,
        action: SnackBarAction(
          label: "Undo",
          onPressed: (){
            setState(() {
              _registeredExpense.insert(expenseIndex,expense);
            });
          },
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final appBarTheme = theme.appBarTheme;
    Widget mainContent = const Center(
      child: Text("No expense found. start adding some"),
    );
    if(_registeredExpense.isNotEmpty){
      mainContent = ExpenseList(
        expense: _registeredExpense,
        removeExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: CustomAppbar(
        height: 80,
        showSuffix: true,
        title: Text(
          "Flutter Expense Tracker",
          style: TextStyle(color: appBarTheme.backgroundColor),
        ),
        centerTitle: false,
        suffix: IconButton(
        onPressed: _openAddExpenseOverlay,
        icon:  Icon(Icons.add,color: appBarTheme.backgroundColor,)
        ),
      ),
      body:
      width < 600 ? Column(
        children: [
          Chart(registeredExpense: _registeredExpense,),
          Expanded(
              child: mainContent,
          )
        ],
      ) : Row(
        children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Chart(registeredExpense: _registeredExpense,
                ),
              ),
          ),
          Expanded(
            child: mainContent,
          )
        ],
      ),
    );
  }
}
