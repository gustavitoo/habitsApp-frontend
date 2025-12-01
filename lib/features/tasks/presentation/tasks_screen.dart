import 'package:flutter/material.dart';
import 'package:habits_app/features/tasks/presentation/tasks_provider.dart';
import 'package:habits_app/features/tasks/presentation/widgets/add_task_dialog.dart';
import 'package:habits_app/features/tasks/presentation/widgets/date_selector.dart';
import 'package:habits_app/features/tasks/presentation/widgets/filter_toggle.dart';
import 'package:habits_app/features/tasks/presentation/widgets/task_item.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TasksProvider>(context, listen: false).fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Filter Toggle
            Center(
              child: FilterToggle(
                selectedFilter: tasksProvider.selectedFilter,
                onFilterChanged: tasksProvider.setFilter,
              ),
            ),
            const SizedBox(height: 24),
            // Date Selector
            DateSelector(
              selectedDate: tasksProvider.selectedDate,
              onDateSelected: tasksProvider.setDate,
              filter: tasksProvider.selectedFilter,
            ),
            const SizedBox(height: 24),
            // Task List
            Expanded(
              child: tasksProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: tasksProvider.tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasksProvider.tasks[index];
                        return TaskItem(
                          task: task,
                          onToggle: () =>
                              tasksProvider.toggleTaskCompletion(task),
                          onDelete: () => tasksProvider.deleteTask(task.id),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddTaskDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.check_circle_outline),
            label: 'Tasks',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
