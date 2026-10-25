import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/widgets/auth_widgets.dart';
import 'login_screen.dart';

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircleAvatar(
            radius: 50.r,
            backgroundColor: const Color(0xFF35C2A1),
            child: Icon(Icons.check, color: Colors.white, size: 56.sp),
          ),
          SizedBox(height: 35.h),
          Text('Password Changed!', style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600)),
          SizedBox(height: 8.h),
          Text('Your password has been changed\nsuccessfully.',
              textAlign: TextAlign.center, style: TextStyle(fontSize: 15.sp, color: kHint)),
          SizedBox(height: 40.h),
          GoldButton(
            text: 'Back to Login',
            onPressed: () => Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) => const LoginScreen()), (r) => r.isFirst),
          ),
        ]),
      ),
    );
  }
}