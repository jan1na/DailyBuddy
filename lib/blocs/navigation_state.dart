part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  final int tabIndex;
  const NavigationState({this.tabIndex});
  @override
  List<Object> get props => [tabIndex];
  @override
  bool get stringify => true;
}

abstract class MainNavigation extends NavigationState {
  const MainNavigation({int tabIndex}) : super(tabIndex: tabIndex);
}

abstract class SubNavigation extends NavigationState {
  const SubNavigation({int tabIndex}) : super(tabIndex: tabIndex);
}

abstract class SideNavigation extends NavigationState {
  const SideNavigation({int tabIndex}) : super(tabIndex: tabIndex);
}

class DashboardPageNavigation extends MainNavigation {
  const DashboardPageNavigation() : super(tabIndex: 0);
}

class QuestionsPageNavigation extends MainNavigation {
  const QuestionsPageNavigation() : super(tabIndex: 1);
}

class WeekGoalsPageNavigation extends MainNavigation {
  const WeekGoalsPageNavigation() : super(tabIndex: 2);
}

class WeekPlanPageNavigation extends MainNavigation {
  const WeekPlanPageNavigation() : super(tabIndex: 3);
}

class EmergencyContactsPageNavigation extends MainNavigation {
  const EmergencyContactsPageNavigation() : super(tabIndex: 4);
}

class TaskDetailPageNavigation extends SubNavigation {
  final String taskId;
  const TaskDetailPageNavigation({this.taskId}) : super(tabIndex: 3);
  @override
  List<Object> get props => [tabIndex, taskId];
}

class AddTaskPageNavigation extends SubNavigation {
  const AddTaskPageNavigation() : super(tabIndex: 3);
}

class PreferencesPageNavigation extends SideNavigation {
  const PreferencesPageNavigation({int tabIndex}) : super(tabIndex: tabIndex);
}

class AboutUsPageNavigation extends SideNavigation {
  const AboutUsPageNavigation({int tabIndex}) : super(tabIndex: tabIndex);
}

class CalendarPageNavigation extends SideNavigation {
  const CalendarPageNavigation({int tabIndex}) : super(tabIndex: tabIndex);
}

class FeedbackPageNavigation extends SideNavigation {
  const FeedbackPageNavigation({int tabIndex}) : super(tabIndex: tabIndex);
}

class HelpPageNavigation extends SideNavigation {
  const HelpPageNavigation({int tabIndex}) : super(tabIndex: tabIndex);
}

class UserProfilePageNavigation extends SideNavigation {
  const UserProfilePageNavigation({int tabIndex}) : super(tabIndex: tabIndex);
}

class WikiPageNavigation extends SideNavigation {
  const WikiPageNavigation({int tabIndex}) : super(tabIndex: tabIndex);
}

class UserSuccessesPageNavigation extends SideNavigation {
  const UserSuccessesPageNavigation({int tabIndex}) : super(tabIndex: tabIndex);
}