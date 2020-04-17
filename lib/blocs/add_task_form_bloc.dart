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

  final BuildContext context;

  AddTaskFormBloc({this.context, ActivitiesLoaded activitiesState}) {
    final daysState = BlocProvider.of<DaysBloc>(context).state;
    selectDay.updateItems(daysState.weekDays);
    selectDay.updateInitialValue(daysState.today);
    selectCategory.updateItems(activitiesState.categories);

    addFieldBlocs(
      fieldBlocs: [
        selectDay,
        selectTime,
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
            hours: selectTime.value.hour, minutes: selectTime.value.minute)));
    BlocProvider.of<TasksBloc>(context).add(AddTaskEvent(task));
    emitSuccess(
        successResponse:
            "${task.activity.activityName} geplant ${Jiffy(task.startTime).fromNow()}",
        canSubmitAgain: false);
  }
}
