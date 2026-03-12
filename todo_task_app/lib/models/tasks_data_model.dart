// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:todo_task_app/models/project_data_model.dart';

enum TaskType { todo, progress, completed }

class TasksDataModel {
  final String? id;
  final String? title;
  final String? description;
  final ProjectDataModel? projects;
  final TaskType type;
  TasksDataModel({
    this.id,
    this.title,
    this.description,
    this.projects,
    required this.type,
  });

  TasksDataModel copyWith({
    String? id,
    String? title,
    String? description,
    ProjectDataModel? projects,
    TaskType? type,
  }) {
    return TasksDataModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      projects: projects ?? this.projects,
      type: type ?? this.type,
    );
  }

 Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'projects': projects?.toMap(),
      'type': type.name,
    };
  }

  factory TasksDataModel.fromMap(Map<String, dynamic> map) {
    return TasksDataModel(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null
          ? map['description'] as String
          : null,
      projects: map['projects'] != null
          ? ProjectDataModel.fromMap(map['projects'] as Map<String, dynamic>)
          : null,
      type: TaskType.values.byName(map['type'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory TasksDataModel.fromJson(String source) =>
      TasksDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TasksDataModel(id: $id, title: $title, description: $description, projects: $projects, type: $type)';
  }

  @override
  bool operator ==(covariant TasksDataModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.projects == projects &&
      other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      projects.hashCode ^
      type.hashCode;
  }
}
