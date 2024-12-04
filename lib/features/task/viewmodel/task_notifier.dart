import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:taskmanager/core/constants.dart';
import 'package:taskmanager/features/task/model/task.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE tasks(taskId TEXT PRIMARY KEY, title TEXT NOT NULL, description TEXT, dueDate TEXT NOT NULL,status TEXT NOT NULL)');
    },
    version: 1,
  );
  return db;
}

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super(const []);

  Future<void> loadTasks() async {
    final db = await _getDatabase();
    final data = await db.query('tasks');
    final tasks = data
        .map(
          (row) => Task(
              taskId: row['taskId'].toString(),
              description: row['description'].toString(),
              dueDate: row['dueDate'].toString(),
              
              status: Status.values.byName(row['status'].toString()),
              title: row['title'].toString()),
        )
        .toList();
    state = tasks;
  }

  void addTasks(Task newTask) async {
    // final newTask = Task(
    //   alarm: alarm,
    //   description: description,
    //   dueDate: dueDate,
    //   priority: priority,
    //   status: status,
    //   title: title,
    //   taskId: taskId,
    // );
    final db = await _getDatabase();
    db.insert('tasks', {
      'description': newTask.description,
      'dueDate': newTask.dueDate,
      
      'status': newTask.status,
      'title': newTask.title,
      'taskId': newTask.taskId,
    });
    state = [newTask, ...state];
  }

  void deleteTask(String taskId) async {
    final db = await _getDatabase();

    await db.delete(
      'tasks',
      where: 'taskId = ?',
      whereArgs: [taskId],
    );

    state = state.where((task) => task.taskId != taskId).toList();
  }

  void updateTask(Task updatedTask) async {
    final db = await _getDatabase();

    // Update the task in the database
    await db.update(
      'tasks', // Table name
      {
        'title': updatedTask.title,
        'description': updatedTask.description,
        'dueDate': updatedTask.dueDate,
        'status': updatedTask.status.name,
        'priority': updatedTask.priority.name,
      },
      where: 'taskId = ?',
      whereArgs: [updatedTask.taskId],
    );

    // Update the task in the in-memory list and state
    state = state.map((task) {
      if (task.taskId == updatedTask.taskId) {
        return updatedTask; // Replace the old task with the updated one
      }
      return task; // Keep the others unchanged
    }).toList();
  }
}
