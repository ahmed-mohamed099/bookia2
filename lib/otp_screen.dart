import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/widgets/auth_widgets.dart';
import 'new_password_screen.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, required this.email});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _c = List.generate(6, (_) => TextEditingController());
  final _f = List.generate(6, (_) => FocusNode());
  String get _code => _c.map((e) => e.text).join();

  void _verify() {
    if (_code.length < 6) {
      showError(context, 'اكتب الكود كامل');
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => NewPasswordScreen(code: _code)));
  }

  Widget _box(int i) => SizedBox(
    width: 48.w,
    child: TextField(
      controller: _c[i], focusNode: _f[i], maxLength: 1,
      textAlign: TextAlign.center, keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
      decoration: const InputDecoration(counterText: '', filled: true, fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: kBorder)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: kGold))),
      onChanged: (v) {
        if (v.isNotEmpty && i < 5) _f[i + 1].requestFocus();
        if (v.isEmpty && i > 0) _f[i - 1].requestFocus();
      },
    ),
  );

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
            Text('OTP Verification', style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 10.h),
            Text('Enter the verification code we just sent on your email address.',
                style: TextStyle(fontSize: 16.sp, color: kHint)),
            SizedBox(height: 32.h),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: List.generate(6, _box)),
            SizedBox(height: 38.h),
            GoldButton(text: 'Verify', onPressed: _verify),
          ]),
        ),
      ),
    );
  }
}