import 'package:demo_project_mohit/project_five/screens/categories_screen.dart';
import 'package:demo_project_mohit/project_five/screens/meals_screen.dart';
import 'package:demo_project_mohit/project_five/screens/tabs.dart';
import 'package:demo_project_mohit/project_four/key.dart';
import 'package:demo_project_mohit/project_three/widgets/expense.dart';
import 'package:demo_project_mohit/provider/login_provider.dart';
import 'package:demo_project_mohit/screen/login_api_test.dart';
import 'package:demo_project_mohit/services/notification/notification_service.dart';
import 'package:demo_project_mohit/utils/custom_sizer.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'package:demo_project_mohit/project_two/quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'App_Button/Button.dart';
import 'App_TextField/textField.dart';
import 'Custom_carousel_slider/simple_carousel.dart';
import 'package:provider/provider.dart';

import 'email_auth_screen/email_auth_screen.dart';
import 'firebase_options.dart';

// project two

// void main() {
//   runApp(const Quiz());
// }

// project three

// var kColorScheme = ColorScheme.fromSeed(
//   seedColor:const  Color.fromARGB(255, 96, 59, 181),
// );

// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//     DeviceOrientation.landscapeRight,
//     DeviceOrientation.landscapeLeft,
//   ]);
//   runApp(
//     MaterialApp(
//       theme: ThemeData(
//       ).copyWith(
//           useMaterial3: true,
//         colorScheme: kColorScheme,
//         appBarTheme: const AppBarTheme().copyWith(
//           backgroundColor: kColorScheme.primaryContainer,
//           foregroundColor: kColorScheme.onPrimaryContainer,
//         ),
//         iconTheme: const IconThemeData().copyWith(
//          color: kColorScheme.onPrimaryContainer
//         )
//       ),
//       home: const Expense(),
//       debugShowCheckedModeBanner: false,
//     ),
//   );
// }

// project four

// void main() {
//   runApp(const App());
// }
//
// class App extends StatelessWidget {
//   const App({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(useMaterial3: true),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Flutter Internals'),
//         ),
//         body: const Keys(),
//       ),
//     );
//   }
// }

//project five

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      // home: LoginApiTest(),
      home: EmailAuthScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
