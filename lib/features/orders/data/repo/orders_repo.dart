import 'package:bookia/core/network/auth_options.dart';
import 'package:bookia/core/network/dio_helper.dart';
import 'package:bookia/features/orders/data/models/order_model.dart';

class OrdersRepo {
  Future<List<OrderModel>> getOrders() async {
    final res = await DioHelper.dio.get('/order-history', options: await authOptions());
    final data = res.data['data'];
    final List list = data is Map ? (data['orders'] ?? []) : (data ?? []);
    return list.map((e) => OrderModel.fromJson(e)).toList();
  }
}
