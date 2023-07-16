import 'package:flutter/material.dart';
import 'package:frivia/providers/gameProvide.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  GamePage({Key? key, required this.difficulty}) : super(key: key);
  final String difficulty;
  GamePageProvider? _pageProvider;
  double? deviceHeight, deviceWidth;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => GamePageProvider(
        context: context,
        difficulty: difficulty,
      ),
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(builder: (context) {
      _pageProvider = context.watch<GamePageProvider>();
      if (_pageProvider!.questionsList != null) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: deviceHeight! * 0.05,
                  vertical: deviceHeight! * 0.001),
              child: _gameUI(),
            ),
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      }
    });
  }

  Widget _gameUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _quetionUI(),
        Column(
          children: [
            _trueButton(),
            SizedBox(
              height: deviceHeight! * 0.02,
            ),
            _falseButton(),
          ],
        ),
      ],
    );
  }

  Widget _quetionUI() {
    return Text(_pageProvider!.getCurrentQuestionText(),
        style: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400));
  }

  Widget _trueButton() {
    return MaterialButton(
      color: Colors.green,
      minWidth: deviceWidth! * 0.80,
      height: deviceHeight! * 0.10,
      onPressed: () {
        print("_trueButton()");
        _pageProvider!.answerQuestion("True");
      },
      child: const Text(
        "True",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }

  Widget _falseButton() {
    return MaterialButton(
      color: Colors.red,
      minWidth: deviceWidth! * 0.80,
      height: deviceHeight! * 0.10,
      onPressed: () {
        print("falseButton()");
        _pageProvider!.answerQuestion("False");
      },
      child: const Text(
        "False",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }
}
