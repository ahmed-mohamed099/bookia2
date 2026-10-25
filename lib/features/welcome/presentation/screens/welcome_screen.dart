import 'package:flutter/material.dart';
import 'package:bookia/features/auth/presentation/screens/login_screen.dart';
import 'package:bookia/features/auth/presentation/screens/register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const Color gold = Color(0xFFC5A451);
  static const Color dark = Color(0xFF292929);

  void _go(BuildContext context, Widget page) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => page));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/c133ce1a81ff5d4f839063aed5c3705ca8c0781c.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(children: [
              const SizedBox(height: 100),
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.menu_book_rounded, color: gold, size: 48),
                SizedBox(width: 8),
                Text('Bookia', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: dark)),
              ]),
              const SizedBox(height: 16),
              const Text('Order Your Book Now!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: dark)),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () => _go(context, const LoginScreen()),
                  style: ElevatedButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.white),
                  child: const Text('Login'),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: OutlinedButton(
                  onPressed: () => _go(context, const RegisterScreen()),
                  style: OutlinedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: dark),
                  child: const Text('Register'),
                ),
              ),
              const SizedBox(height: 50),
            ]),
          ),
        ),
      ),
    );
  }
}