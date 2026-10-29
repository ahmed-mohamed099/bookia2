import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookia/core/network/api_error.dart';
import 'package:bookia/features/profile/data/repo/profile_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoading());

  final ProfileRepo _repo = ProfileRepo();

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final user = await _repo.getProfile();
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError(apiErrorMessage(e)));
    }
  }

  Future<void> logout() => _repo.logout();
}
