import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Profile',
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? darkTheme : lightTheme,
      home: ProfilePage(
        isDarkMode: isDarkMode,
        onThemeToggle: () {
          setState(() => isDarkMode = !isDarkMode);
        },
      ),
    );
  }
}
