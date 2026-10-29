import 'package:bookia/core/network/dio_helper.dart';

class ContactRepo {
  Future<void> sendMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    await DioHelper.dio.post('/contact-us', data: {
      'name': name,
      'email': email,
      'subject': subject,
      'message': message,
    });
  }
}
