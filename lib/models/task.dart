import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String? id;
  static const String collection = 'Tasks';
  String title;
  String description;
  DateTime date;
  bool isDone;
  String time;
  //TimeOfDay? dayTime;

  Task(
      {this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.time,
      //this.dayTime,
      this.isDone = false});
  Task.fromJson(Map<String, Object?> json)
      : this(
          time: json['time'] as String,
          title: json['title'] as String,
          description: json['description'] as String,
          date: (json['date'] as Timestamp).toDate(),
           //dayTime: (json['dayTime'] as Timestamp).toDate(),
          id: json['id'] as String,
          isDone: json['isDone'] as bool,
        );

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'isDone': isDone,
    };
  }
}
