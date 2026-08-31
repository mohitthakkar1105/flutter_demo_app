import 'package:demo_project_mohit/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final void Function() switchScreen;
  const SplashScreen({super.key, required this.switchScreen});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/quiz-logo.png',
            width: 250,
            color: const Color.fromARGB(133, 255, 255, 255),
          ),
          const SizedBox(height: 80),
          const CustomText(
            "Learn Flutter the fun way !",
            fontSize: 24,
            color: Colors.white,
          ),
          const SizedBox(height: 50),
          OutlinedButton.icon(
            onPressed: switchScreen,
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            icon: const Icon(
              Icons.arrow_right_alt,
              color: Colors.white,
            ),
            label: const CustomText(
              "Start Quiz",
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
