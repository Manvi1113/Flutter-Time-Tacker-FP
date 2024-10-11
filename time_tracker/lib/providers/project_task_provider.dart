import 'package:flutter/foundation.dart';
import '../models/project.dart';
import '../models/task.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';

class ProjectTaskProvider with ChangeNotifier {
  final LocalStorage localStorage;
  List<Project> _projects = [];
  List<Task> _tasks = [];

  List<Project> get projects => _projects;
  List<Task> get tasks => _tasks;

  ProjectTaskProvider(this.localStorage) {
    _loadProjectsFromStorage();
    _loadTasksFromStorage();
  }

  // Load projects from local storage
  void _loadProjectsFromStorage() async {
    var storedProjects = localStorage.getItem('projects');
    if (storedProjects != null) {
      _projects = List<Project>.from(
        (storedProjects as List).map((item) => Project.fromJson(item)),
      );
      notifyListeners();
    }
  }

  // Load tasks from local storage
  void _loadTasksFromStorage() async {
    var storedTasks = localStorage.getItem('tasks');
    if (storedTasks != null) {
      _tasks = List<Task>.from(
        (storedTasks as List).map((item) => Task.fromJson(item)),
      );
      notifyListeners();
    }
  }

  // Add a new project
  void addProject(Project project) {
    _projects.add(project);
    _saveProjectsToStorage();
    notifyListeners();
  }

  // Save projects to local storage
  void _saveProjectsToStorage() {
    localStorage.setItem('projects', jsonEncode(_projects.map((e) => e.toJson()).toList()));
  }

  // Remove a project by ID
  void removeProject(String id) {
    _projects.removeWhere((project) => project.id == id);
    _saveProjectsToStorage();
    notifyListeners();
  }

  // Add a new task
  void addTask(Task task) {
    _tasks.add(task);
    _saveTasksToStorage();
    notifyListeners();
  }

  // Save tasks to local storage
  void _saveTasksToStorage() {
    localStorage.setItem('tasks', jsonEncode(_tasks.map((e) => e.toJson()).toList()));
  }

  // Remove a task by ID
  void removeTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    _saveTasksToStorage();
    notifyListeners();
  }

  // Update an existing project
  void updateProject(Project updatedProject) {
    int index = _projects.indexWhere((project) => project.id == updatedProject.id);
    if (index != -1) {
      _projects[index] = updatedProject;
      _saveProjectsToStorage();
      notifyListeners();
    }
  }

  // Update an existing task
  void updateTask(Task updatedTask) {
    int index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      _saveTasksToStorage();
      notifyListeners();
    }
  }
}
