import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookia/core/network/api_error.dart';
import 'package:bookia/features/cart/data/models/cart_model.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'cart_state.dart';

/// One CartCubit for the whole app (created in main.dart),
/// so the Buy button and the Cart page always see the same cart.
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartLoading());

  final CartRepo _repo = CartRepo();

  Future<void> getCart() async {
    emit(CartLoading());
    try {
      emit(CartLoaded(await _repo.getCart()));
    } catch (e) {
      emit(CartError(apiErrorMessage(e)));
    }
  }

  /// Returns null on success, or the error message to show.
  Future<String?> addToCart(int productId) async {
    try {
      emit(CartLoaded(await _repo.addToCart(productId)));
      return null;
    } catch (e) {
      return apiErrorMessage(e);
    }
  }

  Future<String?> changeQuantity(CartItemModel item, int quantity) async {
    if (quantity < 1 || (item.stock > 0 && quantity > item.stock)) return null;
    try {
      emit(CartLoaded(await _repo.updateQuantity(item.id, quantity)));
      return null;
    } catch (e) {
      return apiErrorMessage(e);
    }
  }

  Future<String?> remove(CartItemModel item) async {
    try {
      emit(CartLoaded(await _repo.remove(item.id)));
      return null;
    } catch (e) {
      return apiErrorMessage(e);
    }
  }
}
