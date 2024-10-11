import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/time_entry.dart';
import '../providers/time_entry_provider.dart';
import '../screens/add_time_entry_screen.dart'; // Import the AddTimeEntryScreen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Time Entries'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'All Entries'),
              Tab(text: 'Grouped by Project'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // The first tab: List of all entries
            Consumer<TimeEntryProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                  itemCount: provider.entries.length,
                  itemBuilder: (context, index) {
                    final entry = provider.entries[index];
                    return ListTile(
                      title: Text('${entry.projectId} - ${entry.totalTime} hours'),
                      subtitle: Text(
                        '${entry.date.toString()} - Notes: ${entry.notes}',
                      ),
                      onTap: () {
                        // This could open a detailed view or edit screen
                        // For now, we will just show a placeholder
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Tapped on: ${entry.notes}'),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
            // The second tab: Entries grouped by project
            Consumer<TimeEntryProvider>(
              builder: (context, provider, child) {
                // Group entries by projectId
                final Map<String, List<TimeEntry>> groupedEntries = {};
                for (var entry in provider.entries) {
                  if (!groupedEntries.containsKey(entry.projectId)) {
                    groupedEntries[entry.projectId] = [];
                  }
                  groupedEntries[entry.projectId]!.add(entry);
                }

                return ListView.builder(
                  itemCount: groupedEntries.keys.length,
                  itemBuilder: (context, index) {
                    final projectId = groupedEntries.keys.elementAt(index);
                    final entries = groupedEntries[projectId];

                    // Calculate total time for this project
                    double totalTime = entries!.fold(0, (sum, entry) => sum + entry.totalTime);

                    return Card(
                      margin: EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text('$projectId - Total Time: $totalTime hours'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: entries
                              .map((entry) => Text(
                                    '${entry.date.toString()} - Notes: ${entry.notes}',
                                    style: TextStyle(fontSize: 12),
                                  ))
                              .toList(),
                        ),
                        onTap: () {
                          // Placeholder for interaction
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Tapped on project: $projectId'),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigate to the screen to add a new time entry
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTimeEntryScreen()),
            );
          },
          child: Icon(Icons.add),
          tooltip: 'Add Time Entry',
        ),
      ),
    );
  }
}
