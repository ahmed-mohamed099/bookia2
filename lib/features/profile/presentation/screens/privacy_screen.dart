import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookia/core/widgets/auth_widgets.dart';

/// The API has no endpoint for this page, so the text lives in the app.
class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  static const _sections = {
    'Your data':
        'We only keep the information you give us (name, email, phone and address) to manage your account and deliver your orders.',
    'Payments':
        'Payment details are handled by our payment provider. Bookia does not store your card information.',
    'Orders':
        'Orders can be cancelled before they are shipped. Prices include any shown discount at the time of ordering.',
    'Your account':
        'You can update your profile or change your password at any time from the Profile page.',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(backgroundColor: kBg, centerTitle: true, title: const Text('Privacy & Terms')),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          for (final entry in _sections.entries) ...[
            Text(entry.key, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 6.h),
            Text(entry.value, style: TextStyle(fontSize: 14.sp, color: kHint, height: 1.5)),
            SizedBox(height: 18.h),
          ],
        ],
      ),
    );
  }
}
