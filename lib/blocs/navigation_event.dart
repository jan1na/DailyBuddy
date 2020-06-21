part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
  @override
  List<Object> get props => [];
  @override
  bool get stringify => true;
}

class OpenTaskDetailsPageEvent extends NavigationEvent {
  final String taskId;
  const OpenTaskDetailsPageEvent({this.taskId});
  @override
  List<Object> get props => [taskId];
}

class OpenAddTaskPageEvent extends NavigationEvent {}

class OpenWeekPlanPageEvent extends NavigationEvent {}

class OpenDashboardPageEvent extends NavigationEvent {}

class OpenPreferencesPageEvent extends NavigationEvent {}

class OpenAboutUsPageEvent extends NavigationEvent {}

class OpenCalendarPageEvent extends NavigationEvent {}

class OpenEmergencyContactsPageEvent extends NavigationEvent {}

class OpenFeedbackPageEvent extends NavigationEvent {}

class OpenHelpPageEvent extends NavigationEvent {}

class OpenQuestionsPageEvent extends NavigationEvent {}

class OpenWikiPageEvent extends NavigationEvent {}

class OpenUserSuccessesPageEvent extends NavigationEvent {}

class OpenWeekGoalsPageEvent extends NavigationEvent {}
