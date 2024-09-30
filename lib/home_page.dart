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
            backgroundImage: AssetImage('assets/images/profilepic.jpg'),
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
            'Senior Flutter Developer',
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
                    return SkillsPage();
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
            '''I am Ronald A. Dela Cruz, a Junior Flutter Developer with extensive experience in building mobile and web applications for both Android and iOS. My career objective is to secure a responsible position with a progressive firm that will utilize my skills and experience while providing growth opportunities.''',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontFamily: 'Roboto',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '''Personal Info:
Nationality: Filipino
Height: 5’8"
Weight: 140 lbs
Location: Me Aplaya del Sol St., Julugan 1, Tanza, Cavite (4108)
Mobile: 09055935273 (Globe) / 09304895819 (Smart)''',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontFamily: 'Roboto',
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
          'Expert in Flutter and Dart for creating cross-platform mobile applications with performance optimization.'
    },
    {
      'name': 'State Management',
      'description':
          'Proficient with state management solutions like Provider and Riverpod.'
    },
    {
      'name': 'API Integration',
      'description':
          'Skilled in integrating RESTful APIs into Flutter apps for smooth communication with servers.'
    },
    {
      'name': 'UI/UX Design',
      'description':
          'Focused on delivering intuitive and user-friendly UI/UX designs.'
    },
    {
      'name': 'Version Control (Git)',
      'description':
          'Experienced in version control with Git and collaborating on platforms like GitHub.'
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
            'Email: boedelacruz@gmail.com',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontFamily: 'Roboto',
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'LinkedIn: linkedin.com/in/ronald-dela-cruz-5b72a7319',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontFamily: 'Roboto',
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Mobile: 09055935273 (Globe) / 09304895819 (Smart)',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }
}

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
              '''I am a passionate Flutter developer with extensive experience in creating high-quality mobile and web applications for both Android and iOS platforms. With my skills in Dart and Flutter, I focus on building efficient, scalable, and visually appealing applications that provide excellent user experiences.''',
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
  SkillsPage({super.key});

  final List<Map<String, String>> skills = [
    {
      'name': 'Flutter & Dart',
      'description':
          'Expert in Flutter and Dart for creating cross-platform mobile applications with performance optimization. Developed multiple successful projects, including an e-commerce app and a social media platform that achieved over 10,000 downloads.'
    },
    {
      'name': 'State Management',
      'description':
          'Proficient with state management solutions like Provider, Riverpod, and GetX, enabling efficient data flow and state management in complex applications.'
    },
    {
      'name': 'API Integration',
      'description':
          'Skilled in integrating RESTful APIs and GraphQL into Flutter apps, ensuring robust data handling and real-time updates for seamless user experiences.'
    },
    {
      'name': 'UI/UX Design',
      'description':
          'Focused on delivering intuitive and user-friendly UI/UX designs, employing Material Design principles and custom animations to enhance user engagement.'
    },
    {
      'name': 'Version Control (Git)',
      'description':
          'Experienced in version control with Git, utilizing GitHub for collaboration, code reviews, and managing contributions in team projects.'
    },
    {
      'name': 'Testing and Debugging',
      'description':
          'Proficient in writing unit and integration tests using Flutter\'s testing framework, ensuring high code quality and reliability through continuous testing.'
    },
    {
      'name': 'Firebase',
      'description':
          'Knowledgeable in using Firebase for backend services, including authentication, Firestore databases, and Cloud Functions, facilitating real-time data sync and storage.'
    },
    {
      'name': 'Responsive Web Design',
      'description':
          'Experienced in developing responsive web applications using Flutter Web, ensuring optimal performance and user experiences across various screen sizes.'
    },
    {
      'name': 'Agile Development',
      'description':
          'Familiar with Agile methodologies and tools like Jira, facilitating iterative development and fostering collaboration within cross-functional teams.'
    },
  ];

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
            Expanded(
              child: ListView.builder(
                itemCount: skills.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            skills[index]['name']!,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            skills[index]['description']!,
                            style: TextStyle(
                              fontSize: 16,
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
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
