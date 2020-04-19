import 'package:daily_buddy_app/widgets/confirmation_button.dart';
import 'package:daily_buddy_app/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:daily_buddy_app/blocs/blocs.dart';
import 'package:daily_buddy_app/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:jiffy/jiffy.dart';

import 'screens.dart';

class WelcomePage extends StatefulWidget {
  static const Route = "Welcome";

  _WelcomePageStage createState() => _WelcomePageStage();
}

class _WelcomePageStage extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: welcomeBoddy(context));
  }

  Widget welcomeBoddy(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, userState) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Text(
              "Willkommen bei Daily Buddy",
              style: TextStyle(
                  fontSize: 23.0,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto"),
            ),
            Center(
              child: Image.asset(
                'assets/images/logo_no_border.png',
                fit: BoxFit.fill,
                width: 150.0,
                height: 150.0,
              ),
            ),
            TextInputField(
                hint: 'Name',
                icon: Icon(
                  Icons.person,
                )),
            ConfirmationButton(
              lable: 'Registrieren',
              onPressed: () {},
              //color: Theme.of(context).primaryColorDark,
            ),
            SizedBox(
              height: 1,
            ),
          ]);
    });
  }
}
