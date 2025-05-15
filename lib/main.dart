import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart'; // Asegurate de crear esta o una pantalla placeholder

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Celiak',
      initialRoute: '/', // Ruta inicial
      routes: {
        '/': (context) => SplashScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/home': (context) => HomeScreen(), // Esta puede ser una pantalla vacía por ahora
      },
    );
  }
}


