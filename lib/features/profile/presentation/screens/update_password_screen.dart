import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookia/core/widgets/auth_widgets.dart';
import 'package:bookia/features/profile/presentation/cubit/submit_state.dart';
import 'package:bookia/features/profile/presentation/cubit/update_password_cubit.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _current = TextEditingController();
  final _new = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    for (final c in [_current, _new, _confirm]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UpdatePasswordCubit(),
      child: BlocConsumer<UpdatePasswordCubit, SubmitState>(
        listener: (context, state) {
          if (state is SubmitError) showError(context, state.message);
          if (state is SubmitSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Password updated')));
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
                  const Align(alignment: Alignment.centerLeft, child: AuthBackButton()),
                  Expanded(
                    child: ListView(children: [
                      SizedBox(height: 30.h),
                      Center(
                        child: Text('New Password',
                            style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(height: 40.h),
                      AuthField(controller: _current, hint: 'Current Password', isPassword: true),
                      SizedBox(height: 14.h),
                      AuthField(controller: _new, hint: 'New Password', isPassword: true),
                      SizedBox(height: 14.h),
                      AuthField(controller: _confirm, hint: 'Confirm password', isPassword: true),
                    ]),
                  ),
                  GoldButton(
                    text: 'Update Password',
                    loading: state is SubmitLoading,
                    onPressed: () => context.read<UpdatePasswordCubit>().update(
                          current: _current.text,
                          newPassword: _new.text,
                          confirm: _confirm.text,
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
