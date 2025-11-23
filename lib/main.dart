import 'package:flutter/material.dart';
import 'package:habits_app/core/theme/app_theme.dart';
import 'package:habits_app/features/auth/presentation/auth_provider.dart';
import 'package:habits_app/features/auth/presentation/login_screen.dart';
import 'package:habits_app/features/tasks/presentation/tasks_provider.dart';
import 'package:habits_app/features/tasks/presentation/tasks_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..checkAuth()),
        ChangeNotifierProvider(create: (_) => TasksProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return MaterialApp(
            title: 'Habits App',
            theme: AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            home: auth.isAuthenticated
                ? const TasksScreen()
                : const LoginScreen(),
          );
        },
      ),
    );
  }
}
