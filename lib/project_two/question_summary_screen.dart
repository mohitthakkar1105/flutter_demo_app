import 'package:demo_project_mohit/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';

class QuestionSummaryScreen extends StatelessWidget {
  final List<Map<String, Object>> summaryData;
  const QuestionSummaryScreen(this.summaryData, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 303,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  ((data['question_index'] as int) + 1).toString(),
                  fontSize: 16,
                  color: Colors.white,
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        data['question'].toString(),
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      CustomText(
                        data['correct_answer'].toString(),
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      CustomText(
                        data['selected_answer'].toString(),
                        fontSize: 12,
                        color:
                            data['correct_answer'].toString() ==
                                data['selected_answer'].toString()
                            ? Colors.green
                            : Colors.red,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
