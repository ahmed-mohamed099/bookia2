import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookia/core/network/api_error.dart';
import 'package:bookia/features/profile/data/repo/profile_repo.dart';
import 'submit_state.dart';

class EditProfileCubit extends Cubit<SubmitState> {
  EditProfileCubit() : super(SubmitInitial());

  final ProfileRepo _repo = ProfileRepo();

  Future<void> update({
    required String name,
    required String phone,
    required String city,
    required String address,
  }) async {
    if (name.trim().isEmpty) {
      emit(SubmitError('Name is required'));
      return;
    }
    emit(SubmitLoading());
    try {
      await _repo.updateProfile(
        name: name.trim(),
        phone: phone.trim(),
        city: city.trim(),
        address: address.trim(),
      );
      emit(SubmitSuccess());
    } catch (e) {
      emit(SubmitError(apiErrorMessage(e)));
    }
  }
}
