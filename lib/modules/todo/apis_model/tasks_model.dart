import 'package:hously_flutter/modules/todo/apis_model/user_model.dart';

const tasksDefault = Tasks();
class Tasks {
  final int? id;
  final int? progressId; // Extracted progress ID
  final Progress? progress; // Stores the full progress object for detailed use
  final String? name;
  final String? description;
  final bool? isCompleted;
  final String? priority;
  final int? ordering;
  final MetaFields? metaFields;
  final String? timestamp;
  final int? projectId; // Stores only the project ID as an integer
  final Project? project; // Stores the full Project object for detailed use
  final int? assignedToUser;
  final List<String>? tags;
  final List<TaskFile>? files;

  const Tasks({
    this.id,
    this.progressId,
    this.progress,
    this.name,
    this.description,
    this.isCompleted,
    this.priority,
    this.ordering,
    this.metaFields,
    this.timestamp,
    this.projectId,
    this.project,
    this.assignedToUser,
    this.tags,
    this.files,
  });

  factory Tasks.fromJson(Map<String, dynamic> json) {
    final projectJson = json['project'];
    final progressJson = json['progress'];
    return Tasks(
      id: json['id'],
      progressId: progressJson is Map<String, dynamic> ? progressJson['id'] : progressJson as int?, // Safely extract progress ID
      progress: progressJson is Map<String, dynamic> ? Progress.fromJson(progressJson) : null, // Parse progress object if nested
      name: json['name'],
      description: json['description'],
      isCompleted: json['is_completed'],
      priority: json['priority'],
      ordering: json['ordering'],
      metaFields: json['meta_fields'] != null
          ? MetaFields.fromJson(json['meta_fields'])
          : null,
      timestamp: json['timestamp'],
      projectId: projectJson is Map<String, dynamic> ? projectJson['id'] : projectJson as int?, // Safely extract project ID
      project: projectJson is Map<String, dynamic> ? Project.fromJson(projectJson) : null, // Parse Project object if nested
      assignedToUser: json['assigned_to_user'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      files: json['files'] != null
          ? List<TaskFile>.from(json['files'].map((fileJson) => TaskFile.fromJson(fileJson)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'progressId': progressId, // Include progressId separately
      'progress': progress?.toJson(), // Include the full progress object if present
      'name': name,
      'description': description,
      'is_completed': isCompleted,
      'priority': priority,
      'ordering': ordering,
      'meta_fields': metaFields?.toJson(),
      'timestamp': timestamp,
      'project': project?.toJson(), // Include the full Project object if present
      'projectId': projectId, // Include projectId separately
      'assigned_to_user': assignedToUser,
      'tags': tags,
      'files': files?.map((file) => file.toJson()).toList(),
    };
  }
  Tasks copyWith({
    int? id,
    Progress? progress,
    String? name,
    String? description,
    bool? isCompleted,
    String? priority,
    int? ordering,
    MetaFields? metaFields,
    String? timestamp,
    int? projectId,
    int? assignedToUser,
    List<String>? tags,
    List<TaskFile>? files,
  }) {
    return Tasks(
      id: id ?? this.id,
      progress: progress ?? this.progress,
      name: name ?? this.name,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      ordering: ordering ?? this.ordering,
      metaFields: metaFields ?? this.metaFields,
      timestamp: timestamp ?? this.timestamp,
      projectId: projectId ?? this.projectId,
      assignedToUser: assignedToUser ?? this.assignedToUser,
      tags: tags ?? this.tags,
      files: files ?? this.files,
    );
  }
}

class MetaFields {
  final String? someField;

  const MetaFields({this.someField});

  factory MetaFields.fromJson(Map<String, dynamic> json) {
    return MetaFields(
      someField: json['some-field'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'some-field': someField,
    };
  }
}

class TaskFile {
  final int? id;
  final String? name;
  final String? file;
  final String? timestamp;

  const TaskFile({
    this.id,
    this.name,
    this.file,
    this.timestamp,
  });

  factory TaskFile.fromJson(Map<String, dynamic> json) {
    return TaskFile(
      id: json['id'],
      name: json['name'],
      file: json['file'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'file': file,
      'timestamp': timestamp,
    };
  }
}
class Project {
  final int? id;
  final User? user;
  final String? avatar;
  final String? name;
  final String? description;
  final String? timestamp;
  final List<dynamic>? addedUsers;

  const Project({
    this.id,
    this.user,
    this.avatar,
    this.name,
    this.description,
    this.timestamp,
    this.addedUsers,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      avatar: json['avatar'],
      name: json['name'],
      description: json['description'],
      timestamp: json['timestamp'],
      addedUsers: json['added_users'] != null ? List<dynamic>.from(json['added_users']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJson(),
      'avatar': avatar,
      'name': name,
      'description': description,
      'timestamp': timestamp,
      'added_users': addedUsers,
    };
  }
}

class Progress {
  final int? id;
  final int? projectId;
  final String? name;
  final String? timestamp;

  const Progress({
    this.id,
    this.projectId,
    this.name,
    this.timestamp,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      id: json['id'],
      projectId: json['project'],
      name: json['name'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project': projectId,
      'name': name,
      'timestamp': timestamp,
    };
  }
}
