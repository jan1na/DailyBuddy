import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/repositories.dart';
import '../models/models.dart';

part 'activities_event.dart';
part 'activities_state.dart';

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  final ActivityRepository activityRepository;

  ActivitiesBloc({this.activityRepository});

  @override
  ActivitiesState get initialState => ActivitiesNotLoaded();

  @override
  Stream<ActivitiesState> mapEventToState(
    ActivitiesEvent event,
  ) async* {
    switch (event.runtimeType) {
      case LoadActivitiesEvent:
        yield* mapLoadActivitiesEvent();
        break;
    }
  }

  Stream<ActivitiesState> mapLoadActivitiesEvent() async* {
    final categories = await activityRepository.loadCategories();
    final activities = await activityRepository.loadActivities();
    yield ActivitiesLoaded(categories: categories, activities: activities);
  }
}
