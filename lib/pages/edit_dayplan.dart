import 'dart:io';

import 'package:DailyBuddy/data/bloc/dayplan_bloc.dart';
import 'package:DailyBuddy/models/dayplan.dart';
import 'package:DailyBuddy/widgets/date_field.dart';
import 'package:DailyBuddy/widgets/input_column.dart';
import 'package:DailyBuddy/widgets/input_field.dart';
import 'package:DailyBuddy/widgets/time_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateDayplanArgs {
  final String id;
  final Dayplan dayplan;

  CreateDayplanArgs({this.id, this.dayplan});
}

class CreateDayplanScreen extends StatefulWidget {
  static const Route = "DayplanEdit";

  @override
  _CreateDayplanScreenState createState() => _CreateDayplanScreenState();
}

class _CreateDayplanScreenState extends State<CreateDayplanScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String title;
  DateTime ackDate;
  DayplanBloc dayplanBloc;

  @override
  void initState() {
    super.initState();
    ackDate = DateTime.now();
    dayplanBloc = DayplanBloc('0');
    dayplanBloc.dayplan.date = ackDate;
  }

  @override
  Widget build(BuildContext context) {
    return _dayplanBuilder(context);
/*
    return Scaffold(
      appBar: _appBar(context),
      body: SafeArea(
        child: _dayplanFormBuilder(context),
      ),
    );
    */
  }

  Widget _dayplanBuilder(BuildContext context) {
    return StreamBuilder(
      stream: dayplanBloc.dayplan$,
      builder: (BuildContext context, AsyncSnapshot<Dayplan> snapshot) {
        return _dayplanPage(context, snapshot);
      },
    );
  }

  Widget _dayplanPage(BuildContext context, AsyncSnapshot<Dayplan> snapshot) {
    return Scaffold(
      appBar: _appBar(context, snapshot),
      body: SafeArea(
        child: _dayplanForm(context, snapshot),
      ),
    );
  }

  AppBar _appBar(BuildContext context, AsyncSnapshot<Dayplan> snapshot) {
    return AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Center(child: Text("Neue Aktivität")),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                dayplanBloc.saveDayplan(snapshot.data);
                Navigator.pop(context, snapshot.data);
              }),
        ]);
  }

  Widget _dayplanFormBuilder(BuildContext context) {
    return StreamBuilder(
      stream: dayplanBloc.dayplan$,
      builder: (BuildContext context, AsyncSnapshot<Dayplan> snapshot) {
        return _dayplanForm(context, snapshot);
      },
    );
  }

  Widget _dayplanForm(BuildContext context, AsyncSnapshot<Dayplan> snapshot) {
    return Form(
        autovalidate: false,
        key: _formKey,
        child: Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
          Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .38,
                child: Input(
                  child: DateField(
                      key: ValueKey(snapshot.data.date.millisecondsSinceEpoch),
                      date: snapshot.data.date,
                      onChange: (day) {
                        final newStart = DateTime(
                            day.year,
                            day.month,
                            day.day,
                            snapshot.data.date?.hour ?? 0,
                            snapshot.data.date?.minute ?? 0);

                        snapshot.data.date = newStart;
                        dayplanBloc.setDate(newStart);
                      }),
                  name: "Start",
                ),
              ),
              Expanded(child: Container()),
              Icon(Icons.calendar_today),
              Expanded(child: Container()),
              Container(
                width: MediaQuery.of(context).size.width * .38,
                child: Input(
                  child: TimeField(
                      key: ValueKey(snapshot.data.date),
                      date: snapshot.data.date,
                      onChange: (time) {
                        final newStart = DateTime(
                            snapshot.data.date?.year ?? DateTime.now().year,
                            snapshot.data.date?.month ?? DateTime.now().month,
                            snapshot.data.date?.day ?? DateTime.now().day,
                            time.hour,
                            time.minute);
                        snapshot.data.date = newStart;
                        // dayplanBloc.setDate(newStart);
                        dayplanBloc.updatDayplan(snapshot.data);
                      }),
                  name: "",
                ),
              ),
            ],
          ),
/*
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text("Datum"),
            Text(DateFormat.yMMMMEEEEd("de_DE").format(snapshot.data.date)),
            _buildDateButton(context, snapshot)
          ]),
          */
          InputColumn(
            name: "Aktivität",
            child: TextFormField(
              initialValue: snapshot.data.activity,
              onChanged: (val) {
                setState(() {
                  snapshot.data.activity = val;
                  dayplanBloc.updatDayplan(snapshot.data);
                });
              },
              decoration: InputDecoration(
                hintText: "Aktivität",
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ])));
  }

  IconButton _buildDateButton(
      BuildContext context, AsyncSnapshot<Dayplan> snapshot) {
    return IconButton(
      icon: Icon(Icons.calendar_today),
      onPressed: () async {
        snapshot.data.date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2010),
          lastDate: DateTime(2050),
        );
        dayplanBloc.updatDayplan(snapshot.data);
      },
    );
  }
}
