import 'package:flutter/material.dart';
import 'package:ronald_dela_cruz_profolio/home_page.dart';

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
          bodyLarge: TextStyle(color: Colors.white70),
          bodySmall: TextStyle(color: Colors.white60),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: const Color(0xFFBB86FC), // Text color
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
