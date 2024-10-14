import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart'; // Import your Task model
import '../providers/time_entry_provider.dart'; // Import your TimeEntryProvider
import '../widgets/add_task_dialog.dart'; // Import the AddTaskDialog

class TaskManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Tasks"),
        backgroundColor: Colors.deepPurple, // Themed color
        foregroundColor: Colors.white,
      ),
      body: Consumer<TimeEntryProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.tasks.length,
            itemBuilder: (context, index) {
              final task = provider.tasks[index];
              return ListTile(
                title: Text(task.name),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Optionally, show a confirmation dialog before deletion
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Confirm Deletion'),
                        content: Text('Are you sure you want to delete this task?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(), // Close the dialog
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              provider.deleteTask(task.id); // Call the provider to delete
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
            builder: (context) => AddTaskDialog(
              onAdd: (newTask) {
                Provider.of<TimeEntryProvider>(context, listen: false)
                    .addOrUpdateTask(newTask); // Call provider to add task
                Navigator.pop(context); // Close the dialog
              },
            ),
          );
        },
        tooltip: 'Add New Task',
        child: Icon(Icons.add),
      ),
    );
  }
}
