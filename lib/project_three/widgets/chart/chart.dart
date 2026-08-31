import 'package:flutter/material.dart';

import '../../model/expense_model.dart';
import 'chart_bar.dart';

class Chart extends StatefulWidget {
  final List<ExpenseModel> registeredExpense;

  const Chart({super.key,required this.registeredExpense});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {


  List<ExpenseBucket> get buckets{
    return [
      ExpenseBucket.forCategory(widget.registeredExpense, Category.work),
      ExpenseBucket.forCategory(widget.registeredExpense, Category.leisure),
      ExpenseBucket.forCategory(widget.registeredExpense, Category.travel),
      ExpenseBucket.forCategory(widget.registeredExpense, Category.food),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for(final bucket in buckets)
                  ChartBar(
                    fill: bucket.totalExpenses == 0
                        ? 0
                        : bucket.totalExpenses / maxTotalExpense,
                  )
                ],
              )
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    categoryIcons[bucket.category],
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.7),
                  ),
                ),
              ),
            )
                .toList(),
          )
        ],
      ),
    );
  }
}
