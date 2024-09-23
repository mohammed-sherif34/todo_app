import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String? id;
  static const String collection = 'Tasks';
  String title;
  String description;
  DateTime time;
  bool isDone;

  Task(
      {this.id,
      required this.title,
      required this.description,
      required this.time,
      this.isDone = false});
  Task.fromJson(Map<String, Object?> json)
      : this(
          title: json['title'] as String,
          description: json['description'] as String,
          time:(json['time'] as Timestamp).toDate() ,
          id: json['id'] as String,
          isDone: json['isDone'] as bool,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'time': time,
      'isDone': isDone,
    };
  }
}
