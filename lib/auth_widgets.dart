import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kGold = Color(0xFFBFA05A);
const kBg = Color(0xFFF8F8F8);
const kBorder = Color(0xFFE8ECF4);
const kHint = Color(0xFF8391A1);

class AuthField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const AuthField({
    super.key,
    required this.controller,
    required this.hint,
    this.isPassword = false,
    this.keyboardType,
    this.validator,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  late bool _hidden = widget.isPassword;

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: BorderSide(color: color),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _hidden,
      keyboardType: widget.keyboardType,
      validator: widget.validator ??
              (v) => (v == null || v.trim().isEmpty) ? 'مطلوب' : null,
      style: TextStyle(fontSize: 15.sp),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(color: kHint, fontSize: 15.sp),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _hidden ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            color: kHint,
          ),
          onPressed: () => setState(() => _hidden = !_hidden),
        )
            : null,
        enabledBorder: _border(kBorder),
        focusedBorder: _border(kGold),
        errorBorder: _border(Colors.red),
        focusedErrorBorder: _border(Colors.red),
      ),
    );
  }
}

class GoldButton extends StatelessWidget {
  final String text;
  final bool loading;
  final VoidCallback onPressed;

  const GoldButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kGold,
          disabledBackgroundColor: kGold.withValues(alpha: .6),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        ),
        child: loading
            ? SizedBox(
          width: 22.w,
          height: 22.w,
          child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
        )
            : Text(text, style: TextStyle(color: Colors.white, fontSize: 15.sp)),
      ),
    );
  }
}

class AuthBackButton extends StatelessWidget {
  const AuthBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 41.w,
        height: 41.w,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: kBorder),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(Icons.arrow_back_ios_new, size: 16.sp),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback onTap;

  const SocialButton({super.key, required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56.h,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: kBorder),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [icon, SizedBox(width: 10.w), Text(text, style: TextStyle(fontSize: 14.sp))],
        ),
      ),
    );
  }
}

void showError(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(msg), backgroundColor: Colors.red.shade400),
  );
}