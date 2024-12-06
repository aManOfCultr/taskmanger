import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:taskmanager/core/constants.dart';
import 'package:taskmanager/features/task/model/task.dart';
import 'package:taskmanager/features/task/view/screens/add_task_screen.dart';
import 'package:taskmanager/features/task/viewmodel/task_notifier_provider.dart';
import 'package:taskmanager/shared/widgets/task_card.dart';

class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});

  @override
  ConsumerState<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    final taskList = ref.watch(TaskNotifierProvider);

    void openTaskOverlay() {
      showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        scrollControlDisabledMaxHeightRatio: 0.5,
        constraints: const BoxConstraints(
          minWidth: 0,
          maxWidth: double.infinity,
        ),
        context: context,
        builder: (ctx) => const AddTaskScreen(),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Task List')),
      body: taskList.isEmpty
          ? const Center(child: Text('No tasks available.'))
          : ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (ctx, index) {
                final taskValue = taskList[index];
                return Slidable(
                  key: ValueKey(taskValue),
                  startActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (ctx) {},
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                        icon: Icons.check,
                      )
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (ctx) {},
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.yellow.shade200,
                        icon: Icons.edit,
                      ),
                      SlidableAction(
                        onPressed: (ctx) {},
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Feedback.forTap(context);
                    },
                    child: TaskCard(
                      task: taskValue,
                    ),
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: openTaskOverlay,
        child: const Icon(Icons.add),
      ),
    );
  }
}
