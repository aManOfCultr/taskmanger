import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanager/features/task/viewmodel/task_notifier_provider.dart';
import 'add_task_screen.dart'; // Ensure this is correctly imported

class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(TaskNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Task List')),
      body: taskList.isEmpty
          ? const Center(child: Text('No tasks available.'))
          : ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (ctx, index) {
                final task = taskList[index];
                return Card(
                  child: ListTile(
                    title: Text(task.title),
                    subtitle: task.description!.isEmpty
                        ? null
                        : Text(task.description!),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const AddTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
