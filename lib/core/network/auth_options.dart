import 'package:dio/dio.dart';
import 'package:bookia/features/auth/data/repo/auth_api.dart';

/// Headers for requests that need the user to be logged in.
Future<Options> authOptions() async {
  final token = await AuthApi.getToken();
  return Options(headers: {'Authorization': 'Bearer $token'});
}
