import 'package:flutter/material.dart';

import 'screens.dart';

class QuestionsPage extends StatefulWidget {
  static const Route = "Questions";

  _QuestionsPageStage createState() => _QuestionsPageStage();
}

class _QuestionsPageStage extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: questBoddy(context));
  }
}

Widget questBoddy(BuildContext context) {}
