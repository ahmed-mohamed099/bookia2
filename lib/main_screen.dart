import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'welcome_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text('Bookia'),
        backgroundColor: const Color(0xFFBFA05A),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome to Bookia 📚', style: TextStyle(fontSize: 22)),
      ),
    );
  }
}