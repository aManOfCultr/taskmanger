import 'package:flutter/material.dart';
import 'package:taskmanager/core/constants.dart'; // Import for `Status` and `Priority` enums
import 'package:intl/intl.dart';
import 'package:taskmanager/features/task/model/task.dart'; // For formatting date

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    
    final priorityColor = _getPriorityColor(task.priority);
    final statusColor = _getStatusColor(task.status);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.more_vert, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 8),

            // Priority and status tags
            Row(
              children: [
                _buildTag(task.priority.name, priorityColor),
                const SizedBox(width: 8),
                _buildTag(task.status.name, statusColor),
              ],
            ),
            const SizedBox(height: 12),

            // Due date, links, comments, and assignees
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Due date
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('dd MMM yyyy')
                          .format(DateTime.parse(task.dueDate)),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),

                // Links, comments, and assignees
                Row(
                  children: [
                    _buildIconText(Icons.link, '5'),
                    const SizedBox(width: 16),
                    _buildIconText(Icons.comment, '5'),
                    const SizedBox(width: 16),
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
  Widget _buildTag(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Helper to build icon and text (links, comments, etc.)
  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  // Helper to build assignees (sample avatars)

  // Helper to get color based on priority
  Color _getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.low:
        return priorityColor[Priority.low]!;
      case Priority.medium:
        return priorityColor[Priority.medium]!;
      case Priority.high:
        return priorityColor[Priority.high]!;
      default:
        return Colors.grey;
    }
  }

  // Helper to get color based on status
  Color _getStatusColor(Status status) {
    switch (status) {
      case Status.incomplete:
        return statusColor[Status.incomplete]!;
      case Status.pending:
        return statusColor[Status.pending]!;
      case Status.completed:
        return statusColor[Status.completed]!;
      default:
        return Colors.grey;
    }
  }
}
