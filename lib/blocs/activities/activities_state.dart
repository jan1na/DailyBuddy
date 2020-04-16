part of 'activities_bloc.dart';

abstract class ActivitiesState extends Equatable {
  const ActivitiesState();
  @override
  List<Object> get props => [];
  @override
  bool get stringify => true;
}

class ActivitiesNotLoaded extends ActivitiesState {
  const ActivitiesNotLoaded();
}

class ActivitiesLoaded extends ActivitiesState {
  final List<Activity> activities;
  final List<Category> categories;
  const ActivitiesLoaded({this.activities, this.categories});
  @override
  List<Object> get props => [activities, categories];
}
