import 'package:flutter/material.dart';
import 'package:flutter_app/services/bmi_calculator/calculator_brain.dart';
import 'package:flutter_app/themes/ThemeModeManager.dart';
import 'dart:math';

import 'package:flutter_app/views/widgets/bmi_calculator/bmi_card.dart';
import 'package:flutter_app/views/screens/bmi_calculator/bmi_result.dart';
import 'package:flutter_app/views/widgets/bmi_calculator/card_content.dart';
import 'package:flutter_app/views/widgets/bmi_calculator/round_icon_button.dart';
import 'package:flutter_app/views/widgets/bmi_calculator/submit_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BMI extends StatefulWidget {
  late ThemeModeManager themeData;
  BMI(ThemeModeManager themeMode) {
    themeData = themeMode;
  }
  @override
  _BMIState createState() => _BMIState(themeData);
}

enum Gender { Male, Female }

class _BMIState extends State<BMI> {
  final ThemeModeManager themeData;
  _BMIState(this.themeData);
  void _changeThemeMode() {
    themeData.changeTheme();
  }

  Gender? selectedGender;
  int height = 120;
  int weight = 30;
  int age = 1;
  @override
  Widget build(BuildContext context) {
    final mode = themeData.themeMode;
    final labelStyle = TextStyle(
      fontSize: 18.0,
      color: Theme.of(context).textSelectionColor,
    );

    final numberStyle = TextStyle(
      fontSize: 50.0,
      fontWeight: FontWeight.w900,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
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
          children: [
            //?for gender selection
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: BmiCard(
                    cardChild: CardContent(
                      icon: FontAwesomeIcons.mars,
                      label: 'MALE',
                    ),
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.Male;
                        print("male selected");
                      });
                    },
                    colour: selectedGender == Gender.Male
                        ? Theme.of(context).cardColor
                        : Theme.of(context).shadowColor,
                  )),
                  Expanded(
                      child: BmiCard(
                    cardChild: CardContent(
                      icon: FontAwesomeIcons.venus,
                      label: 'FEMALE',
                    ),
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.Female;
                        print("female selected");
                      });
                    },
                    colour: selectedGender == Gender.Female
                        ? Theme.of(context).cardColor
                        : Theme.of(context).shadowColor,
                  )),
                ],
              ),
            ),
            //?for height
            Expanded(
              child: BmiCard(
                colour: Theme.of(context).shadowColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Height',
                      style: labelStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          height.toString(),
                          style: numberStyle,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'cm',
                          style: labelStyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Theme.of(context).accentColor,
                        inactiveTrackColor: Color(0xFF8D8E98),
                        thumbColor: Theme.of(context).cardColor,
                        overlayColor: Color(0x29EB1555),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                            RoundSliderThumbShape(enabledThumbRadius: 20.0),
                      ),
                      child: Slider(
                        value: height.toDouble(),
                        min: 120.0,
                        max: 220.0,
                        onChanged: (double newValue) {
                          setState(() {
                            height = newValue.round();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Row(
                children: [
                  //?for weight
                  Expanded(
                      child: BmiCard(
                    colour: Theme.of(context).shadowColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'WEIGHT',
                          style: labelStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              weight.toString(),
                              style: numberStyle,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              'kg',
                              style: labelStyle,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onPressed: () {
                                    setState(() {
                                      if (weight > 30) weight--;
                                    });
                                  }),
                              SizedBox(
                                width: 10.0,
                              ),
                              RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onPressed: () {
                                    setState(() {
                                      weight++;
                                    });
                                  })
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                  //?for age
                  Expanded(
                      child: BmiCard(
                    colour: Theme.of(context).shadowColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'AGE',
                          style: labelStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              age.toString(),
                              style: numberStyle,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              'yr',
                              style: labelStyle,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onPressed: () {
                                    setState(() {
                                      if (age > 1) age--;
                                    });
                                  }),
                              SizedBox(
                                width: 10.0,
                              ),
                              RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onPressed: () {
                                    setState(() {
                                      age++;
                                    });
                                  })
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            SubmitBtn(
              btnText: 'CALCULATE',
              onPressed: () {
                CalculatorBrain calculate = CalculatorBrain(height, weight);
                var bmiScore = calculate.calculateBmiScore();
                var bmiText = calculate.getResult();
                var bmiInterpretation = calculate.getBmiInterpretation();
                print("Score: $bmiScore \n Text: $bmiText ");
                Navigator.pushNamed(context, '/bmi_result',
                    arguments:
                        ResultArguments(bmiScore: bmiScore, bmiText: bmiText, bmiInterpretation: bmiInterpretation)
                        );
              },
            )
          ],
        ),
      ),
    );
  }
}
