import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:bookia/features/home/presentation/widgets/home_slider.dart';
import 'package:bookia/features/home/presentation/widgets/product_card.dart';
import 'package:bookia/features/search/presentation/screens/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..getHomeData(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF8F8F8),
          title: Row(children: [
            const Icon(Icons.menu_book_rounded, color: Color(0xFFBFA05A)),
            SizedBox(width: 6.w),
            Text('Bookia', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold)),
          ]),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              ),
            ),
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HomeError) {
              return Center(child: Text(state.message));
            }
            final data = state as HomeSuccess;
            return ListView(
              padding: EdgeInsets.all(16.r),
              children: [
                HomeSlider(sliders: data.sliders),
                SizedBox(height: 24.h),
                Text('Best Seller', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 14.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.h,
                    crossAxisSpacing: 12.w,
                    childAspectRatio: 0.62,
                  ),
                  itemBuilder: (context, i) => ProductCard(product: data.products[i]),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}