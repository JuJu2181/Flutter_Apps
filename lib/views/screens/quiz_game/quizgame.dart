import 'package:flutter/material.dart';
import 'package:flutter_app/themes/ThemeModeManager.dart';
import 'package:flutter_app/services/quiz_game/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
// class QuizClass {
//   final category;
//   QuizClass(this.category);
// }

class QuizGame extends StatefulWidget {
  final ThemeModeManager themeData;

  QuizGame(this.themeData);

  @override
  _QuizGameState createState() => _QuizGameState();
}

class _QuizGameState extends State<QuizGame> {
  void _changeThemeMode() {
    widget.themeData.changeTheme();
  }

  List<Icon> scoreResult = [];
  int score = 0;

  void checkAnswer(bool userPickedAnswer, QuizBrain option) {
    bool correctAnswer = option.getCorrectAnswer();
    setState(() {
      if (option.isFinished()) {
        Alert(
          context: context,
          title: 'Quiz Score: $score',
          desc: 'You\'ve Completed The Quiz',
          buttons: [
            DialogButton(
              color: Theme.of(context).shadowColor,
                child: Text(
                  'Restart Game',
                ),
                onPressed: () {
                  option.reset();
                  scoreResult.clear();
                  score = 0;
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/quiz_home', ModalRoute.withName('/'));
                }),
          ],
        ).show();
      } else {
        if (userPickedAnswer == correctAnswer) {
          scoreResult.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
          score += 20;
        } else {
          scoreResult.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
          score -= 5;
        }
        option.getNextQuestion();
      }
    });
  }

  String filterQuestion(String oldQ) {
    String newStr = oldQ.replaceAll('&quot;', '"');
    newStr = newStr.replaceAll("&#039;", "'");
    return newStr;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeMode mode = widget.themeData.themeMode;
    final QuizBrain option =
        ModalRoute.of(context)!.settings.arguments as QuizBrain;
    //print(option.apiQuestions);
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Game'),
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).shadowColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'Q. ' +
                          (option.questionNumber + 1).toString() +
                          ' Of ' +
                          (option.apiQuestions.length).toString(),
                      style: TextStyle(
                        color: Theme.of(context).textSelectionColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).shadowColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'Score: $score',
                      style: TextStyle(
                        color: Theme.of(context).textSelectionColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Center(
                child: Text(
                  filterQuestion(option.getQuestion()),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).textSelectionColor,
                    fontSize: 20.0,
                  ),
                ),
              ),
            )),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      print('yes pressed');
                      //print(option.getQuestion(1));
                      checkAnswer(true, option);
                    },
                    child: Container(
                      width: 80.0,
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Icon(Icons.check),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('No pressed');
                      //print(option.getCorrectAnswer(1));
                      checkAnswer(false, option);
                    },
                    child: Container(
                      width: 80.0,
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Icon(Icons.close),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: scoreResult,
            ),
          ],
        ),
      ),
    );
  }
}
