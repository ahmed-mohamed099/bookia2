import 'package:bookia/features/orders/data/models/order_model.dart';

abstract class OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersSuccess extends OrdersState {
  final List<OrderModel> orders;

  OrdersSuccess(this.orders);
}

class OrdersError extends OrdersState {
  final String message;

  OrdersError(this.message);
}
