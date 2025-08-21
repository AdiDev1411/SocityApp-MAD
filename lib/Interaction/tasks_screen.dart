import 'package:flutter/material.dart';

class Task {
  final String description;
  bool isCompleted;

  Task({required this.description, this.isCompleted = false});
}

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  static final List<Task> _dummyTasks = [
    Task(description: 'Follow up on lift maintenance AMC', isCompleted: true),
    Task(description: 'Get quotes for lobby painting', isCompleted: false),
    Task(description: 'Organize the documents for society audit', isCompleted: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _dummyTasks.length,
        itemBuilder: (context, index) {
          final task = _dummyTasks[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12.0),
            child: CheckboxListTile(
              title: Text(
                task.description,
                style: TextStyle(
                  decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
              value: task.isCompleted,
              onChanged: (bool? value) {
                setState(() {
                  task.isCompleted = value!;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
