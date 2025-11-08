import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'presentation/screens/login_screen.dart';

void main() {
  runApp(const HabitsApp());
}

class HabitsApp extends StatelessWidget {
  const HabitsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habits App',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
