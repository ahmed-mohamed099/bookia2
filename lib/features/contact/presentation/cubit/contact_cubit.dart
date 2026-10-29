import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookia/core/network/api_error.dart';
import 'package:bookia/features/contact/data/repo/contact_repo.dart';
import 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactInitial());

  final ContactRepo _repo = ContactRepo();

  Future<void> send({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    if ([name, email, subject, message].any((e) => e.trim().isEmpty)) {
      emit(ContactError('Please fill all fields'));
      return;
    }
    emit(ContactLoading());
    try {
      await _repo.sendMessage(
        name: name.trim(),
        email: email.trim(),
        subject: subject.trim(),
        message: message.trim(),
      );
      emit(ContactSuccess());
    } catch (e) {
      emit(ContactError(apiErrorMessage(e)));
    }
  }
}
