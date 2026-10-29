import 'package:dio/dio.dart';
import 'package:bookia/core/network/dio_helper.dart';
import 'package:bookia/features/auth/data/repo/auth_api.dart';
import 'package:bookia/features/profile/data/models/user_model.dart';

class ProfileRepo {
  /// Every profile request needs the token we saved after login.
  Future<Options> _auth() async {
    final token = await AuthApi.getToken();
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  Future<UserModel> getProfile() async {
    final res = await DioHelper.dio.get('/profile', options: await _auth());
    return UserModel.fromJson(res.data['data']);
  }

  Future<UserModel> updateProfile({
    required String name,
    required String phone,
    required String city,
    required String address,
  }) async {
    final res = await DioHelper.dio.post(
      '/update-profile',
      data: {'name': name, 'phone': phone, 'city': city, 'address': address},
      options: await _auth(),
    );
    return UserModel.fromJson(res.data['data']);
  }

  Future<void> updatePassword({
    required String current,
    required String newPassword,
    required String confirm,
  }) async {
    await DioHelper.dio.post(
      '/update-password',
      data: {
        'current_password': current,
        'new_password': newPassword,
        'new_password_confirmation': confirm,
      },
      options: await _auth(),
    );
  }

  Future<void> logout() async {
    try {
      await DioHelper.dio.post('/logout', options: await _auth());
    } finally {
      // Remove the token even if the server request fails.
      await AuthApi.removeToken();
    }
  }
}
