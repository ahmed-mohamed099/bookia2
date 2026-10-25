import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookia/features/home/data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFEDEDED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(product.image, width: double.infinity, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${product.priceAfterDiscount} EGP', style: TextStyle(fontSize: 13.sp)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF2F2F2F),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text('Buy', style: TextStyle(color: Colors.white, fontSize: 12.sp)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}