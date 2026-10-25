import 'package:dio/dio.dart';

class DioHelper {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://codingarabic.eraapro.com/api',
      headers: {'Accept': 'application/json'},
    ),
  );
}