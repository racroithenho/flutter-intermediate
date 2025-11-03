import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const ProfilePage({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: onThemeToggle,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/poro.jpg'),
              ),
              const SizedBox(height: 12),
              const Text(
                'Tạ Quang Anh',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Mobile Developer',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // --- Skills ---
              Card(
                child: Column(
                  children: const [
                    ListTile(
                      leading: Icon(Icons.code),
                      title: Text('Flutter, Dart, React Native'),
                    ),
                    ListTile(
                      leading: Icon(Icons.storage),
                      title: Text('Firebase, Node.js, MongoDB'),
                    ),
                    ListTile(
                      leading: Icon(Icons.lightbulb),
                      title: Text('UI/UX Design, REST API'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // --- Social Links ---
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.github),
                      title: const Text('GitHub'),
                      subtitle: const Text('github.com/taquanganh'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.linkedin),
                      title: const Text('LinkedIn'),
                      subtitle: const Text('linkedin.com/in/taquanganh'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.envelope),
                      title: const Text('Email'),
                      subtitle: const Text('taquanganh@example.com'),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
