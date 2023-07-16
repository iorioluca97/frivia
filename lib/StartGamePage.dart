import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:frivia/GamePage.dart';
import 'package:frivia/providers/gameProvide.dart';
import 'package:provider/provider.dart';

class StartGamePage extends StatefulWidget {
  StartGamePage({Key? key}) : super(key: key);

  @override
  State<StartGamePage> createState() => _StartGamePageState();
}

class _StartGamePageState extends State<StartGamePage> {
  double? deviceHeight, deviceWidth;
  List<String> _difficulty = ["Easy", "Medium", "Hard"];
  double _currenSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return
        //ChangeNotifierProvider(
        //  create: (context) => GamePageProvider(
        //    context: context,
        //    difficulty: _difficulty,
        //  ),child:
        _startUI();
  }

  Widget _startUI() {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: deviceWidth! * 0.10, vertical: deviceHeight! * 0.10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              appTitle(),
              setDifficulty(),
              startGame(),
            ],
          ),
        ),
      )),
    );
  }

  Widget appTitle() {
    return Column(
      children: [
        const Text(
          "Frivia",
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        Text(
          _difficulty[_currenSliderValue.toInt()],
          style: TextStyle(color: setColorDifficulty(), fontSize: 20),
        ),
      ],
    );
  }

  Widget setDifficulty() {
    return Slider(
        label: "Difficulty",
        divisions: 2,
        min: 0,
        max: 2,
        value: _currenSliderValue,
        onChanged: (double value) {
          setState(() {
            _currenSliderValue = value;
            _difficulty[_currenSliderValue.toInt()];
          });
        });
  }

  Widget startGame() {
    return MaterialButton(
      color: Colors.blue,
      minWidth: deviceWidth! * 0.80,
      height: deviceHeight! * 0.10,
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return GamePage(
            difficulty: _difficulty[_currenSliderValue.toInt()],
          );
        }));
      },
      //_pageProvider!.answerQuestion("False")
      child: const Text(
        "Start",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }

  MaterialColor setColorDifficulty() {
    if (_difficulty[_currenSliderValue.toInt()] == "Easy") {
      return Colors.green;
    } else if (_difficulty[_currenSliderValue.toInt()] == "Hard") {
      return Colors.red;
    } else {
      return Colors.yellow;
    }
  }
}
