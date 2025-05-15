// screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_fadeController);

    _fadeController.forward();

    _startSequence();
  }

  Future<void> _startSequence() async {
    final prefs = await SharedPreferences.getInstance();
    final seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

    // Fade-in
    await Future.delayed(Duration(seconds: 2));

    // Fade-out
    await _fadeController.reverse();

    if (seenOnboarding) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/onboarding');
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF332F14),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Text(
            'APP CELIAK',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
