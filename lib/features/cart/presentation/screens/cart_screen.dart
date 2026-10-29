import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookia/core/widgets/auth_widgets.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:bookia/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:bookia/features/checkout/presentation/screens/place_order_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F6F8),
        centerTitle: true,
        title: Text('My Cart', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600)),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CartError) {
            return Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(state.message),
                TextButton(
                  onPressed: () => context.read<CartCubit>().getCart(),
                  child: const Text('Try again'),
                ),
              ]),
            );
          }
          final cart = (state as CartLoaded).cart;
          if (cart.items.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }
          return Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(children: [
              Expanded(
                child: ListView.separated(
                  itemCount: cart.items.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (context, i) => CartItemCard(item: cart.items[i]),
                ),
              ),
              SizedBox(height: 10.h),
              Row(children: [
                Text('Total:', style: TextStyle(fontSize: 16.sp, color: kHint)),
                const Spacer(),
                Text('${cart.total.toStringAsFixed(2)} EGP',
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
              ]),
              SizedBox(height: 12.h),
              GoldButton(
                text: 'Checkout',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PlaceOrderScreen(total: cart.total)),
                ),
              ),
            ]),
          );
        },
      ),
    );
  }
}
