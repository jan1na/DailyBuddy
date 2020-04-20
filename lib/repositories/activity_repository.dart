import 'package:flutter/material.dart';

import "../models/models.dart";

abstract class ActivityRepository {
  Future<void> addCategory(Category category);
  Future<List<Category>> loadCategories();
  Future<void> updateCategory(Category category);
  Future<void> deleteCategory(Category category);

  Future<void> addActivity(Activity activity);
  Future<List<Activity>> loadActivities();
  Future<void> updateActivity(Activity activity);
  Future<void> deleteActivity(Activity activity);
}

class LocalActivityRepository implements ActivityRepository {
  final Future<List<Category>> categories;
  final Future<List<Activity>> activities;

  LocalActivityRepository({this.categories, this.activities});

  @override
  Future<void> addActivity(Activity activity) {
    // TODO: implement addActivity
    return null;
  }

  @override
  Future<void> addCategory(Category category) {
    // TODO: implement addCategory
    return null;
  }

  @override
  Future<void> deleteActivity(Activity activity) {
    // TODO: implement deleteActivity
    return null;
  }

  @override
  Future<void> deleteCategory(Category category) {
    // TODO: implement deleteCategory
    return null;
  }

  @override
  Future<List<Activity>> loadActivities() {
    return activities;
  }

  @override
  Future<List<Category>> loadCategories() {
    return categories;
  }

  @override
  Future<void> updateActivity(Activity activity) {
    // TODO: implement updateActivity
    return null;
  }

  @override
  Future<void> updateCategory(Category category) {
    // TODO: implement updateCategory
    return null;
  }
}

String placeholderDescription =
    "Hier könnte eine genaue Beschreibung der Aktivität stehen, mit weiterführenden Links, https://de.wikipedia.org zum Beispiel, die im Browser geöffnet werden.";

final sportCategory = Category(categoryName: "Sport", color: Colors.orange);
final sportActivities = [
  Activity(
      activityName: "Spazieren",
      category: sportCategory,
      description: placeholderDescription),
  Activity(
      activityName: "Joggen",
      category: sportCategory,
      description: placeholderDescription),
  Activity(
      activityName: "Ballsport",
      category: sportCategory,
      description: placeholderDescription),
];

final mentalCategory =
    Category(categoryName: "Mental Health", color: Colors.blue);
final mentalActivities = [
  Activity(
      activityName: "Selbstwertgefühl",
      category: mentalCategory,
      description: placeholderDescription),
  Activity(
      activityName: "Stressresistenz",
      category: mentalCategory,
      description: placeholderDescription),
  Activity(
      activityName: "Meditation",
      category: mentalCategory,
      description: placeholderDescription),
];

final socialCategory =
    Category(categoryName: "Soziale Kontakte", color: Colors.purple);
final socialActivities = [
  Activity(
      activityName: "Telefonieren",
      category: socialCategory,
      description: placeholderDescription),
  Activity(
      activityName: "Skypen",
      category: socialCategory,
      description: placeholderDescription),
  Activity(
      activityName: "mit Nachbarn reden",
      category: socialCategory,
      description: placeholderDescription),
];

final feedingCategory =
    Category(categoryName: "Ernährung", color: Colors.green);
final feedingActivities = [
  Activity(
      activityName: "Kochen",
      category: feedingCategory,
      description: placeholderDescription),
  Activity(
      activityName: "Einkaufen",
      category: feedingCategory,
      description: placeholderDescription),
  Activity(
      activityName: "Rezeptideen",
      category: feedingCategory,
      description: placeholderDescription),
];

final creativeCategory =
    Category(categoryName: "Künstlerische Aktivitäten", color: Colors.cyan);
final creativeActivities = [
  Activity(
      activityName: "Malen",
      category: creativeCategory,
      description: placeholderDescription),
  Activity(
      activityName: "Basteln",
      category: creativeCategory,
      description: placeholderDescription),
  Activity(
      activityName: "Handarbeiten",
      category: creativeCategory,
      description: placeholderDescription),
];

final initialCategories = [
  sportCategory,
  mentalCategory,
  socialCategory,
  feedingCategory,
  creativeCategory,
];
final initialActivities = [
  ...sportActivities,
  ...mentalActivities,
  ...socialActivities,
  ...feedingActivities,
  ...creativeActivities,
];

class InitialActivityRepository extends LocalActivityRepository {
  final Future<List<Category>> categories = Future.value(initialCategories);
  final Future<List<Activity>> activities = Future.value(initialActivities);
}
