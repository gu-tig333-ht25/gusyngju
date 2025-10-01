import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template/providers/todo_provider.dart';
import 'package:template/screens/home.dart';
import 'package:template/api/todo_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load API key from local storage
  final preferences = await SharedPreferences.getInstance();
  String apiKey = preferences.getString("apiKey") ?? "";

  // Create API instance (will call register if needed)
  TodoApi api = TodoApi(apiKey: apiKey);

  runApp(
    ProviderScope(
      overrides: [todoProvider.overrideWith((ref) => ToDoNotifier(api))],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TIG333 TODO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'TIG333 TODO'),
    );
  }
}
