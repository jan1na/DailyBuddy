import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  StreamSubscription notificationSelectedSubscription;

  NavigationBloc({Stream notificationSelectedStream}) {
    notificationSelectedSubscription =
        notificationSelectedStream.listen((playload) {
      add(OpenTaskDetailsPageEvent(taskId: playload));
    });
  }

  @override
  NavigationState get initialState => DashboardPageNavigation();

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    switch (event.runtimeType) {
      case OpenTaskDetailsPageEvent:
        yield TaskDetailPageNavigation(
            taskId: (event as OpenTaskDetailsPageEvent).taskId);
        break;
      case OpenAddTaskPageEvent:
        yield AddTaskPageNavigation();
        break;
      case OpenWeekPlanPageEvent:
        yield WeekPlanPageNavigation();
        break;
      case OpenDashboardPageEvent:
        yield DashboardPageNavigation();
        break;
      case OpenQuestionsPageEvent:
        yield QuestionsPageNavigation();
        break;
      case OpenWeekGoalsPageEvent:
        yield WeekGoalsPageNavigation();
        break;
      case OpenEmergencyContactsPageEvent:
        yield EmergencyContactsPageNavigation();
        break;
      case OpenPreferencesPageEvent:
        yield PreferencesPageNavigation(tabIndex: state.tabIndex);
        break;
      case OpenAboutUsPageEvent:
        yield AboutUsPageNavigation(tabIndex: state.tabIndex);
        break;
      case OpenCalendarPageEvent:
        yield CalendarPageNavigation(tabIndex: state.tabIndex);
        break;
      case OpenFeedbackPageEvent:
        yield FeedbackPageNavigation(tabIndex: state.tabIndex);
        break;
      case OpenHelpPageEvent:
        yield HelpPageNavigation(tabIndex: state.tabIndex);
        break;
      case OpenWikiPageEvent:
        yield WikiPageNavigation(tabIndex: state.tabIndex);
        break;
      case OpenUserSuccessesPageEvent:
        yield UserSuccessesPageNavigation(tabIndex: state.tabIndex);
        break;
    }
  }

  @override
  Future<void> close() {
    notificationSelectedSubscription.cancel();
    return super.close();
  }
}
