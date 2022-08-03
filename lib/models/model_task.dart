import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String taskName;
  final String description;
  String taskId;
  final DateTime date;

  Task(
      {required this.date,
      required this.description,
      required this.taskName,
      this.taskId = ''});

  Map<String, dynamic> toJson() => {
        'taskName': taskName,
        'desciption': description,
        'taskId': taskId,
        'date': date
      };

  static fromJson(Map<String, dynamic> json) => Task(
        date: (json['date'] as Timestamp).toDate(),
        description: json['description'],
        taskName: json['taskName'],
        taskId: json['taskId'],
      );
}
