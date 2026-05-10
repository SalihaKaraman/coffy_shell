import 'package:flutter/material.dart';
import 'package:coffy_shell/screens/welcome_screen.dart';
import 'package:coffy_shell/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoffyShell',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const WelcomeScreen(),
    );
  }
}

