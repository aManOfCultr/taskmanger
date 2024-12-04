import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanager/core/constants.dart';
import 'package:taskmanager/features/task/model/task.dart';
import 'package:taskmanager/features/task/viewmodel/task_notifier_provider.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({super.key});

  @override
  ConsumerState<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  DateTime? _selectedDate;

    void _presentDatePicker() async {
      final pickedDate = await showDatePicker(
        context: context,firstDate: DateTime.now(), lastDate: DateTime(2100)
      );
      setState(() {
        _selectedDate = pickedDate;
      });
    }

  void _addTask() {
    final title = _titleController.text.trim();
    final description = _descController.text.trim();
    

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task title cannot be empty')),
      );
      return;
    }

    Task task = new Task(
        description: description,
        dueDate: _selectedDate!.toIso8601String(),
        status: Status.pending,
        title: title);

    ref.read(TaskNotifierProvider.notifier).addTasks(task);

    Navigator.of(context).pop(); // Go back to the task list screen
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Task Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(
                  labelText: 'Task Description (optional)'),
            ),
            const SizedBox(height: 10),
            IconButton(
              onPressed: _presentDatePicker,
              icon: const Icon(Icons.calendar_month),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addTask,
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
