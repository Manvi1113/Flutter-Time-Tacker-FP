import 'package:flutter/foundation.dart';
import '../models/project.dart';
import '../models/task.dart';
class ProjectTaskProvider with ChangeNotifier {
    final LocalStorage localStorage; // If you need it, define it here
    ProjectTaskProvider(this.localStorage); // Constructor accepting localStorage
  // List to hold projects
  List<Project> _projects = [];
  // List to hold tasks
  List<Task> _tasks = [];
  // Getter for projects
  List<Project> get projects => _projects;
  // Getter for tasks
  List<Task> get tasks => _tasks;
  // Add a new project
  void addProject(Project project) {
    _projects.add(project);
    notifyListeners(); // Notify listeners about the change
  }
  // Remove a project by ID
  void removeProject(String id) {
    _projects.removeWhere((project) => project.id == id);
    notifyListeners(); // Notify listeners about the change
  }
  // Add a new task
  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners(); // Notify listeners about the change
  }
  // Remove a task by ID
  void removeTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners(); // Notify listeners about the change
  }
  // Update an existing project
  void updateProject(Project updatedProject) {
    int index = _projects.indexWhere((project) => project.id == updatedProject.id);
    if (index != -1) {
      _projects[index] = updatedProject;
      notifyListeners(); // Notify listeners about the change
    }
  }
  // Update an existing task
  void updateTask(Task updatedTask) {
    int index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners(); // Notify listeners about the change
    }
  }
}