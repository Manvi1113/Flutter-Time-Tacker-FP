// lib/dialogs/add_task_dialog.dart
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../models/task.dart'; // Import your Task model
import '../providers/project_task_provider.dart'; // Import your TimeEntryProvider

class AddTaskDialog extends StatefulWidget {
  final Function(Task) onAdd;

  AddTaskDialog({required this.onAdd});

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Task'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: 'Task Name',
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
    final taskName = _controller.text;
    // You should also capture description and projectId from input fields
    if (taskName.isNotEmpty) {
      var newTask = Task(
        id: DateTime.now().toString(), // Generate a unique ID
        name: taskName,
        description: 'Default description', // Replace with real input
        projectId: 'Default projectId', // Replace with real projectId
      );

      // Call the onAdd function passed from the parent widget
      widget.onAdd(newTask);

      // Add it to the provider as well
      Provider.of<ProjectTaskProvider>(context, listen: false)
          .addOrUpdateTask(newTask); // Ensure this method exists

      _controller.clear(); // Clear the input field
      Navigator.of(context).pop(); // Close the dialog
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task name cannot be empty!')),
      );
    }
  },
),

      ],
    );
  } // <-- This closing brace was missing
}
