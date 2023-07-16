import 'package:flutter/material.dart';
import 'package:frivia/StartGamePage.dart';
import 'GamePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Frivia",
      theme: ThemeData(
          fontFamily: "ArchitectsDaughter",
          scaffoldBackgroundColor: const Color.fromRGBO(31, 31, 31, 1.0),
          primarySwatch: Colors.blueGrey),
      home: StartGamePage(),
    );
  }
}
