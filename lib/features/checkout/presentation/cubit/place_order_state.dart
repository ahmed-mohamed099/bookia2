abstract class PlaceOrderState {}

/// Loading governorates and the user's data when the page opens.
class PlaceOrderLoading extends PlaceOrderState {}

/// The form is ready to fill.
class PlaceOrderReady extends PlaceOrderState {}

class PlaceOrderSubmitting extends PlaceOrderState {}

class PlaceOrderSuccess extends PlaceOrderState {}

class PlaceOrderError extends PlaceOrderState {
  final String message;

  PlaceOrderError(this.message);
}
