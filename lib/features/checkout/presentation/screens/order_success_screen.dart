import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookia/core/widgets/auth_widgets.dart';
import 'package:bookia/features/layout/main_layout.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircleAvatar(
            radius: 50.r,
            backgroundColor: const Color(0xFF1DBF73),
            child: Icon(Icons.check, color: Colors.white, size: 56.sp),
          ),
          SizedBox(height: 30.h),
          Text('SUCCESS!', style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w600)),
          SizedBox(height: 10.h),
          Text(
            'Your order will be delivered soon.\nThank you for choosing our app!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.sp, color: kHint, height: 1.5),
          ),
          SizedBox(height: 30.h),
          GoldButton(
            text: 'Back To Home',
            onPressed: () {
              MainLayout.currentTab.value = 0; // open the Home tab
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ]),
      ),
    );
  }
}
