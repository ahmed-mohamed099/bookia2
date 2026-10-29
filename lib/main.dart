import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/welcome/presentation/screens/welcome_screen.dart';

void main() {
  runApp(const BookiaApp());
}

class BookiaApp extends StatelessWidget {
  const BookiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    // CartCubit is above MaterialApp so every page (Home, Search, Cart) shares the same cart.
    return BlocProvider(
      create: (_) => CartCubit(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) => const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: WelcomeScreen(),
        ),
      ),
    );
  }
}
