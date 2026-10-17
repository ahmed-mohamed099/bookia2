import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class HomeScreen extends StatelessWidget {
const HomeScreen({super.key});

static const Color gold = Color(0xFFC5A451);
static const Color dark = Color(0xFF292929);

@override
Widget build(BuildContext context) {
return Scaffold(
body: Container(
width: double.infinity,
decoration: const BoxDecoration(
image: DecorationImage(
image: AssetImage(
'assets/images/c133ce1a81ff5d4f839063aed5c3705ca8c0781c.jpg',
),
fit: BoxFit.cover,
),
),
child: Container(
decoration: BoxDecoration(
gradient: LinearGradient(
begin: Alignment.topCenter,
end: Alignment.bottomCenter,
colors: [
Colors.white.withValues(alpha: 0.82),
Colors.white.withValues(alpha: 0.05),
const Color(0xFF26364D).withValues(alpha: 0.78),
],
stops: const [0.0, 0.48, 1.0],
),
),
child: SafeArea(
child: Padding(
padding: const EdgeInsets.symmetric(horizontal: 24),
child: Column(
children: [
const SizedBox(height: 100),
const Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(Icons.menu_book_rounded, color: gold, size: 48),
SizedBox(width: 8),
Text(
'Bookia',
style: TextStyle(
fontSize: 40,
fontWeight: FontWeight.bold,
color: dark,
),
),
],
),
const SizedBox(height: 16),
const Text(
'Order Your Book Now!',
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
color: dark,
),
),
const Spacer(),
  SizedBox(
    width: double.infinity,
    height: 60,
    child: ElevatedButton(
      onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => const LoginScreen())),
      style: ElevatedButton.styleFrom(
        backgroundColor: gold,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text('Login'),
    ),
  ),
  const SizedBox(height: 16),
  SizedBox(
    width: double.infinity,
    height: 60,
    child: OutlinedButton(
      onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => const RegisterScreen())),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: dark,
        side: const BorderSide(color: dark),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text('Register'),
    ),
  ),
  const SizedBox(height: 50),
],
),
),
),
),
),
);
}
}