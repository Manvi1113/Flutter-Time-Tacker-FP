import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/project.dart'; // Make sure to import your Project model
import '../models/task.dart'; // Make sure to import your Task model
import '../providers/project_task_provider.dart'; // Import your provider

class AddProjectTaskScreen extends StatefulWidget {
  @override
  _AddProjectTaskScreenState createState() => _AddProjectTaskScreenState();
}

class _AddProjectTaskScreenState extends State<AddProjectTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String projectName = '';
  String taskName = '';
  String taskDescription = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Project/Task'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            // Input for Project Name
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
            // Input for Task Name
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
            // Input for Task Description
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
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  // Add project
                  if (projectName.isNotEmpty) {
                    Provider.of<ProjectTaskProvider>(context, listen: false)
                        .addProject(Project(
                      id: DateTime.now().toString(), // Simple ID generation
                      name: projectName,
                    ));
                  }

                  // Add task
                  if (taskName.isNotEmpty) {
                    Provider.of<ProjectTaskProvider>(context, listen: false)
                        .updateTask(Task(
                      id: DateTime.now().toString(), // Simple ID generation
                      name: taskName,
                      description: taskDescription, // Assuming Task has description
                    ));
                  }

                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}