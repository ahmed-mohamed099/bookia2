import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookia/core/widgets/auth_widgets.dart';
import 'package:bookia/features/auth/presentation/screens/password_changed_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  final String code;
  const NewPasswordScreen({super.key, required this.code});
  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _pass = TextEditingController();
  final _confirm = TextEditingController();

  void _reset() {
    if (_pass.text.length < 8) {
      showError(context, 'Password must be at least 8 characters');
      return;
    }
    if (_pass.text != _confirm.text) {
      showError(context, 'Passwords do not match');
      return;
    }
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const PasswordChangedScreen()), (r) => r.isFirst);
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
            Text('Create new password', style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 10.h),
            Text('Your new password must be unique from those previously used.',
                style: TextStyle(fontSize: 16.sp, color: kHint)),
            SizedBox(height: 32.h),
            AuthField(controller: _pass, hint: 'New Password', isPassword: true),
            SizedBox(height: 12.h),
            AuthField(controller: _confirm, hint: 'Confirm Password', isPassword: true),
            SizedBox(height: 38.h),
            GoldButton(text: 'Reset Password', onPressed: _reset),
          ]),
        ),
      ),
    );
  }
}