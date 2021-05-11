import 'dart:math';

class CalculatorBrain {
  late int height;
  late int weight;
  double _bmiScore = 0;
  CalculatorBrain(int h, int w) {
    height = h;
    weight = w;
  }

  //? To calculate the bmi score
  String calculateBmiScore() {
    _bmiScore = (weight / pow(height / 100, 2));
    print("Bmi score: $_bmiScore");
    return _bmiScore.toStringAsFixed(1);
  }

  //? To get the result of calculation
  String getResult() {
    String result;
    if (_bmiScore >= 25) {
      result = 'Overweight';
    } else if (_bmiScore > 18.5) {
      result = 'Normal';
    } else {
      result = 'Underweight';
    }
    print("Bmi score: $result");
    return result;
  }

  //? to get interpretation of result
  String getBmiInterpretation() {
    String interpretation;
    if (_bmiScore >= 25) {
      interpretation =
          'You have higher than normal body weight.\nTry Exercising More';
    } else if (_bmiScore > 18.5) {
      interpretation = 'You have a normal body weight.\nGood Job! Keep It Up';
    } else {
      interpretation =
          'You have lower than a normal body weight.\nYou can eat bit more.';
    }
    return interpretation;
  }
}
