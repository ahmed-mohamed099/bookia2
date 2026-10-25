import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookia/features/home/data/models/slider_model.dart';

class HomeSlider extends StatefulWidget {
  final List<SliderModel> sliders;

  const HomeSlider({super.key, required this.sliders});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150.h,
          child: PageView.builder(
            itemCount: widget.sliders.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (context, i) => ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(widget.sliders[i].image, fit: BoxFit.cover),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.sliders.length, (i) {
            final active = i == _current;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              width: active ? 28.w : 7.w,
              height: 7.h,
              decoration: BoxDecoration(
                color: active ? const Color(0xFFBFA05A) : const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(10.r),
              ),
            );
          }),
        ),
      ],
    );
  }
}