import 'package:taskmanager/core/constants.dart';

class Task {
  Task({
    //required this.alarm,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.status,
    required this.title,
    String? taskId,
  }) : taskId = uuid.v4();

  final String taskId;
  final String title;
  final String? description;
  final String dueDate;
  //final String? alarm;
  final Status status;
  final Priority priority;
}
