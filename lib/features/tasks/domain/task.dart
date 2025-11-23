enum TaskType { DAILY, WEEKLY, MONTHLY }

enum TaskPriority { LOW, MEDIUM, HIGH }

class Task {
  final int id;
  final String title;
  final String? description;
  final TaskType type;
  final bool isCompleted;
  final String? specificTime;
  final TaskPriority priority;
  final int userId;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    required this.isCompleted,
    this.specificTime,
    required this.priority,
    required this.userId,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      type: TaskType.values.firstWhere(
        (e) => e.toString() == 'TaskType.${json['type']}',
      ),
      isCompleted: json['isCompleted'],
      specificTime: json['specificTime'],
      priority: TaskPriority.values.firstWhere(
        (e) => e.toString() == 'TaskPriority.${json['priority']}',
      ),
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'type': type.toString().split('.').last,
      'isCompleted': isCompleted,
      'specificTime': specificTime,
      'priority': priority.toString().split('.').last,
    };
  }
}
