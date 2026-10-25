import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookia/core/widgets/auth_widgets.dart';
import 'package:bookia/features/home/presentation/widgets/product_card.dart';
import 'package:bookia/features/search/presentation/cubit/search_cubit.dart';
import 'package:bookia/features/search/presentation/cubit/search_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6F8),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 12.h),
              const AuthBackButton(),
              SizedBox(height: 20.h),
              Builder(
                builder: (context) => TextField(
                  autofocus: true,
                  onChanged: context.read<SearchCubit>().onTextChanged,
                  decoration: InputDecoration(
                    hintText: 'Search Store',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is SearchError) return Center(child: Text(state.message));
                    if (state is SearchSuccess) {
                      if (state.products.isEmpty) return const Center(child: Text('No results'));
                      return GridView.builder(
                        itemCount: state.products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12.h,
                          crossAxisSpacing: 12.w,
                          childAspectRatio: 0.62,
                        ),
                        itemBuilder: (context, i) => ProductCard(product: state.products[i]),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}