import 'package:flutter/material.dart';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  PortfolioHomePageState createState() => PortfolioHomePageState();
}

class PortfolioHomePageState extends State<PortfolioHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Portfolio'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: FadeTransition(
          opacity: _controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderSection(),
              const AboutSection(),
              SkillsSection(),
              const ContactSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/avatar.jpg'),
          ),
          const SizedBox(height: 20),
          const Text(
            'John Doe',
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Flutter Developer',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildAnimatedButton(context, 'About Me', '/about'),
              const SizedBox(width: 10),
              _buildAnimatedButton(context, 'Skills', '/skills'),
              const SizedBox(width: 10),
              _buildAnimatedButton(context, 'Contact', '/contact'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedButton(BuildContext context, String text, String route) {
    return TweenAnimationBuilder(
      tween: ColorTween(
        begin: Theme.of(context).primaryColor.withOpacity(0.6),
        end: Theme.of(context).colorScheme.secondary,
      ),
      duration: const Duration(milliseconds: 300),
      builder: (context, Color? color, child) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
          ),
          onPressed: () => Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                switch (route) {
                  case '/about':
                    return const AboutPage();
                  case '/skills':
                    return const SkillsPage();
                  case '/contact':
                    return const ContactPage();
                  default:
                    return const PortfolioHomePage();
                }
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          ),
          child: Text(text),
        );
      },
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Me',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'I am a Flutter developer with experience in building beautiful, scalable, and efficient mobile and web applications.',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/about'),
            child: const Text('Learn More'),
          ),
        ],
      ),
    );
  }
}

class SkillsSection extends StatelessWidget {
  final List<Map<String, String>> skills = [
    {
      'name': 'Flutter & Dart',
      'description': 'Cross-platform app development.'
    },
    {'name': 'Firebase', 'description': 'Backend as a service.'},
    {'name': 'REST APIs', 'description': 'Interfacing with web services.'},
    {'name': 'State Management', 'description': 'Provider, Riverpod.'},
    {'name': 'UI/UX Design', 'description': 'Creating intuitive interfaces.'},
  ];

  SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skills',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: skills
                .map((skill) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SkillDetailPage(
                              skillName: skill['name']!,
                              skillDescription: skill['description']!,
                            ),
                          ),
                        );
                      },
                      child: Chip(
                        label: Text(skill['name']!),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        labelStyle: const TextStyle(color: Colors.black),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Email: johndoe@example.com',
            style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge?.color),
          ),
          const SizedBox(height: 5),
          Text(
            'LinkedIn: linkedin.com/in/johndoe',
            style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge?.color),
          ),
          const SizedBox(height: 5),
          Text(
            'GitHub: github.com/johndoe',
            style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge?.color),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/contact'),
            child: const Text('Get in Touch'),
          ),
        ],
      ),
    );
  }
}

// Sample pages

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Me'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Me - Full Details',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'I am a passionate Flutter developer with experience in building high-quality mobile and web applications.',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skills'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Skills',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 10),
            // Repeat the skills list here
          ],
        ),
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get in Touch',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Feel free to reach out to me via email or connect with me on LinkedIn.',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Skill Detail Page
class SkillDetailPage extends StatelessWidget {
  final String skillName;
  final String skillDescription;

  const SkillDetailPage({
    super.key,
    required this.skillName,
    required this.skillDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(skillName),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              skillName,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              skillDescription,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
