import 'package:demo_project_mohit/custom_widget/custom_text.dart';
import 'package:demo_project_mohit/project_two/data/question.dart';
import 'package:demo_project_mohit/project_two/question_summary_screen.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final List<String> selectedAnswers;
  final void Function()? onPressed;

  const ResultScreen({
    super.key,
    required this.selectedAnswers,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    int calulateScore() {
      int score = 0;
      for (int i = 0; i < selectedAnswers.length; i++) {
        if (selectedAnswers[i] == questions[i].answers[0]) {
          score++;
        }
      }
      return score;
    }

    final List<Map<String, Object>> summaryData = [];
    List<Map<String, Object>> getSummaryData() {
      for (int i = 0; i < selectedAnswers.length; i++) {
        summaryData.add({
          'question_index': i,
          'question': questions[i].question,
          'correct_answer': questions[i].answers[0],
          'selected_answer': selectedAnswers[i],
        });
      }
      return summaryData;
    }

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              "You have answered ${calulateScore()} out of ${questions.length} questions correctly!",
              fontSize: 15,
              color: Colors.white,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 25,
            ),
            QuestionSummaryScreen(getSummaryData()),
            const SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: onPressed,
              child: const CustomText(
                "Restart Quiz",
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
