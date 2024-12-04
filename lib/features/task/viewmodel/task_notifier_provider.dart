import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanager/features/task/model/task.dart';
import 'package:taskmanager/features/task/viewmodel/task_notifier.dart';

final TaskNotifierProvider = StateNotifierProvider<TaskNotifier, List<Task>>(
  (ref) => TaskNotifier(),
);
