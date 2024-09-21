import 'package:flutter/material.dart';
import 'package:ronald_dela_cruz_portfolio/home_page.dart';

void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF1E1E1E), // Dark background color
        colorScheme: const ColorScheme.dark(
          secondary: Color(0xFFBB86FC), // Purple accent color
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18,
            color: Colors.white70,
          ),
          bodySmall: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            color: Colors.white60,
          ),
          displayLarge: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          displayMedium: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          labelLarge: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black, // Text color
            backgroundColor: const Color(0xFFBB86FC), // Button background color
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PortfolioHomePage(),
        '/about': (context) => const AboutPage(),
        '/skills': (context) => const SkillsPage(),
        '/contact': (context) => const ContactPage(),
      },
    );
  }
}
