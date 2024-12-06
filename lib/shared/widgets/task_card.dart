import 'package:flutter/material.dart';
import 'package:taskmanager/core/constants.dart'; // Import for `Status` and `Priority` enums
import 'package:intl/intl.dart';
import 'package:taskmanager/features/task/model/task.dart';
import 'package:taskmanager/shared/widgets/buildtag.dart'; // For formatting date

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final priorityColor = _getPriorityColor(task.priority);
    final statusColor = _getStatusColor(task.status);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: Colors.black,
            width: 1,
          )),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and more options button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                buildTag(task.priority.name, priorityColor),
              ],
            ),
            const SizedBox(height: 8),

            // Priority and status tags
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    task.description == null ? ' ' : task.description!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                buildTag(task.status.name, statusColor),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Due date
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        size: 16, color: Colors.grey.shade700),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('dd MMM yyyy')
                          .format(DateTime.parse(task.dueDate)),
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Icon(Icons.alarm_on, size: 18, color: Colors.grey.shade700),
                    const SizedBox(width: 16),
                    Text(
                      'time',
                      style: TextStyle(color: Colors.grey.shade600),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper to build priority/status tags
  // Widget _buildTag(String label, Color color) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //     decoration: BoxDecoration(
  //       color: color.withOpacity(0.2),
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: Text(
  //       label,
  //       style: TextStyle(
  //         color: color,
  //         fontSize: 12,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //   );
  // }

  // Helper to get color based on priority
  Color _getPriorityColor(Priority priority) {
    return priorityColor[priority]!;
  }

  // Helper to get color based on status
  Color _getStatusColor(Status status) {
    return statusColor[status]!;
  }
}
