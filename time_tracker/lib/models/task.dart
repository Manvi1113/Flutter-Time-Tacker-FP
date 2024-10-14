class Task {
  final String id;
  final String name;
  final String description;
  final String projectId; // Add this line for project association

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.projectId, // Make this required
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      projectId: json['projectId'], // Make sure to parse projectId
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'projectId': projectId, // Add projectId to JSON
    };
  }
}
