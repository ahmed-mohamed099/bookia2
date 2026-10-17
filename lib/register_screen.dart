import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth_api.dart';
import 'auth_widgets.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    for (final c in [_name, _email, _password, _confirm]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final error = await AuthApi.register(
      name: _name.text.trim(),
      email: _email.text.trim(),
      password: _password.text,
      passwordConfirmation: _confirm.text,
    );
    if (!mounted) return;
    setState(() => _loading = false);
    if (error != null) return showError(context, error);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إنشاء الحساب')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.h),
                const AuthBackButton(),
                SizedBox(height: 28.h),
                Text(
                  'Hello! Register to get\nstarted',
                  style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600, height: 1.3),
                ),
                SizedBox(height: 32.h),
                AuthField(controller: _name, hint: 'Username'),
                SizedBox(height: 12.h),
                AuthField(
                  controller: _email,
                  hint: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => (v == null || !v.contains('@')) ? 'إيميل غير صحيح' : null,
                ),
                SizedBox(height: 12.h),
                AuthField(
                  controller: _password,
                  hint: 'Password',
                  isPassword: true,
                  validator: (v) => (v == null || v.length < 8) ? 'على الأقل 8 حروف' : null,
                ),
                SizedBox(height: 12.h),
                AuthField(
                  controller: _confirm,
                  hint: 'Confirm password',
                  isPassword: true,
                  validator: (v) => v != _password.text ? 'الباسورد مش متطابق' : null,
                ),
                SizedBox(height: 30.h),
                GoldButton(text: 'Register', loading: _loading, onPressed: _register),
                SizedBox(height: 120.h),
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
                    child: Text.rich(TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(fontSize: 15.sp),
                      children: const [TextSpan(text: 'Login Now', style: TextStyle(color: kGold))],
                    )),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}