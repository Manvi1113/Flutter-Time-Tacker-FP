import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/project.dart';
import '../models/task.dart';
import '../providers/project_task_provider.dart';
import '../screens/add_project_task_screen.dart'; // Import the screen for adding projects or tasks
class ProjectTaskManagementScreen extends StatelessWidget {
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
                child: ListView(
                  children: [
                    // Display Projects
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Projects',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...provider.projects.map((project) {
                      return ListTile(
                        title: Text(project.name),
                        onTap: () {
                          // Optionally, you could navigate to a project details screen or edit screen
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Tapped on Project: ${project.name}'),
                            ),
                          );
                        },
                      );
                    }).toList(),
                    
                    // Display Tasks
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Tasks',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...provider.tasks.map((task) {
                      return ListTile(
                        title: Text(task.name),
                        onTap: () {
                          // Optionally, navigate to a task details or edit screen
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Tapped on Task: ${task.name}'),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the screen to add a new project or task
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProjectTaskScreen()),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add Project/Task',
      ),
    );
  }
}