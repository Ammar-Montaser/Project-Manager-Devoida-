import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_manager/core/initDependencies.dart';
import 'package:project_manager/core/theme.dart';
import 'package:project_manager/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:project_manager/features/auth/presentation/views/login.dart';
import 'package:project_manager/features/project/presentation/cubit/project_cubit.dart';
import 'package:project_manager/features/project/presentation/cubit/tasks_cubit.dart';
import 'package:project_manager/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AuthCubit>()),
        BlocProvider(create: (_) => serviceLocator<TasksCubit>()),
        BlocProvider(create: (_) => serviceLocator<ProjectCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getLightThemeData(),
        themeMode: ThemeMode.system,
        title: "Project Management",
        home: loginScreen(),
      ),
    );
  }
}
