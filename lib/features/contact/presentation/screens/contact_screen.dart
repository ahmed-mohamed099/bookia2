import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookia/core/widgets/auth_widgets.dart';
import 'package:bookia/features/contact/presentation/cubit/contact_cubit.dart';
import 'package:bookia/features/contact/presentation/cubit/contact_state.dart';

class ContactScreen extends StatefulWidget {
  final String name;
  final String email;

  const ContactScreen({super.key, this.name = '', this.email = ''});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late final _name = TextEditingController(text: widget.name);
  late final _email = TextEditingController(text: widget.email);
  final _subject = TextEditingController();
  final _message = TextEditingController();

  @override
  void dispose() {
    for (final c in [_name, _email, _subject, _message]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactCubit(),
      child: BlocConsumer<ContactCubit, ContactState>(
        listener: (context, state) {
          if (state is ContactError) showError(context, state.message);
          if (state is ContactSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Message sent successfully')));
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: kBg,
            appBar: AppBar(backgroundColor: kBg, centerTitle: true, title: const Text('Contact Us')),
            body: ListView(
              padding: EdgeInsets.all(16.r),
              children: [
                AuthField(controller: _name, hint: 'Name'),
                SizedBox(height: 10.h),
                AuthField(controller: _email, hint: 'Email', keyboardType: TextInputType.emailAddress),
                SizedBox(height: 10.h),
                AuthField(controller: _subject, hint: 'Subject'),
                SizedBox(height: 10.h),
                TextField(
                  controller: _message,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Message',
                    hintStyle: const TextStyle(color: kHint),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: kBorder),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: kGold),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                GoldButton(
                  text: 'Send Message',
                  loading: state is ContactLoading,
                  onPressed: () => context.read<ContactCubit>().send(
                        name: _name.text,
                        email: _email.text,
                        subject: _subject.text,
                        message: _message.text,
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
