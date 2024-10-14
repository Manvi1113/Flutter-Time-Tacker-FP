import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/time_entry.dart'; // Ensure this model is defined
import '../providers/time_entry_provider.dart';

class AddTimeEntryScreen extends StatelessWidget {
  final TextEditingController projectIdController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController totalTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Time Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: projectIdController,
              decoration: InputDecoration(labelText: 'Project ID'),
            ),
            TextField(
              controller: notesController,
              decoration: InputDecoration(labelText: 'Notes'),
            ),
            TextField(
              controller: totalTimeController,
              decoration: InputDecoration(labelText: 'Total Time (hours)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final String projectId = projectIdController.text;
                final String notes = notesController.text;
                final double totalTime = double.tryParse(totalTimeController.text) ?? 0.0;

                if (projectId.isNotEmpty && notes.isNotEmpty && totalTime > 0) {
                  final newEntry = TimeEntry(
                    id: DateTime.now().toString(), // Generate a unique ID
                    projectId: projectId,
                    notes: notes,
                    totalTime: totalTime,
                    date: DateTime.now(),
                  );

                  Provider.of<TimeEntryProvider>(context, listen: false).addTimeEntry(newEntry);
                  Navigator.pop(context); // Go back after adding the entry
                }
              },
              child: Text('Add Entry'),
            ),
          ],
        ),
      ),
    );
  }
}
