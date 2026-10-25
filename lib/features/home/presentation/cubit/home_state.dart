import 'package:bookia/features/home/data/models/product_model.dart';
import 'package:bookia/features/home/data/models/slider_model.dart';

abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<SliderModel> sliders;
  final List<ProductModel> products;

  HomeSuccess({required this.sliders, required this.products});
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}