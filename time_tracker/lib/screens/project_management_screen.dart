import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/project.dart'; // Import your Project model
import '../providers/time_entry_provider.dart'; // Import your TimeEntryProvider
import '../widgets/add_project_dialog.dart'; // Import the AddProjectDialog

class ProjectManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Projects"),
        backgroundColor: Colors.deepPurple, // Themed color
        foregroundColor: Colors.white,
      ),
      body: Consumer<TimeEntryProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.projects.length,
            itemBuilder: (context, index) {
              final project = provider.projects[index];
              return ListTile(
                title: Text(project.name),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Optionally, show a confirmation dialog before deletion
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Confirm Deletion'),
                        content: Text('Are you sure you want to delete this project?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(), // Close the dialog
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              provider.deleteProject(project.id); // Call the provider to delete
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddProjectDialog(
              onAdd: (newProject) {
                Provider.of<TimeEntryProvider>(context, listen: false)
                    .addOrUpdateProject(newProject); // Call provider to add project
                Navigator.pop(context); // Close the dialog
              },
            ),
          );
        },
        tooltip: 'Add New Project',
        child: Icon(Icons.add),
      ),
    );
  }
}
