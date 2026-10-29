import 'package:bookia/core/network/auth_options.dart';
import 'package:bookia/core/network/dio_helper.dart';
import 'package:bookia/features/checkout/data/models/governorate_model.dart';

class CheckoutRepo {
  Future<List<GovernorateModel>> getGovernorates() async {
    final res = await DioHelper.dio.get('/governorates');
    final data = res.data['data'];
    final List list = data is Map ? (data['governorates'] ?? []) : data;
    return list.map((e) => GovernorateModel.fromJson(e)).toList();
  }

  Future<void> placeOrder({
    required String name,
    required String email,
    required String phone,
    required String address,
    required int governorateId,
  }) async {
    await DioHelper.dio.post(
      '/place-order',
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'governorate_id': governorateId,
      },
      options: await authOptions(),
    );
  }
}
