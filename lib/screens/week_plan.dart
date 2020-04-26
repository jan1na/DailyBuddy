import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:jiffy/jiffy.dart';

import '../blocs/blocs.dart';

class WeekPlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DaysBloc, DaysState>(
        builder: (context, daysState) {
          final DateTime today = daysState.today;
          final List<DateTime> weekDays = daysState.weekDays;
          return BlocBuilder<TasksBloc, TasksState>(
            builder: (context, tasksState) {
              return WeekView(
                  dayViewBuilder: (BuildContext context, WeekView weekView,
                          DateTime date, DayViewController controller) =>
                      DayView(
                        date: date,
                        events: weekView.events
                            .where(
                                (e) => Jiffy(e.start).isSame(date, Units.DAY))
                            .toList(),
                        hoursColumnWidth: 0,
                        controller: controller,
                        inScrollableWidget: false,
                        dayBarHeight: 0,
                        userZoomable: false,
                        scrollToCurrentTime: true,
                        eventsColumnBackgroundPainter:
                            EventsColumnBackgroundPainter(
                                backgroundColor:
                                    Jiffy(date).isSame(today, Units.DAY)
                                        ? Theme.of(context).cardColor
                                        : Theme.of(context).backgroundColor),
                        currentTimeRuleColor: Theme.of(context).accentColor,
                      ),
                  dayBarBackgroundColor: Theme.of(context).cardColor,
                  dayBarTextStyle: Theme.of(context).textTheme.body1,
                  hoursColumnBackgroundColor: Theme.of(context).cardColor,
                  hoursColumnTextStyle: Theme.of(context).textTheme.body1,
                  dateFormatter: (year, month, day) =>
                      Jiffy(DateTime(year, month, day)).MMMMEEEEd,
                  dates: weekDays,
                  events: [
                    ...tasksState.taskList.map((t) => FlutterWeekViewEvent(
                        title: t.activity.activityName,
                        description: t.activity.description,
                        start: t.startTime,
                        end: t.startTime.add(t.duration),
                        backgroundColor: t.activity.category.color,
                        onTap: () => BlocProvider.of<NavigationBloc>(context)
                            .add(OpenTaskDetailsPageEvent(taskId: t.taskId))))
                  ]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_alarm),
          onPressed: () => BlocProvider.of<NavigationBloc>(context)
              .add(OpenAddTaskPageEvent())),
    );
  }
}
