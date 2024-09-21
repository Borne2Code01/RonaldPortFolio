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
            'Ronald A. Dela Cruz',
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
          const Text(
            'Flutter Developer',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white70,
              fontFamily: 'Roboto',
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
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
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
              fontFamily: 'Roboto',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'I am a Flutter developer with experience in building beautiful, scalable, and efficient mobile and web applications.',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontFamily: 'Roboto',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/about'),
            child: const Text(
              'Learn More',
              style: TextStyle(
                fontFamily: 'Roboto',
              ),
            ),
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
      'description':
          'Experienced in crafting highly responsive and scalable cross-platform applications using Flutter and Dart. Capable of building intuitive, performant, and visually engaging mobile and web interfaces with native-like experiences across both Android and iOS. Expert in leveraging Flutter’s widget tree for smooth animations and efficient UI updates.'
    },
    {
      'name': 'State Management',
      'description':
          'Proficient in managing state across complex applications using industry-standard tools such as Provider and Riverpod. Skilled in structuring scalable architectures that ensure clean, maintainable codebases, supporting both small-scale and enterprise-level apps.'
    },
    {
      'name': 'Firebase',
      'description':
          'Well-versed in integrating Firebase for backend services, including authentication, Firestore, real-time database, cloud functions, and push notifications. Adept at creating secure, dynamic applications with seamless cloud integration, leveraging Firebase for real-time syncing and scalable back-end solutions.'
    },
    {
      'name': 'REST APIs',
      'description':
          'Experienced in building applications that consume RESTful web services to enable communication between frontend interfaces and backend servers. Strong understanding of HTTP requests, error handling, and parsing JSON data into Flutter models to build robust, data-driven applications.'
    },
    {
      'name': 'UI/UX Design',
      'description':
          'Focused on delivering user-centric designs with attention to UI/UX principles. Able to translate designs into highly functional, visually appealing layouts. Skilled in leveraging Flutter’s Material Design and Cupertino widgets, ensuring seamless navigation, responsive layouts, and smooth animations for superior user experience.'
    },
    {
      'name': 'Version Control & Collaboration',
      'description':
          'Proficient in using Git for version control and collaborating with teams via platforms like GitHub. Familiar with CI/CD pipelines for automated testing and deployment, ensuring high-quality code and smooth releases.'
    },
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
              fontFamily: 'Roboto',
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
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                        ),
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
              fontFamily: 'Roboto',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Email: johndoe@example.com',
            style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontFamily: 'Roboto'),
          ),
          const SizedBox(height: 5),
          Text(
            'LinkedIn: linkedin.com/in/johndoe',
            style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontFamily: 'Roboto'),
          ),
          const SizedBox(height: 5),
          Text(
            'GitHub: github.com/johndoe',
            style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontFamily: 'Roboto'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/contact'),
            child: const Text(
              'Get in Touch',
              style: TextStyle(
                fontFamily: 'Roboto',
              ),
            ),
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
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'I am a passionate Flutter developer with experience in building high-quality mobile and web applications.',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontFamily: 'Roboto',
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
                fontFamily: 'Roboto',
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
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Feel free to reach out to me via email or connect with me on LinkedIn.',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontFamily: 'Roboto',
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
        title: Text(
          skillName,
          style: const TextStyle(
            fontFamily: 'Roboto',
          ),
        ),
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
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              skillDescription,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
