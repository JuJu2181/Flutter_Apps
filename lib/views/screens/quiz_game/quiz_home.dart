import 'package:flutter/material.dart';
import 'package:flutter_app/services/quiz_game/quiz_brain.dart';
import 'package:flutter_app/themes/ThemeModeManager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuizHome extends StatefulWidget {
  final ThemeModeManager themeData;

  QuizHome(this.themeData);

  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  void _changeThemeMode() {
    widget.themeData.changeTheme();
  }

  List<String> categories = [
    'General',
    'Sports',
    'Computers',
    'Animals',
    'History'
  ];

  var questionMap = {
    'General': 9,
    'Sports': 21,
    'Computers': 18,
    'Animals': 27,
    'History': 23
  };

  String category_value = 'Options';
  int? url_value;
  int? no_of_questions = 5;
  var result = [];

  Future fetchData(apiUrl) async {
    //var url = Uri.parse(apiurl)
    var response = await http.get(Uri.parse(apiUrl));
    //print(response.body);
    if (json.decode(response.body)["response_code"] == 0) {
      result = json.decode(response.body)["results"];
      print(result);
    } else {
      print("Invalid Response");
    }
  }

  var apiUrl = "https://opentdb.com/api.php?amount=5&type=boolean";

  @override
  Widget build(BuildContext context) {
    final ThemeMode mode = widget.themeData.themeMode;

    void updateUrl(int? url_value) {
      if (url_value != null) {
        apiUrl =
            // "https://opentdb.com/api.php?amount=10&category=$url_value&type=boolean";
            "https://opentdb.com/api.php?amount=$no_of_questions&category=$url_value&type=boolean";
      }
    }

    // var apiUrl = (url_value != null)
    //     ? "https://opentdb.com/api.php?amount=10&category=$url_value&type=boolean"
    //     : "https://opentdb.com/api.php?amount=10&type=boolean";

    fetchData(apiUrl);

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Home'),
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
        padding: EdgeInsets.all(10.0),
        color: Theme.of(context).backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(15.0),
              child: Center(
                child: Text(
                  'QUIZ GAME',
                  style: TextStyle(
                    color: Theme.of(context).textSelectionColor,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap: () {
                        print('Quiz started');
                        print('category: $category_value');
                        print('url: $url_value');
                        print(apiUrl);
                        //fetchData(apiUrl);
                        print(result);
                        Navigator.of(context).pushNamed(
                          '/quiz_game',
                          arguments: QuizBrain(result),
                        );
                      },
                      child: Container(
                          width: 200.0,
                          height: 70.0,
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.green[400],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              'START QUIZ',
                              style: TextStyle(
                                  color: Theme.of(context).textSelectionColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.0),
                            ),
                          ))),
                  InkWell(
                      onTap: () {
                        print('Options');
                        //fetchData(apiUrl);
                      },
                      child: Container(
                          width: 200.0,
                          height: 70.0,
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.blue[400],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: DropdownButton(
                              hint: Text(category_value,
                              style: TextStyle(
                                color: Theme.of(context).textSelectionColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0
                              ),
                              ),
                              items: categories
                                  .map((String val) => DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  category_value = value.toString();
                                  print('Value: $category_value');
                                  for (String key in questionMap.keys) {
                                    if (key == category_value) {
                                      print(key);
                                      url_value = questionMap[key];
                                      print(url_value);
                                    }
                                  }
                                  print("url_value: $url_value");
                                  print("no of questions: $no_of_questions");
                                  updateUrl(url_value);
                                  print(apiUrl);
                                  fetchData(apiUrl);
                                });
                              },
                            ),
                          ))),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No Of Questions: ' + no_of_questions.toString(),
                        style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
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
                          value: no_of_questions!.toDouble(),
                          min: 5.0,
                          max: 15.0,
                          onChanged: (double newValue) {
                            setState(() {
                              no_of_questions = newValue.round();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
