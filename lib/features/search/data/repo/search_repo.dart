import 'package:bookia/core/network/dio_helper.dart';
import 'package:bookia/features/home/data/models/product_model.dart';

class SearchRepo {
  Future<List<ProductModel>> search(String name) async {
    final res = await DioHelper.dio.get(
      '/products-search',
      queryParameters: {'name': name},
    );
    final List list = res.data['data']['products'];
    return list.map((e) => ProductModel.fromJson(e)).toList();
  }
}