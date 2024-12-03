import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanager/features/auth/presentation/providers/auth_provider.dart';

class TaskListScreen extends ConsumerWidget {
  TaskListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authStateProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await authNotifier.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
