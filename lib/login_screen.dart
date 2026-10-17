import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth_api.dart';
import 'auth_widgets.dart';
import 'register_screen.dart';
import 'main_screen.dart';
import 'forgot_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _loading = false;

  void _go(Widget page) => Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  void _soon() => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('قريبًا')));

  Future<void> _login() async {
    if (!_email.text.contains('@')) return showError(context, 'إيميل غير صحيح');
    setState(() => _loading = true);
    final error = await AuthApi.login(email: _email.text.trim(), password: _pass.text);
    if (!mounted) return;
    setState(() => _loading = false);
    if (error != null) return showError(context, error);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const MainScreen()), (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 12.h),
            const AuthBackButton(),
            SizedBox(height: 28.h),
            Text('Welcome back! Glad\nto see you, Again!', style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 32.h),
            AuthField(controller: _email, hint: 'Enter your email'),
            SizedBox(height: 15.h),
            AuthField(controller: _pass, hint: 'Enter your password', isPassword: true),
            Align(alignment: Alignment.centerRight,
                child: TextButton(onPressed: () => _go(const ForgotScreen()), child: const Text('Forgot Password?'))),
            SizedBox(height: 16.h),
            GoldButton(text: 'Login', loading: _loading, onPressed: _login),
            SizedBox(height: 30.h),
            Center(child: Text('Or', style: TextStyle(color: kHint, fontSize: 14.sp))),
            SizedBox(height: 20.h),
            SocialButton(icon: const Text('G', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)), text: 'Sign in with Google', onTap: _soon),
            SizedBox(height: 15.h),
            SocialButton(icon: const Icon(Icons.apple), text: 'Sign in with Apple', onTap: _soon),
            SizedBox(height: 40.h),
            Center(child: TextButton(onPressed: () => _go(const RegisterScreen()),
                child: const Text("Don't have an account? Register Now", style: TextStyle(color: kGold)))),
          ]),
        ),
      ),
    );
  }
}