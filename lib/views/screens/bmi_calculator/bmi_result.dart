import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_app/themes/ThemeModeManager.dart';
import 'package:flutter_app/views/widgets/bmi_calculator/bmi_card.dart';
import 'package:flutter_app/views/widgets/bmi_calculator/submit_button.dart';

class ResultArguments {
  final String bmiScore;
  final String bmiText;
  final String bmiInterpretation;
  ResultArguments(
      {required this.bmiScore,
      required this.bmiText,
      required this.bmiInterpretation});
}

class BmiResult extends StatelessWidget {
  late ThemeModeManager themeData;
  BmiResult(ThemeModeManager theme) {
    themeData = theme;
  }

  void _changeThemeMode() {
    themeData.changeTheme();
  }

  @override
  Widget build(BuildContext context) {
    final mode = themeData.themeMode;
    final ResultArguments result =
        ModalRoute.of(context)!.settings.arguments as ResultArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR RESULT'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: _changeThemeMode,
              icon: (mode == ThemeMode.dark)
                  ? Icon(Icons.lightbulb)
                  : Icon(Icons.lightbulb_outline_rounded)),
        ],
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Your Result',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textSelectionColor,
                ),
              ),
            )),
            Expanded(
              flex: 5,
              child: BmiCard(
                colour: Theme.of(context).primaryColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Center(
                      child: Text(
                        result.bmiText,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber[50],
                        ),
                      ),
                    )),
                    Expanded(
                        child: Text(
                      result.bmiScore,
                      style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textSelectionColor),
                    )),
                    Expanded(
                      child: Text(
                        result.bmiInterpretation,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Theme.of(context).textSelectionColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SubmitBtn(
              btnText: 'RE - CALCULATE',
              onPressed: () {
                print("bmi score : $result.bmiScore");
                //Navigator.pushNamed(context, '/bmi_calculator');
                Navigator.pushNamedAndRemoveUntil(context, '/bmi_calculator', ModalRoute.withName('/'));
              },
            )
          ],
        ),
      ),
    );
  }
}
