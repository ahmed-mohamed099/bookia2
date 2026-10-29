import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookia/core/widgets/auth_widgets.dart';
import 'package:bookia/features/profile/data/models/user_model.dart';
import 'package:bookia/features/profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:bookia/features/profile/presentation/cubit/submit_state.dart';
import 'package:bookia/features/profile/presentation/widgets/profile_avatar.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Fields start filled with the user's current data.
  late final _name = TextEditingController(text: widget.user.name);
  late final _phone = TextEditingController(text: widget.user.phone ?? '');
  late final _city = TextEditingController(text: widget.user.city ?? '');
  late final _address = TextEditingController(text: widget.user.address ?? '');

  @override
  void dispose() {
    for (final c in [_name, _phone, _city, _address]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditProfileCubit(),
      child: BlocConsumer<EditProfileCubit, SubmitState>(
        listener: (context, state) {
          if (state is SubmitError) showError(context, state.message);
          if (state is SubmitSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Profile updated')));
            Navigator.pop(context, true);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: kBg,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(children: [
                  SizedBox(height: 12.h),
                  Row(children: [
                    const AuthBackButton(),
                    Expanded(
                      child: Center(
                        child: Text('Edit Profile',
                            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    SizedBox(width: 41.w),
                  ]),
                  Expanded(
                    child: ListView(children: [
                      SizedBox(height: 30.h),
                      Center(
                        child: Stack(children: [
                          ProfileAvatar(image: widget.user.image, size: 110.r),
                          Positioned(
                            right: 2,
                            bottom: 4,
                            child: CircleAvatar(
                              radius: 13.r,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.camera_alt_outlined, size: 15.sp, color: kGold),
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(height: 32.h),
                      AuthField(controller: _name, hint: 'Full Name'),
                      SizedBox(height: 10.h),
                      AuthField(controller: _phone, hint: 'Phone', keyboardType: TextInputType.phone),
                      SizedBox(height: 10.h),
                      AuthField(controller: _city, hint: 'City'),
                      SizedBox(height: 10.h),
                      AuthField(controller: _address, hint: 'Address'),
                    ]),
                  ),
                  GoldButton(
                    text: 'Update Profile',
                    loading: state is SubmitLoading,
                    onPressed: () => context.read<EditProfileCubit>().update(
                          name: _name.text,
                          phone: _phone.text,
                          city: _city.text,
                          address: _address.text,
                        ),
                  ),
                  SizedBox(height: 16.h),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
