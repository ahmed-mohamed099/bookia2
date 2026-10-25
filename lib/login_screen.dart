import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookia/features/layout/main_layout.dart';
import 'auth_api.dart';
import 'core/widgets/auth_widgets.dart';
import 'register_screen.dart';
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

  Future<void> _login() async {
    setState(() => _loading = true);
    final error = await AuthApi.login(email: _email.text.trim(), password: _pass.text);
    if (!mounted) return;
    setState(() => _loading = false);
    if (error != null) {
      showError(context, error);
      return;
    }
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const MainLayout()), (r) => false);
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
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(onPressed: () => _go(const ForgotScreen()), child: const Text('Forgot Password?')),
            ),
            SizedBox(height: 16.h),
            GoldButton(text: 'Login', loading: _loading, onPressed: _login),
            SizedBox(height: 40.h),
            Center(child: TextButton(
              onPressed: () => _go(const RegisterScreen()),
              child: const Text("Don't have an account? Register Now", style: TextStyle(color: kGold)),
            )),
          ]),
        ),
      ),
    );
  }
}