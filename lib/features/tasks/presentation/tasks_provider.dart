import 'package:flutter/material.dart';

import 'package:habits_app/features/tasks/data/tasks_repository.dart';
import 'package:habits_app/features/tasks/domain/task.dart';

class TasksProvider with ChangeNotifier {
  final TasksRepository _tasksRepository = TasksRepository();
  List<Task> _tasks = [];
  bool _isLoading = false;
  TaskType _selectedFilter = TaskType.DAILY;
  DateTime _selectedDate = DateTime.now();

  List<Task> get tasks => _tasks.where((task) {
    if (task.type != _selectedFilter) return false;
    // For DAILY tasks, we might want to show them every day or check specific logic.
    // For now, assuming all tasks are relevant to the selected date if they match the type.
    // In a real app, we'd check if the task is assigned to this date.
    return true;
  }).toList();

  bool get isLoading => _isLoading;
  TaskType get selectedFilter => _selectedFilter;
  DateTime get selectedDate => _selectedDate;

  void setFilter(TaskType filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  Future<void> fetchTasks() async {
    _isLoading = true;
    notifyListeners();
    try {
      _tasks = await _tasksRepository.getTasks();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTask(Task task) async {
    try {
      final newTask = await _tasksRepository.createTask(task);
      _tasks.add(newTask);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> toggleTaskCompletion(Task task) async {
    final updatedTask = Task(
      id: task.id,
      title: task.title,
      description: task.description,
      type: task.type,
      isCompleted: !task.isCompleted,
      specificTime: task.specificTime,
      priority: task.priority,
      userId: task.userId,
    );

    try {
      await _tasksRepository.updateTask(updatedTask);
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = updatedTask;
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await _tasksRepository.deleteTask(id);
      _tasks.removeWhere((t) => t.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
