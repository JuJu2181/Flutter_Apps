//* Trying dark mode simple way

import 'package:flutter/material.dart';
import 'package:flutter_app/themes/ThemeModeManager.dart';
import 'package:flutter_app/views/screens/bmi_calculator/bmi_calculator.dart';
import 'package:flutter_app/views/screens/dicegame/dicegame.dart';
import 'package:flutter_app/views/screens/home.dart';
import 'package:flutter_app/views/screens/quiz_game/quiz_home.dart';
import 'package:flutter_app/views/screens/quiz_game/quizgame.dart';
import 'package:flutter_app/views/screens/xylophone/xylophone.dart';
import 'package:flutter_app/views/screens/bmi_calculator/bmi_result.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(providers: [
        //*ChangeNotifierProvider for theme changing
        ChangeNotifierProvider(
            create: (_)=>ThemeModeManager()
        ),
      ],
        child: MainApp(),
      )
  );
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeManager>
      (builder: (context, themeData, _) {
      return MaterialApp(
        //*light theme and dark theme
        theme: themeData.lightTheme,
        darkTheme: themeData.darkTheme,
        //*ThemeMode selection
        themeMode: themeData.themeMode,
        //* Other settings
        title: 'Flutter Basic All In One App',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        //? named routes
        routes: {
          '/': (context) => HomePage(themeData),
          '/dicegame': (context) => DiceGame(themeData),
          '/xylophone':(context)=>Xylophone(themeData),
          '/bmi_calculator':(context)=>BMI(themeData),
          '/bmi_result': (context)=>BmiResult(themeData),
          '/quiz_home':(context)=>QuizHome(themeData),
          '/quiz_game':(context)=>QuizGame(themeData),
        },
      );
    });
  }
}
