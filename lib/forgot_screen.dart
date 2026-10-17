import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth_api.dart';
import 'auth_widgets.dart';
import 'otp_screen.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});
  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final _email = TextEditingController();
  bool _loading = false;

  Future<void> _send() async {
    final email = _email.text.trim();
    if (!email.contains('@')) return showError(context, 'إيميل غير صحيح');
    setState(() => _loading = true);
    final error = await AuthApi.forgotPassword(email);
    if (!mounted) return;
    setState(() => _loading = false);
    if (error != null) return showError(context, error);
    Navigator.push(context, MaterialPageRoute(builder: (_) => OtpScreen(email: email)));
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
            Text('Forgot Password?', style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 10.h),
            Text("Don't worry! It occurs. Please enter the email address linked with your account.",
                style: TextStyle(fontSize: 16.sp, color: kHint)),
            SizedBox(height: 32.h),
            AuthField(controller: _email, hint: 'Enter your email'),
            SizedBox(height: 38.h),
            GoldButton(text: 'Send Code', loading: _loading, onPressed: _send),
          ]),
        ),
      ),
    );
  }
}