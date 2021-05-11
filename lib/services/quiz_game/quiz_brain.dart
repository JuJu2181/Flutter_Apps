class QuizBrain {
  List apiQuestions;

  QuizBrain(this.apiQuestions);

  int questionNumber = 0;

  void getNextQuestion() {
    if (questionNumber < apiQuestions.length - 1) {
      questionNumber++;
    }
  }

  String getQuestion() {
    //return _questionBank[questionNumber].question;
    return apiQuestions[questionNumber]['question'];
  }

  bool getCorrectAnswer() {
    // return _questionBank[questionNumber].answer;
    String answer = apiQuestions[questionNumber]['correct_answer'];
    bool boolAns = (answer == "True") ? true : false;
    return boolAns;
  }

  bool isFinished() {
    if (questionNumber >= apiQuestions.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    questionNumber = 0;
  }
}
