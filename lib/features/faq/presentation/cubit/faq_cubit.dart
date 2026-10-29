import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookia/core/network/api_error.dart';
import 'package:bookia/features/faq/data/repo/faq_repo.dart';
import 'faq_state.dart';

class FaqCubit extends Cubit<FaqState> {
  FaqCubit() : super(FaqLoading());

  final FaqRepo _repo = FaqRepo();

  Future<void> getFaqs() async {
    emit(FaqLoading());
    try {
      emit(FaqSuccess(await _repo.getFaqs()));
    } catch (e) {
      emit(FaqError(apiErrorMessage(e)));
    }
  }
}
