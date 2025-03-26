import 'package:hously_flutter/screens/todo/apis_model/tasks_model.dart';

final projectProgressDefault = ProjectProgresses(
    id: 0,
    name: '',
    timestamp: DateTime.now().toString(),
    project: 1,
    tasks: [tasksDefault]
);
class ProjectProgresses {
  final int? id;
  final List<Tasks>? tasks;
  final String? name;
  final String? timestamp;
  final int? project;

 const ProjectProgresses({
    this.id,
    this.tasks,
    this.name,
    this.timestamp,
    this.project,
  });

  factory ProjectProgresses.fromJson(Map<String, dynamic> json) {
    return ProjectProgresses(
      id: json['id'],
      tasks: json['tasks'] != null
          ? List<Tasks>.from(json['tasks'].map((v) => Tasks.fromJson(v)))
          : null,
      name: json['name'],
      timestamp: json['timestamp'],
      project: json['project'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tasks': tasks?.map((v) => v.toJson()).toList(),
      'name': name,
      'timestamp': timestamp,
      'project': project,
    };
  }
  ProjectProgresses copyWith({
    int? id,
    List<Tasks>? tasks,
    String? name,
    String? timestamp,
    int? project,
  }) {
    return ProjectProgresses(
      id: id ?? this.id,
      tasks: tasks ?? this.tasks,
      name: name ?? this.name,
      timestamp: timestamp ?? this.timestamp,
      project: project ?? this.project,
    );
  }
}
