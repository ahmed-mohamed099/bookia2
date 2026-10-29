import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookia/core/widgets/auth_widgets.dart';
import 'package:bookia/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:bookia/features/orders/presentation/cubit/orders_state.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrdersCubit()..getOrders(),
      child: Scaffold(
        backgroundColor: kBg,
        appBar: AppBar(backgroundColor: kBg, centerTitle: true, title: const Text('My Orders')),
        body: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            if (state is OrdersLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is OrdersError) return Center(child: Text(state.message));
            final orders = (state as OrdersSuccess).orders;
            if (orders.isEmpty) return const Center(child: Text('You have no orders yet'));
            return ListView.separated(
              padding: EdgeInsets.all(16.r),
              itemCount: orders.length,
              separatorBuilder: (_, __) => SizedBox(height: 10.h),
              itemBuilder: (context, i) {
                final order = orders[i];
                return Container(
                  padding: EdgeInsets.all(14.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: kBorder),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(children: [
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Order #${order.code}',
                            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
                        SizedBox(height: 4.h),
                        Text(order.date, style: TextStyle(fontSize: 13.sp, color: kHint)),
                      ]),
                    ),
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Text('${order.total} EGP', style: TextStyle(fontSize: 14.sp)),
                      SizedBox(height: 4.h),
                      Text(order.status, style: TextStyle(fontSize: 13.sp, color: kGold)),
                    ]),
                  ]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
