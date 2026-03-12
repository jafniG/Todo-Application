// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProjectDataModel {
  final String? id;
  final String? title;
  final String? description;
  final String? time;
  ProjectDataModel({
    this.id,
    this.title,
    this.description,
    this.time,
  });

  ProjectDataModel copyWith({
    String? id,
    String? title,
    String? description,
    String? time,
  }) {
    return ProjectDataModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'time': time,
    };
  }

  factory ProjectDataModel.fromMap(Map<String, dynamic> map) {
    return ProjectDataModel(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectDataModel.fromJson(String source) =>
      ProjectDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProjectDataModel(id: $id, title: $title, description: $description, time: $time)';
  }

  @override
  bool operator ==(covariant ProjectDataModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      time.hashCode;
  }
}
