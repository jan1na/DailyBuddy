import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';

class Category extends Equatable {
  final String categoryId;
  final String categoryName;
  final Color color;

  Category({String categoryId, this.categoryName, Color color})
      : color = color ?? Colors.blue,
        categoryId = categoryId ?? nanoid();

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
      color: Color(json['color'] as int));

  Map<String, dynamic> toJson() => {
        'categoryId': categoryId,
        'categoryName': categoryName,
        'color': color.value
      };
  @override
  List<Object> get props => [categoryId, categoryName, color];

  @override
  bool get stringify => true;
}
