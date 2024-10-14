// lib/dialogs/add_project_dialog.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/project.dart'; // Make sure to import your Project model
import '../providers/time_entry_provider.dart'; // Import your TimeEntryProvider

class AddProjectDialog extends StatefulWidget {
  final Function(Project) onAdd;

  AddProjectDialog({required this.onAdd});

  @override
  _AddProjectDialogState createState() => _AddProjectDialogState();
}

class _AddProjectDialogState extends State<AddProjectDialog> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Project'),
      content: TextField(
        controller: _nameController,
        decoration: InputDecoration(
          labelText: 'Project Name',
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Add'),
          onPressed: () {
            final projectName = _nameController.text;
            if (projectName.isNotEmpty) {
              // Create a new Project object
              var newProject = Project(
                id: DateTime.now().toString(), // Generate a unique ID
                name: projectName,
              );

              // Call the onAdd function passed from the parent widget
              widget.onAdd(newProject);
              
              // Optionally, you can add the project directly to the provider as well
              Provider.of<TimeEntryProvider>(context, listen: false)
                  .addOrUpdateProject(newProject); // Assuming you have a method to add project in TimeEntryProvider

              _nameController.clear(); // Clear the input field
              Navigator.of(context).pop(); // Close the dialog
            } else {
              // Optionally, show an error message if the name is empty
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Project name cannot be empty!')),
              );
            }
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
