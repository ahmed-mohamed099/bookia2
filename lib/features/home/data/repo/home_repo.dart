import 'package:bookia/core/network/dio_helper.dart';
import 'package:bookia/features/home/data/models/product_model.dart';
import 'package:bookia/features/home/data/models/slider_model.dart';

class HomeRepo {
  Future<List<SliderModel>> getSliders() async {
    final res = await DioHelper.dio.get('/sliders');
    final List list = res.data['data']['sliders'];
    return list.map((e) => SliderModel.fromJson(e)).toList();
  }

  Future<List<ProductModel>> getBestSeller() async {
    final res = await DioHelper.dio.get('/products-bestseller');
    final List list = res.data['data']['products'];
    return list.map((e) => ProductModel.fromJson(e)).toList();
  }
}