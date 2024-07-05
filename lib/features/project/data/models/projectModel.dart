import 'dart:convert';

import 'package:project_manager/features/project/data/models/taskModel.dart';

class ProjectModel {
  String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final String deadline;
  final double progress;

  ProjectModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.deadline,
    required this.description,
    required this.progress,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'deadline': deadline,
      'progress': progress
    };
  }

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      deadline: json['deadline'],
      description: json['description'],
      progress: json['progress'],
    );
  }
}
