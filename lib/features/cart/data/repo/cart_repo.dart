import 'package:bookia/core/network/auth_options.dart';
import 'package:bookia/core/network/dio_helper.dart';
import 'package:bookia/features/cart/data/models/cart_model.dart';

class CartRepo {
  Future<CartModel> getCart() async {
    final res = await DioHelper.dio.get('/cart', options: await authOptions());
    return CartModel.fromJson(res.data['data']);
  }

  Future<CartModel> addToCart(int productId) async {
    final res = await DioHelper.dio.post(
      '/add-to-cart',
      data: {'product_id': productId},
      options: await authOptions(),
    );
    return CartModel.fromJson(res.data['data']);
  }

  Future<CartModel> updateQuantity(int cartItemId, int quantity) async {
    final res = await DioHelper.dio.post(
      '/update-cart',
      data: {'cart_item_id': cartItemId, 'quantity': quantity},
      options: await authOptions(),
    );
    return CartModel.fromJson(res.data['data']);
  }

  Future<CartModel> remove(int cartItemId) async {
    final res = await DioHelper.dio.post(
      '/remove-from-cart',
      data: {'cart_item_id': cartItemId},
      options: await authOptions(),
    );
    return CartModel.fromJson(res.data['data']);
  }
}
