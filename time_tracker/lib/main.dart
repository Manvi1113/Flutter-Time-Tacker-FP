import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import 'providers/project_task_provider.dart'; // Adjusting to include your provider
import 'providers/time_entry_provider.dart'; // Adjusting to include your provider
import 'screens/add_time_entry_screen.dart'; // Adjusting to include your screens
import 'screens/home_screen.dart';
import 'screens/project_task_management_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  runApp(MyApp(localStorage: localStorage));
}

class MyApp extends StatelessWidget {
  final LocalStorage localStorage;

  const MyApp({Key? key, required this.localStorage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProjectTaskProvider(localStorage)),
        ChangeNotifierProvider(create: (_) => TimeEntryProvider(localStorage)),
      ],
      child: MaterialApp(
        title: 'Time Tracker', // Change the title to match your app
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(), // Main entry point, HomeScreen
          '/manage_projects_tasks': (context) => ProjectTaskManagementScreen(), // Route for managing projects and tasks
          '/add_time_entry': (context) => AddTimeEntryScreen(), // Route for adding time entries
        },
      ),
    );
  }
}
