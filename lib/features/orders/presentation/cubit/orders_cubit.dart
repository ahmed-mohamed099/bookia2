import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookia/core/network/api_error.dart';
import 'package:bookia/features/orders/data/repo/orders_repo.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersLoading());

  final OrdersRepo _repo = OrdersRepo();

  Future<void> getOrders() async {
    emit(OrdersLoading());
    try {
      emit(OrdersSuccess(await _repo.getOrders()));
    } catch (e) {
      emit(OrdersError(apiErrorMessage(e)));
    }
  }
}
