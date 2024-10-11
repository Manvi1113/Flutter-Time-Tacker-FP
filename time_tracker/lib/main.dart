import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'providers/project_task_provider.dart';
import 'providers/time_entry_provider.dart';
import 'screens/add_time_entry_screen.dart';
import 'screens/home_screen.dart';
import 'screens/project_task_management_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localStorage = LocalStorage('my_app'); // Make sure to initialize your local storage
  await localStorage.ready; // Wait until local storage is ready

  runApp(MyApp(localStorage: localStorage));
}

class MyApp extends StatelessWidget {
  final LocalStorage localStorage;

  const MyApp({Key? key, required this.localStorage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimeEntryProvider(localStorage)),
        ChangeNotifierProvider(create: (_) => ProjectTaskProvider(localStorage)), // Pass localStorage
      ],
      child: MaterialApp(
        title: 'Time Tracker',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(), // Main entry point, HomeScreen
          '/Manage_Projects_Tasks': (context) => ProjectTaskManagementScreen(), // Corrected class name
        },
      ),
    );
  }
}
