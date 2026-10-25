import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookia/features/home/data/repo/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoading());

  final HomeRepo _repo = HomeRepo();

  Future<void> getHomeData() async {
    emit(HomeLoading());
    try {
      final sliders = await _repo.getSliders();
      final products = await _repo.getBestSeller();
      emit(HomeSuccess(sliders: sliders, products: products));
    } catch (e) {
      emit(HomeError('Something went wrong, try again'));
    }
  }
}