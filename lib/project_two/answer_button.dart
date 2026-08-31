import 'package:demo_project_mohit/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String answerText;
  final void Function() onTap;
  const AnswerButton(this.answerText, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        backgroundColor: const Color.fromARGB(176, 95, 2, 90),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      ),
      child: CustomText(
        answerText,
        fontSize: 16,
        color: Colors.white,
        textAlign: TextAlign.center,
      ),
    );
  }
}
