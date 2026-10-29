import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookia/core/network/api_error.dart';
import 'package:bookia/features/checkout/data/models/governorate_model.dart';
import 'package:bookia/features/checkout/data/repo/checkout_repo.dart';
import 'package:bookia/features/profile/data/models/user_model.dart';
import 'package:bookia/features/profile/data/repo/profile_repo.dart';
import 'place_order_state.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  PlaceOrderCubit() : super(PlaceOrderLoading());

  final CheckoutRepo _repo = CheckoutRepo();
  final ProfileRepo _profileRepo = ProfileRepo();

  List<GovernorateModel> governorates = [];
  GovernorateModel? selected;
  UserModel? user;

  /// Gets the governorates list and the user's data to fill the form.
  Future<void> init() async {
    emit(PlaceOrderLoading());
    try {
      governorates = await _repo.getGovernorates();
      user = await _profileRepo.getProfile();
      emit(PlaceOrderReady());
    } catch (e) {
      emit(PlaceOrderError(apiErrorMessage(e)));
    }
  }

  void selectGovernorate(GovernorateModel governorate) {
    selected = governorate;
    emit(PlaceOrderReady());
  }

  Future<void> submit({
    required String name,
    required String phone,
    required String address,
  }) async {
    if (name.trim().isEmpty || phone.trim().isEmpty || address.trim().isEmpty) {
      emit(PlaceOrderError('Please fill all fields'));
      return;
    }
    if (selected == null) {
      emit(PlaceOrderError('Please select your governorate'));
      return;
    }
    emit(PlaceOrderSubmitting());
    try {
      await _repo.placeOrder(
        name: name.trim(),
        email: user?.email ?? '',
        phone: phone.trim(),
        address: address.trim(),
        governorateId: selected!.id,
      );
      emit(PlaceOrderSuccess());
    } catch (e) {
      emit(PlaceOrderError(apiErrorMessage(e)));
    }
  }
}
