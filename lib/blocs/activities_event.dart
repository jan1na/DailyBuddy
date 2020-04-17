part of 'activities_bloc.dart';

abstract class ActivitiesEvent extends Equatable {
  const ActivitiesEvent();
  @override
  List<Object> get props => [];
  @override
  bool get stringify => true;
}

class LoadActivitiesEvent extends ActivitiesEvent {
  const LoadActivitiesEvent();
}

class AddActivityEvent extends ActivitiesEvent {
  final String activityName;
  const AddActivityEvent(this.activityName);
  @override
  List<Object> get props => [activityName];
}

class UpdateActivityEvent extends ActivitiesEvent {
  final Activity activity;
  const UpdateActivityEvent(this.activity);
  @override
  List<Object> get props => [activity];
}

class DeleteActivityEvent extends ActivitiesEvent {
  final Activity activity;
  const DeleteActivityEvent(this.activity);
  @override
  List<Object> get props => [activity];
}

class AddCategoryEvent extends ActivitiesEvent {
  final String categoryName;
  const AddCategoryEvent(this.categoryName);
  @override
  List<Object> get props => [categoryName];
}

class UpdateCategoryEvent extends ActivitiesEvent {
  final Category category;
  const UpdateCategoryEvent(this.category);
  @override
  List<Object> get props => [category];
}

class DeleteCategoryEvent extends ActivitiesEvent {
  final Category category;
  const DeleteCategoryEvent(this.category);
  @override
  List<Object> get props => [category];
}
