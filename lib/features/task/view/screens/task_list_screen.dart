import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanager/core/constants.dart';
import 'package:taskmanager/features/task/model/task.dart';
import 'package:taskmanager/features/task/viewmodel/task_notifier_provider.dart';
import 'package:taskmanager/shared/widgets/task_card.dart';
import 'add_task_screen.dart';

class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = [
      Task(
          description: 'I will do this',
          dueDate: '20240522',
          priority: Priority.high,
          status: Status.pending,
          title: 'Make a task manager app'),
      Task(
          description: 'I will do this',
          dueDate: '20240522',
          priority: Priority.low,
          status: Status.completed,
          title: 'Impress Boss'),
      Task(
          description: 'I will do this',
          dueDate: '20240522',
          priority: Priority.medium,
          status: Status.incomplete,
          title: 'Have some icecream'),
      Task(
          description: 'I will do this',
          dueDate: '20240522',
          priority: Priority.high,
          status: Status.pending,
          title: 'Make a task manager app'),
      Task(
          description: 'I will do this',
          dueDate: '20240522',
          priority: Priority.low,
          status: Status.completed,
          title: 'Impress Boss'),
      Task(
          description: 'I will do this',
          dueDate: '20240522',
          priority: Priority.medium,
          status: Status.incomplete,
          title: 'Have some icecream')
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Task List')),
      body: taskList.isEmpty
          ? const Center(child: Text('No tasks available.'))
          : ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (ctx, index) => Dismissible(
                key: ValueKey(taskList[index]),
                onDismissed: (direction) {
                  if(direction == DismissDirection.startToEnd){
                    
                  }
                },
                child: TaskCard(
                  task: taskList[index],
                ),
              ),
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
