import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/time_entry.dart';
import '../providers/time_entry_provider.dart';
import '../screens/add_time_entry_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
        drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: Icon(Icons.category, color: Colors.deepPurple),
              title: Text('Manage Projects and Tasks'),
              onTap: () {
                Navigator.pop(context); // This closes the drawer
                Navigator.pushNamed(context, '/manage_projects_tasks');
              },
            ),
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
