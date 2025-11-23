import 'package:flutter/material.dart';
import 'package:habits_app/features/tasks/domain/task.dart';
import 'package:habits_app/features/tasks/presentation/tasks_provider.dart';
import 'package:provider/provider.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _titleController = TextEditingController();
  final _timeController = TextEditingController();
  TaskType _selectedType = TaskType.DAILY;
  TaskPriority _selectedPriority = TaskPriority.MEDIUM;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Task'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<TaskType>(
              initialValue: _selectedType,
              decoration: const InputDecoration(labelText: 'Type'),
              items: TaskType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.toString().split('.').last),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedType = value!),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<TaskPriority>(
              initialValue: _selectedPriority,
              decoration: const InputDecoration(labelText: 'Priority'),
              items: TaskPriority.values.map((priority) {
                return DropdownMenuItem(
                  value: priority,
                  child: Text(priority.toString().split('.').last),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedPriority = value!),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(
                labelText: 'Time (Optional)',
                hintText: 'e.g. 08:00-10:00',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_titleController.text.isNotEmpty) {
              final newTask = Task(
                id: 0, // Backend assigns ID
                title: _titleController.text,
                type: _selectedType,
                isCompleted: false,
                priority: _selectedPriority,
                specificTime: _timeController.text.isEmpty
                    ? null
                    : _timeController.text,
                userId: 0, // Backend assigns UserID
              );
              Provider.of<TasksProvider>(
                context,
                listen: false,
              ).addTask(newTask);
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
