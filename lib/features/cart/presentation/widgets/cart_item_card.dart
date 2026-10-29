import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookia/core/widgets/auth_widgets.dart';
import 'package:bookia/features/cart/data/models/cart_model.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel item;

  const CartItemCard({super.key, required this.item});

  Future<void> _run(BuildContext context, Future<String?> action) async {
    final error = await action;
    if (error != null && context.mounted) showError(context, error);
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(padding: EdgeInsets.all(4.r), child: Icon(icon, size: 18.sp)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6.r),
          child: Image.network(item.image, width: 70.w, height: 90.h, fit: BoxFit.cover),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(
                child: Text(item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
              ),
              InkWell(
                onTap: () => _run(context, cubit.remove(item)),
                child: Icon(Icons.highlight_off, size: 20.sp),
              ),
            ]),
            SizedBox(height: 4.h),
            Text('${item.price} EGP', style: TextStyle(fontSize: 12.sp, color: kHint)),
            SizedBox(height: 14.h),
            Row(children: [
              _qtyButton(Icons.add, () => _run(context, cubit.changeQuantity(item, item.quantity + 1))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(item.quantity.toString().padLeft(2, '0'), style: TextStyle(fontSize: 14.sp)),
              ),
              _qtyButton(Icons.remove, () => _run(context, cubit.changeQuantity(item, item.quantity - 1))),
              const Spacer(),
              Text('${item.total.toStringAsFixed(2)} EGP', style: TextStyle(fontSize: 13.sp)),
            ]),
          ]),
        ),
      ]),
    );
  }
}
