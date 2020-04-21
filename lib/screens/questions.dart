import 'package:flutter/material.dart';
import 'package:daily_buddy_app/blocs/blocs.dart';
import 'package:daily_buddy_app/models/models.dart';
import 'screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class QuestionsPage extends StatefulWidget {
  static const Route = "Questions";

  _QuestionsPageStage createState() => _QuestionsPageStage();
}

class _QuestionsPageStage extends State<QuestionsPage> {
  bool isRelevant = false;
  UiQuestion question = UiQuestion(
    '1',
    relevantText: 'Früstückst Du',
    questionText: 'wann möchstest Du früstücken',
    isRelevant: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: questBoddy(context));
  }

  Widget questBuilder() {
    return BlocBuilder<QuestionBloc, QuestionState>(
        builder: (context, userState) {
      return questBoddy(context);
    });
  }

  Widget questBoddy(BuildContext context) {
    return Center(
        child: Card(
            elevation: 5,
            // margin: EdgeInsetsGeometry.infinity,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  !question.isRelevant
                      ? SwitchListTile(
                          onChanged: (value) {
                            setState(() {
                              question.isRelevant = value;
                            });
                          },
                          value: question.isRelevant,
                          title: Text(
                            question.relevantText,
                            style: TextStyle(
                                fontSize: 23.0,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Roboto"),
                          ),
                          //subtitle: Text('... '),
                          inactiveTrackColor: Theme.of(context).primaryColor,
                          inactiveThumbColor:
                              Theme.of(context).primaryColorLight,
                          activeTrackColor: Theme.of(context).primaryColor,
                          activeColor: Theme.of(context).primaryColorDark)
                      : ListTile(
                          title: Text(question.questionText,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Roboto")),
                          //subtitle: Text('... '),
                          //dense: true,
                          trailing: Text('08:00'),
                        ),
                  SizedBox(
                    height: 15,
                  ),
                ])));
  }
}
