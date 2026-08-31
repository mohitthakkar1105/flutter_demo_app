import 'package:demo_project_mohit/custom_widget/custom_gradient.dart';
import 'package:demo_project_mohit/project_two/data/question.dart';
import 'package:demo_project_mohit/project_two/question_screen.dart';
import 'package:demo_project_mohit/project_two/result_screen.dart';
import 'package:demo_project_mohit/project_two/splash_screen.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  Widget? activeScreen;

  @override
  void initState() {
    super.initState();
    activeScreen = SplashScreen(switchScreen: switchScreen);
  }

  void switchScreen() {
    setState(() {
      activeScreen = QuestionScreen(
        onSelectAnswer: chooseAnswer,
      );
    });
  }

  void switchToSplashScreen() {
    setState(() {
      activeScreen = SplashScreen(switchScreen: switchScreen);
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = ResultScreen(
          selectedAnswers: selectedAnswers,
          onPressed: switchToSplashScreen,
        );
        selectedAnswers = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: const CustomGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).gradient,
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}
