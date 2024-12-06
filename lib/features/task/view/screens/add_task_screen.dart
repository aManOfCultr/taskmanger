import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/core/constants.dart';
import 'package:taskmanager/features/task/model/task.dart';
import 'package:taskmanager/features/task/viewmodel/task_notifier_provider.dart';
import 'package:taskmanager/shared/widgets/styled_text_field.dart';
import 'package:taskmanager/shared/widgets/buildtag.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({
    super.key,
  });

  @override
  ConsumerState<AddTaskScreen> createState() {
    return _AddTaskScreen();
  }
}

class _AddTaskScreen extends ConsumerState<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _priority;
  DateTime? _selectedDate;
  int i = 0;

  void _priorityToggle() {
    setState(() {
      if (i == 0) {
        _priority = 'low';
      } else if (i == 1) {
        _priority = 'medium';
      } else if (i == 2) {
        _priority = 'high';
      }
      i = (i + 1) % 3;
    });
  }

  void _presentDatePicker() async {
    final firstDate = DateTime(1972, 01, 01);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: DateTime(2100),
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void addTask() {
    if (_selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) => const Text('Please Select Date'),
      );
      return;
    }
    if (_priority == null) {
      showDialog(
        context: context,
        builder: (context) => const Text('Please Set Priority'),
      );
      return;
    }
    if (_titleController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const Text('Please Enter Title'),
      );
      return;
    }

    final Task task = Task(
        description: _descriptionController.text,
        dueDate: _selectedDate!.toIso8601String(),
        priority: Priority.values.byName(_priority!),
        status: Status.pending,
        title: _titleController.text);
    ref.read(TaskNotifierProvider.notifier).addTasks(task);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardHeight = MediaQuery.of(context).viewInsets.bottom;
    //final width = MediaQuery.of(context).size.width;

    return SizedBox(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, keyBoardHeight + 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StyledTextField(
              label: 'New Task',
              hint: 'Enter new task title here',
              controller: _titleController,
            ),
            const SizedBox(
              height: 8,
            ),
            StyledTextField(
              label: 'Description',
              hint: 'Description (Optional)',
              controller: _descriptionController,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: _priorityToggle,
                      child: buildTag(
                          _priority == null ? 'Select Priority' : _priority!,
                          _priority == null
                              ? Colors.grey
                              : priorityColor[
                                  Priority.values.byName(_priority!)]!),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                    Text(
                      _selectedDate == null
                          ? 'Select date'
                          : DateFormat('dd MMM yyyy').format(
                              DateTime.parse(
                                _selectedDate!.toIso8601String(),
                              ),
                            ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: addTask,
                      child: const Icon(Icons.send),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
