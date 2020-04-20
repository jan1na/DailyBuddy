import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:jiffy/jiffy.dart';

import 'blocs.dart';
import '../models/models.dart';

class AddTaskFormBloc extends FormBloc<String, String> {
  final selectCategory = SelectFieldBloc<Category, Object>(
    validators: [(value) => (value == null) ? "Kategorie auswählen" : null],
  );
  final selectActivity = SelectFieldBloc<Activity, Object>(
    validators: [(value) => (value == null) ? "Aktivität auswählen" : null],
  );
  final selectDay = SelectFieldBloc<DateTime, Object>(
    validators: [(value) => (value == null) ? "Tag auswählen" : null],
  );
  final selectTime = InputFieldBloc<TimeOfDay, Object>(
    validators: [(value) => (value == null) ? "Uhrzeit auswählen" : null],
  );
  final selectDuration = SelectFieldBloc<Duration, Object>(
    items: [
      Duration(minutes: 15),
      Duration(minutes: 30),
      Duration(minutes: 45),
      Duration(minutes: 60),
      Duration(minutes: 90),
      Duration(minutes: 120),
      Duration(minutes: 180),
    ],
    initialValue: Duration(minutes: 60),
    validators: [(value) => (value == null) ? "Dauer auswählen" : null],
  );

  final BuildContext context;

  AddTaskFormBloc({this.context, ActivitiesLoaded activitiesState}) {
    final daysState = BlocProvider.of<DaysBloc>(context).state;
    selectDay.updateItems(daysState.weekDays);
    selectDay.updateInitialValue(daysState.today);
    selectCategory.updateItems(activitiesState.categories);
    selectTime.updateInitialValue(
        TimeOfDay(hour: DateTime.now().hour + 1, minute: 0));

    addFieldBlocs(
      fieldBlocs: [
        selectDay,
        selectTime,
        selectDuration,
        selectCategory,
      ],
    );

    selectCategory.onValueChanges(
      onData: (previous, current) async* {
        if (current.isValid) {
          selectActivity.updateItems(activitiesState.activities
              .where((a) => a.category == current.value)
              .toList());
          addFieldBlocs(fieldBlocs: [selectActivity]);
        } else {
          selectActivity.updateItems([]);
          removeFieldBlocs(fieldBlocs: [selectActivity]);
        }
      },
    );
  }

  @override
  void onSubmitting() {
    final task = Task(
        activity: selectActivity.value,
        startTime: selectDay.value.add(Duration(
            hours: selectTime.value.hour, minutes: selectTime.value.minute)),
        duration: selectDuration.value);
    BlocProvider.of<TasksBloc>(context).add(AddTaskEvent(task));
    emitSuccess(
        successResponse:
            "${task.activity.activityName} geplant ${Jiffy(task.startTime).fromNow()}",
        canSubmitAgain: false);
  }
}
