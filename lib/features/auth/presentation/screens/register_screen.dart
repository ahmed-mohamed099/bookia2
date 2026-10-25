import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookia/core/widgets/auth_widgets.dart';
import 'package:bookia/features/auth/data/repo/auth_api.dart';
import 'package:bookia/features/auth/presentation/screens/login_screen.dart';
import 'package:bookia/features/layout/main_layout.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();
  bool _loading = false;

  Future<void> _register() async {
    setState(() => _loading = true);
    final error = await AuthApi.register(
      name: _name.text.trim(),
      email: _email.text.trim(),
      password: _pass.text,
      passwordConfirmation: _confirm.text,
    );
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
            Text('Hello! Register to get\nstarted', style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 32.h),
            AuthField(controller: _name, hint: 'Username'),
            SizedBox(height: 12.h),
            AuthField(controller: _email, hint: 'Email'),
            SizedBox(height: 12.h),
            AuthField(controller: _pass, hint: 'Password', isPassword: true),
            SizedBox(height: 12.h),
            AuthField(controller: _confirm, hint: 'Confirm password', isPassword: true),
            SizedBox(height: 30.h),
            GoldButton(text: 'Register', loading: _loading, onPressed: _register),
            SizedBox(height: 60.h),
            Center(child: TextButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
              child: const Text('Already have an account? Login Now', style: TextStyle(color: kGold)),
            )),
          ]),
        ),
      ),
    );
  }
}