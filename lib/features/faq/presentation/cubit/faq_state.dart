import 'package:bookia/features/faq/data/models/faq_model.dart';

abstract class FaqState {}

class FaqLoading extends FaqState {}

class FaqSuccess extends FaqState {
  final List<FaqModel> faqs;

  FaqSuccess(this.faqs);
}

class FaqError extends FaqState {
  final String message;

  FaqError(this.message);
}
