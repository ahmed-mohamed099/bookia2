import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookia/core/widgets/auth_widgets.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/checkout/presentation/cubit/place_order_cubit.dart';
import 'package:bookia/features/checkout/presentation/cubit/place_order_state.dart';
import 'package:bookia/features/checkout/presentation/screens/order_success_screen.dart';
import 'package:bookia/features/checkout/presentation/widgets/governorate_sheet.dart';

class PlaceOrderScreen extends StatefulWidget {
  final num total;

  const PlaceOrderScreen({super.key, required this.total});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  final _name = TextEditingController();
  final _address = TextEditingController();
  final _phone = TextEditingController();

  @override
  void dispose() {
    for (final c in [_name, _address, _phone]) {
      c.dispose();
    }
    super.dispose();
  }

  /// Fills the form with the user's saved data (only empty fields).
  void _fill(PlaceOrderCubit cubit) {
    final user = cubit.user;
    if (user == null) return;
    if (_name.text.isEmpty) _name.text = user.name;
    if (_address.text.isEmpty) _address.text = user.address ?? '';
    if (_phone.text.isEmpty) _phone.text = user.phone ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlaceOrderCubit()..init(),
      child: BlocConsumer<PlaceOrderCubit, PlaceOrderState>(
        listener: (context, state) {
          final cubit = context.read<PlaceOrderCubit>();
          if (state is PlaceOrderReady) _fill(cubit);
          if (state is PlaceOrderError) showError(context, state.message);
          if (state is PlaceOrderSuccess) {
            context.read<CartCubit>().getCart(); // the cart is empty now
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const OrderSuccessScreen()),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<PlaceOrderCubit>();
          if (state is PlaceOrderLoading) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          return Scaffold(
            backgroundColor: kBg,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(height: 12.h),
                  const AuthBackButton(),
                  Expanded(
                    child: ListView(children: [
                      SizedBox(height: 20.h),
                      Text('Place Your Order',
                          style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600)),
                      SizedBox(height: 8.h),
                      Text('Please enter your delivery details.',
                          style: TextStyle(fontSize: 14.sp, color: kHint)),
                      SizedBox(height: 24.h),
                      AuthField(controller: _name, hint: 'Full Name'),
                      SizedBox(height: 10.h),
                      AuthField(controller: _address, hint: 'Address'),
                      SizedBox(height: 10.h),
                      AuthField(controller: _phone, hint: 'Phone', keyboardType: TextInputType.phone),
                      SizedBox(height: 10.h),
                      InkWell(
                        onTap: () async {
                          final picked = await showGovernorateSheet(context, cubit.governorates);
                          if (picked != null) cubit.selectGovernorate(picked);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: kBorder),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(children: [
                            Expanded(
                              child: Text(
                                cubit.selected?.name ?? 'Governorate',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: cubit.selected == null ? kHint : Colors.black,
                                ),
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down),
                          ]),
                        ),
                      ),
                    ]),
                  ),
                  Row(children: [
                    Text('Total:', style: TextStyle(fontSize: 16.sp, color: kHint)),
                    const Spacer(),
                    Text('${widget.total.toStringAsFixed(2)} EGP',
                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  ]),
                  SizedBox(height: 12.h),
                  GoldButton(
                    text: 'Submit Order',
                    loading: state is PlaceOrderSubmitting,
                    onPressed: () => cubit.submit(
                      name: _name.text,
                      phone: _phone.text,
                      address: _address.text,
                    ),
                  ),
                  SizedBox(height: 16.h),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
