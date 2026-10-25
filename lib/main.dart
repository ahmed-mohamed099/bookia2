import 'package:bookia/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const BookiaApp());
}

class BookiaApp extends StatelessWidget {
  const BookiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
      ),
    );
  }
}