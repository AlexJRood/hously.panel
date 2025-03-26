import 'package:hously_flutter/screens/todo/apis_model/user_model.dart';
import 'board_progress_model.dart';

final boardDetailsModelDefault = BoardDetailsModel(
    timestamp: DateTime.now().toString(),
    name: '',
    id: 0,
    projectProgresses:[projectProgressDefault],
    user:userDefault
);

class BoardDetailsModel {
  final int? id;
  final User? user;
  final List<ProjectProgresses>? projectProgresses;
  final String? name;
  final String? timestamp;

 const BoardDetailsModel({
    this.id,
    this.user,
    this.projectProgresses,
    this.name,
    this.timestamp,
  });

  factory BoardDetailsModel.fromJson(Map<String, dynamic> json) {
    return BoardDetailsModel(
      id: json['id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      projectProgresses: json['project_progesses'] != null
          ? List<ProjectProgresses>.from(
        json['project_progesses'].map((v) => ProjectProgresses.fromJson(v)),
      )
          : null,
      name: json['name'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJson(),
      'project_progesses': projectProgresses?.map((v) => v.toJson()).toList(),
      'name': name,
      'timestamp': timestamp,
    };
  }
}