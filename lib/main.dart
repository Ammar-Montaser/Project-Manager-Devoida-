import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_manager/core/theme.dart';
import 'package:project_manager/features/auth/presentation/views/login.dart';
import 'package:project_manager/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getLightThemeData(),
      themeMode: ThemeMode.system,
      title: "Project Management",
      home: loginScreen(),
    );
  }
}
