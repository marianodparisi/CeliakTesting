import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'APP CELIAK',
      'subtitle': 'BIENVENIDOS',
      'description': 'Aplicación destinada para Celiacos',
    },
    {
      'title': 'PRODUCTOS',
      'subtitle': 'SEGUROS',
      'description': 'Encontrá alimentos aptos fácilmente',
    },
    {
      'title': 'TU PERFIL',
      'subtitle': 'PERSONALIZADO',
      'description': 'Guardá tus preferencias y más',
    },
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      _goToHome();
    }
  }

  void _goToHome() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true); // Guarda que ya lo vio

    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCF7E7),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        page['title']!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF332F14),
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        page['subtitle']!,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF332F14),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        page['description']!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _goToHome,
                  child: Text(
                    'OMITIR',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Row(
                  children: List.generate(
                    _pages.length,
                        (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? Color(0xFF332F14)
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF332F14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                  onPressed: _nextPage,
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
