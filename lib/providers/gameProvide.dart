import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _maxQuestions = 3;
  final String difficulty;
  List? questionsList;
  int _currentQuestionCount = 0;
  int _correctCount = 0;
  BuildContext context;

  GamePageProvider({required this.context, required this.difficulty}) {
    // base url to the questions
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    getQuestions();
  }
  Future<void> getQuestions() async {
    print(difficulty);
    var _response = await _dio.get(
      '',
      queryParameters: {
        'amount': _maxQuestions,
        'type': 'boolean',
        'difficulty': difficulty.toLowerCase(),
      },
    );
    var _data = jsonDecode(_response.toString());

    questionsList = _data['results'];
    notifyListeners();
  }

  String getCurrentQuestionText() {
    return questionsList![_currentQuestionCount]['question'];
  }

  void answerQuestion(String _userAnswer) async {
    bool isCorrect =
        questionsList![_currentQuestionCount]["correct_answer"] == _userAnswer;
    isCorrect ? _correctCount++ : _correctCount + 0;
    _currentQuestionCount++;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              backgroundColor: isCorrect ? Colors.green : Colors.red,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(isCorrect ? Icons.check_circle : Icons.cancel_sharp,
                      color: Colors.white),
                  Text(
                    isCorrect ? "Correct!" : "Wrong!",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ));
        });
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
    if (_currentQuestionCount == _maxQuestions) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Center(
            child: Text(
              "End Game!",
              style: TextStyle(color: Colors.white),
            ),
          ),
          content: Text("You scored $_correctCount/${questionsList!.length}"),
        );
      },
    );
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pop(context);
    Navigator.pop(context);
    _currentQuestionCount = 0;
  }
}
