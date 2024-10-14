import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/project.dart';
import '../models/task.dart';
import '../providers/project_task_provider.dart';
import '../widgets/add_task_dialog.dart'; // Assuming you have a dialog for adding tasks

class ProjectTaskManagementScreen extends StatefulWidget {
  @override
  _ProjectTaskManagementScreenState createState() => _ProjectTaskManagementScreenState();
}

class _ProjectTaskManagementScreenState extends State<ProjectTaskManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  String projectName = '';
  String taskName = '';
  String taskDescription = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Projects and Tasks'),
      ),
      body: Consumer<ProjectTaskProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: provider.projects.length,
                  itemBuilder: (context, index) {
                    final project = provider.projects[index];
                    return ExpansionTile(
                      title: Text(project.name),
                      children: provider.tasks
                          .where((task) => task.projectId == project.id) // Assuming Task has a projectId property
                          .map((task) => ListTile(
                                title: Text(task.name),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    _confirmDeleteTask(context, task.id);
                                  },
                                ),
                              ))
                          .toList(),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _showAddProjectTaskDialog(context);
                },
                child: Text('Add Project/Task'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showAddProjectTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Project/Task'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Project Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a project name';
                    }
                    return null;
                  },
                  onSaved: (value) => projectName = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Task Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task name';
                    }
                    return null;
                  },
                  onSaved: (value) => taskName = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Task Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task description';
                    }
                    return null;
                  },
                  onSaved: (value) => taskDescription = value!,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Add project
                  if (projectName.isNotEmpty) {
                    Provider.of<ProjectTaskProvider>(context, listen: false)
                        .addProject(Project(id: DateTime.now().toString(), name: projectName));
                  }
                  // Add task
                  if (taskName.isNotEmpty) {
                    Provider.of<ProjectTaskProvider>(context, listen: false)
                        .addTask(Task(id: DateTime.now().toString(), name: taskName, description: taskDescription, projectId: projectName)); // Assuming Task model has projectId
                  }
                  Navigator.of(context).pop();
                }
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteTask(BuildContext context, String taskId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<ProjectTaskProvider>(context, listen: false).deleteTask(taskId);
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
