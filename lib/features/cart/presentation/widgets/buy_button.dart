import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookia/core/widgets/auth_widgets.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';

/// The black "Buy" button on every book card. Adds the book to the cart.
class BuyButton extends StatefulWidget {
  final int productId;

  const BuyButton({super.key, required this.productId});

  @override
  State<BuyButton> createState() => _BuyButtonState();
}

class _BuyButtonState extends State<BuyButton> {
  bool _loading = false;

  Future<void> _buy() async {
    setState(() => _loading = true);
    final error = await context.read<CartCubit>().addToCart(widget.productId);
    if (!mounted) return;
    setState(() => _loading = false);
    if (error != null) {
      showError(context, error);
      return;
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Added to cart'), duration: Duration(seconds: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _loading ? null : _buy,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: const Color(0xFF2F2F2F),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: _loading
            ? SizedBox(
                width: 14.w,
                height: 14.w,
                child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              )
            : Text('Buy', style: TextStyle(color: Colors.white, fontSize: 12.sp)),
      ),
    );
  }
}
