import 'package:bookia/features/home/data/models/product_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<ProductModel> products;

  SearchSuccess(this.products);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}