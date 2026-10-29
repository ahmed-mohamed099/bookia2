import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookia/core/widgets/auth_widgets.dart';
import 'package:bookia/features/faq/presentation/cubit/faq_cubit.dart';
import 'package:bookia/features/faq/presentation/cubit/faq_state.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FaqCubit()..getFaqs(),
      child: Scaffold(
        backgroundColor: kBg,
        appBar: AppBar(backgroundColor: kBg, centerTitle: true, title: const Text('FAQ')),
        body: BlocBuilder<FaqCubit, FaqState>(
          builder: (context, state) {
            if (state is FaqLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is FaqError) return Center(child: Text(state.message));
            final faqs = (state as FaqSuccess).faqs;
            if (faqs.isEmpty) return const Center(child: Text('No questions yet'));
            return ListView.separated(
              padding: EdgeInsets.all(16.r),
              itemCount: faqs.length,
              separatorBuilder: (_, __) => SizedBox(height: 8.h),
              itemBuilder: (context, i) => Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: kBorder),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: ExpansionTile(
                  shape: const Border(),
                  title: Text(faqs[i].question, style: TextStyle(fontSize: 15.sp)),
                  childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 14.h),
                  expandedAlignment: Alignment.centerLeft,
                  children: [
                    Text(faqs[i].answer, style: TextStyle(fontSize: 14.sp, color: kHint)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
