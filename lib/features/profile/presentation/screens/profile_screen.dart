import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookia/core/widgets/auth_widgets.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_state.dart';
import 'package:bookia/features/contact/presentation/screens/contact_screen.dart';
import 'package:bookia/features/faq/presentation/screens/faq_screen.dart';
import 'package:bookia/features/layout/main_layout.dart';
import 'package:bookia/features/orders/presentation/screens/orders_screen.dart';
import 'package:bookia/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:bookia/features/profile/presentation/screens/privacy_screen.dart';
import 'package:bookia/features/profile/presentation/screens/update_password_screen.dart';
import 'package:bookia/features/profile/presentation/widgets/profile_avatar.dart';
import 'package:bookia/features/profile/presentation/widgets/profile_menu_item.dart';
import 'package:bookia/features/welcome/presentation/screens/welcome_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..getProfile(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  Future<void> _logout(BuildContext context) async {
    await context.read<ProfileCubit>().logout();
    MainLayout.currentTab.value = 0; // next login opens on Home
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      (route) => false,
    );
  }

  /// Opens a page, then reloads the profile when the user comes back.
  Future<void> _open(BuildContext context, Widget page) async {
    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
    if (changed == true && context.mounted) {
      context.read<ProfileCubit>().getProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: kBg,
        centerTitle: true,
        title: Text('Profile', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600)),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: () => _logout(context)),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProfileError) {
            return Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(state.message),
                TextButton(
                  onPressed: () => context.read<ProfileCubit>().getProfile(),
                  child: const Text('Try again'),
                ),
              ]),
            );
          }
          final user = (state as ProfileLoaded).user;
          return ListView(
            padding: EdgeInsets.all(16.r),
            children: [
              Row(children: [
                ProfileAvatar(image: user.image, size: 64.r),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(user.name, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
                    SizedBox(height: 4.h),
                    Text(user.email, style: TextStyle(fontSize: 13.sp, color: kHint)),
                  ]),
                ),
              ]),
              SizedBox(height: 24.h),
              ProfileMenuItem(
                title: 'My Orders',
                onTap: () => _open(context, const OrdersScreen()),
              ),
              ProfileMenuItem(
                title: 'Edit Profile',
                onTap: () => _open(context, EditProfileScreen(user: user)),
              ),
              ProfileMenuItem(
                title: 'Reset Password',
                onTap: () => _open(context, const UpdatePasswordScreen()),
              ),
              ProfileMenuItem(title: 'FAQ', onTap: () => _open(context, const FaqScreen())),
              ProfileMenuItem(
                title: 'Contact Us',
                onTap: () => _open(context, ContactScreen(name: user.name, email: user.email)),
              ),
              ProfileMenuItem(
                title: 'Privacy & Terms',
                onTap: () => _open(context, const PrivacyScreen()),
              ),
            ],
          );
        },
      ),
    );
  }
}
