import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(const QuizzyApp());
}

// Pengendali tema global
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

class QuizzyApp extends StatelessWidget {
  const QuizzyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'Quizzy',
          debugShowCheckedModeBanner: false,

          //TEMA TERANG
          theme: ThemeData(
            primaryColor: const Color(0xFF8B5CF6),
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'Poppins',
            useMaterial3: true,
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF8B5CF6),
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Color(0xFF8B5CF6)),
            ),
          ),

          //TEMA GELAP
          darkTheme: ThemeData(
            primaryColor: const Color(0xFF8B5CF6),
            scaffoldBackgroundColor: const Color(0xFF0D0B1A), // Dark Navy
            fontFamily: 'Poppins',
            useMaterial3: true,
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF8B5CF6),
              surface: Color(0xFF1E1B3A),
              onSurface: Colors.white,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF0D0B1A),
              iconTheme: IconThemeData(color: Color(0xFF8B5CF6)),
            ),
          ),

          themeMode: currentMode,
          home: const SplashScreen(),
        );
      },
    );
  }
}
