import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookia/features/search/data/repo/search_repo.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  final SearchRepo _repo = SearchRepo();
  Timer? _timer;

  void onTextChanged(String text) {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 500), () => _search(text));
  }

  Future<void> _search(String text) async {
    if (text.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }
    emit(SearchLoading());
    try {
      final products = await _repo.search(text.trim());
      emit(SearchSuccess(products));
    } catch (e) {
      emit(SearchError('Something went wrong, try again'));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}