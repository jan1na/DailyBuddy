import 'package:equatable/equatable.dart';
import 'package:nanoid/nanoid.dart';

import 'models.dart';

class Activity extends Equatable {
  final String activityId;
  final String activityName;
  final Category category;

  Activity({String activityId, this.activityName, this.category})
      : activityId = activityId ?? nanoid();

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
      activityId: json['activityId'] as String,
      activityName: json['activityName'] as String,
      category: Category.fromJson(json['category']));

  Map<String, dynamic> toJson() => {
        'activityId': activityId,
        'activityName': activityName,
        'category': category.toJson()
      };

  @override
  List<Object> get props => [activityId, activityName, category];

  @override
  bool get stringify => true;
}
