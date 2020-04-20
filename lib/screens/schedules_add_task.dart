import 'package:daily_buddy_app/blocs/blocs.dart';
import 'package:daily_buddy_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:jiffy/jiffy.dart';

class SchedulesAddTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivitiesBloc, ActivitiesState>(
        builder: (context, activitiesState) {
      if (activitiesState is ActivitiesLoaded) {
        return BlocProvider(
            create: (context) => AddTaskFormBloc(
                context: context, activitiesState: activitiesState),
            child: Builder(builder: (context) {
              final formBloc = BlocProvider.of<AddTaskFormBloc>(context);
              return Scaffold(
                  appBar: AppBar(
                    title: Text('Neue Aufgabe'),
                  ),
                  body: FormBlocListener<AddTaskFormBloc, String, String>(
                    onSuccess: (context, state) {
                      Navigator.of(context).pop(state.successResponse);
                    },
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          DropdownFieldBlocBuilder<DateTime>(
                            selectFieldBloc: formBloc.selectDay,
                            decoration: InputDecoration(
                              labelText: 'Tag',
                              prefixIcon: Icon(Icons.calendar_today),
                            ),
                            itemBuilder: (context, value) =>
                                Jiffy(value).MMMMEEEEd,
                            showEmptyItem: false,
                          ),
                          TimeFieldBlocBuilder(
                            timeFieldBloc: formBloc.selectTime,
                            format: DateFormat('hh:mm a'),
                            initialTime: TimeOfDay.now(),
                            decoration: InputDecoration(
                              labelText: 'Uhrzeit',
                              prefixIcon: Icon(Icons.access_time),
                            ),
                          ),
                          DropdownFieldBlocBuilder<Duration>(
                            selectFieldBloc: formBloc.selectDuration,
                            decoration: InputDecoration(
                              labelText: 'Dauer',
                              prefixIcon: Icon(Icons.timelapse),
                            ),
                            itemBuilder: (context, value) =>
                                Jiffy(Jiffy().startOf(Units.DAY).add(value)).Hm,
                            showEmptyItem: false,
                          ),
                          DropdownFieldBlocBuilder<Category>(
                            selectFieldBloc: formBloc.selectCategory,
                            decoration: InputDecoration(
                              labelText: 'Kategorie',
                              prefixIcon: Icon(Icons.category),
                            ),
                            itemBuilder: (context, value) => value.categoryName,
                          ),
                          DropdownFieldBlocBuilder<Activity>(
                            selectFieldBloc: formBloc.selectActivity,
                            decoration: InputDecoration(
                              labelText: 'Aktivität',
                              prefixIcon: Icon(Icons.flash_on),
                            ),
                            itemBuilder: (context, value) => value.activityName,
                          ),
                          ButtonBar(
                            children: <Widget>[
                              FlatButton.icon(
                                label: Text('Speichern'),
                                icon: Icon(Icons.save),
                                onPressed: formBloc.submit,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ));
            }));
      } else {
        BlocProvider.of<ActivitiesBloc>(context).add(LoadActivitiesEvent());
        return Container();
      }
    });
  }
}
