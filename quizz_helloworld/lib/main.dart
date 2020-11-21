import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(appBar: AppBar(title: Text("AppBar")), body: Home()));
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //This is the state of Home. Persited

  var questions = [
    {
      'questionText': {'text': '2 + 2 = ?', 'answer': '4', 'score': 5},
      'answerText': ['1', '4', '3']
    },
    {
      'questionText': {'text': '2 * 2 = ?', 'answer': '4', 'score': 10},
      'answerText': ['1', '4', '3']
    },
    {
      'questionText': {
        'text': '2 + 2 * 9 - 1 = ?',
        'answer': '19',
        'score': 25
      },
      'answerText': ['19', '15', '27']
    },
  ];

  var questionIdx = 0;
  var _totalScore = 0;

  void _answerQuestion(questionObject, answer) {
    setState(() {
      if (questionObject['answer'] == answer) {
        this._totalScore += questionObject['score'];
        print(this._totalScore);
      }
      this.questionIdx = (this.questionIdx + 1) % this.questions.length;
      if (this.questionIdx == 0) {
        print("Reset");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var widgetOutput;

    if (this.questionIdx >= this.questions.length) {
      widgetOutput = Text('There is no mode question!');
    } else {
      final questionObject = this.questions[this.questionIdx]['questionText']
      as Map<String, Object>;
      final questionText = questionObject['text'];
      final answers = this.questions[this.questionIdx]['answerText'] as List;
      // var answers = (this.questions[this.questionIdx]['answerText'] as List).map((x) => AnswerBlock(title: x)).toList();
      widgetOutput = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Question score value:"),
                ScoreBlock(score: questionObject['score']),
              ],
            ),
            QuestionBlock(questionText: questionText),
            ...answers.map((x) {
              return RaisedButton(
                child: Text(x),
                onPressed: () => this._answerQuestion(questionObject, x),
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Current Score"),
                CurrentScoreBlock(score: this._totalScore),
              ],
            ),
          ],
        ),
      );
    }
    return widgetOutput;
  }
}

class QuestionBlock extends StatelessWidget {
  // QuestionBlock({this.questionText});
  String questionText;
  QuestionBlock({this.questionText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        this.questionText,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35, color: Colors.red),
      ),
    );
  }
}

class ScoreBlock extends StatelessWidget {
  int score = 0;
  ScoreBlock({this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        this.score.toString(),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
      ),
    );
  }
}

class CurrentScoreBlock extends StatelessWidget {
  int score = 0;
  CurrentScoreBlock({this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        this.score.toString(),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }
}
