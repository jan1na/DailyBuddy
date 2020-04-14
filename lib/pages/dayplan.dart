import 'dart:core';
import 'package:DailyBuddy/models/dayplans.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:DailyBuddy/data/bloc/dayplan_bloc.dart';
import 'package:DailyBuddy/data/bloc/dayplans_bloc.dart';
import 'package:DailyBuddy/models/dayplan.dart';
import 'package:DailyBuddy/widgets/loading.dart';
import 'package:flutter/material.dart';

class DayPlanScreen extends StatefulWidget {
  static const Route = "dayplan";

  @override
  State<StatefulWidget> createState() {
    return _DayPlanScreenState();
  }
}

class _DayPlanScreenState extends State<DayPlanScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final DayplansBloc dayplansBlocs = DayplansBloc();
  String title;

  @override
  void initState() {
    super.initState();
    // initializeDateFormatting();
    initializeDateFormatting("de_DE", null).then((_) => {});
  }

  @override
  Widget build(BuildContext context) {
    var nowDay = DateFormat.yMMMMEEEEd("de_DE").format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(nowDay)),
      ),
      body: SafeArea(
        child: _dayplanList(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Neue Aktivität',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _dayplanList(BuildContext context) {
    return StreamBuilder(
      stream: dayplansBlocs.dayplans,
      builder: (BuildContext context, AsyncSnapshot<Dayplans> snapshot) {
        return _dayplanListWidget(snapshot);
      },
    );
  }

  Widget _dayplanListWidget(AsyncSnapshot<Dayplans> snapshot) {
    if (snapshot.hasData) {
      return snapshot.data.length != 0
          ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, itemPosition) {
                Dayplan dayplan = snapshot.data.list[itemPosition];
                return _dayPlanItem(dayplan);
              },
            )
          : Container(
              child: Center(
                  //this is used whenever there 0 Todo
                  //in the data base
                  child: Text("Keine Daten vorhanden")));
    } else {
      return Center(
        child: Loading(),
      );
    }
  }

  Widget _dayPlanItem(Dayplan dayplan) {
    return GestureDetector(
        child: Container(
            height: 40,
            child: Row(children: [
              Text(dayplan.date.hour.toString() +
                  ':' +
                  dayplan.date.minute.toString()),
              Text(dayplan.activity)
            ])));
  }
}
