import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String taskName;
  final String description;
  final DateTime date;

  Task({
    required this.date,
    required this.description,
    required this.taskName,
  });

  Map<String, dynamic> toJson() =>
      {'taskName': taskName, 'desciption': description, 'date': date};

  fromJson(Map<String, dynamic> json) => Task(
        date: (json['date'] as Timestamp).toDate(),
        description: json['description'],
        taskName: json['taskName'],
      );
}
