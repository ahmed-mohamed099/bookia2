import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookia/core/network/api_error.dart';
import 'package:bookia/features/profile/data/repo/profile_repo.dart';
import 'submit_state.dart';

class UpdatePasswordCubit extends Cubit<SubmitState> {
  UpdatePasswordCubit() : super(SubmitInitial());

  final ProfileRepo _repo = ProfileRepo();

  Future<void> update({
    required String current,
    required String newPassword,
    required String confirm,
  }) async {
    if (newPassword.length < 8) {
      emit(SubmitError('New password must be at least 8 characters'));
      return;
    }
    if (newPassword != confirm) {
      emit(SubmitError('Passwords do not match'));
      return;
    }
    emit(SubmitLoading());
    try {
      await _repo.updatePassword(
        current: current,
        newPassword: newPassword,
        confirm: confirm,
      );
      emit(SubmitSuccess());
    } catch (e) {
      emit(SubmitError(apiErrorMessage(e)));
    }
  }
}
