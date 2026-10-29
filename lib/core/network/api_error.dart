import 'package:dio/dio.dart';

/// Turns any error from Dio into a message we can show to the user.
String apiErrorMessage(Object error) {
  if (error is DioException) {
    final data = error.response?.data;
    if (data is Map) {
      final errors = data['errors'];
      if (errors is Map && errors.isNotEmpty) {
        final first = errors.values.first;
        return first is List ? first.first.toString() : first.toString();
      }
      if (data['message'] != null && data['message'].toString().isNotEmpty) {
        return data['message'].toString();
      }
    }
    if (error.response?.statusCode == 401) return 'Please login again';
    return 'Check your internet connection';
  }
  return 'Something went wrong, try again';
}
