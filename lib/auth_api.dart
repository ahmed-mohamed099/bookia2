import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi {
static final Dio _dio = Dio(BaseOptions(
baseUrl: 'https://codingarabic.eraapro.com/api',
headers: {'Accept': 'application/json'},
));

static Future<String?> login({required String email, required String password}) =>
_send('/login', {'email': email, 'password': password});

static Future<String?> register({
required String name,
required String email,
required String password,
required String passwordConfirmation,
}) =>
_send('/register', {
'name': name,
'email': email,
'password': password,
'password_confirmation': passwordConfirmation,
});

static Future<String?> forgotPassword(String email) =>
_send('/forget-password', {'email': email});

static Future<String?> checkCode(String email, String code) =>
_send('/check-forget-password', {'email': email, 'verify_code': code});

static Future<String?> resetPassword(String code, String pass, String confirm) =>
_send('/reset-password', {
'verify_code': code,
'new_password': pass,
'new_password_confirmation': confirm,
});

static Future<String?> _send(String path, Map<String, dynamic> body) async {
try {
final res = await _dio.post(path, data: body);
final data = res.data;
if (data is Map) {
final inner = data['data'];
final token = (inner is Map ? inner['token'] : null) ?? data['token'];
if (token != null) {
final prefs = await SharedPreferences.getInstance();
await prefs.setString('token', token.toString());
}
}
return null;
} on DioException catch (e) {
final data = e.response?.data;
if (data is Map) {
final errors = data['errors'];
if (errors is Map && errors.isNotEmpty) {
final first = errors.values.first;
return first is List ? first.first.toString() : first.toString();
}
if (data['message'] != null) return data['message'].toString();
}
if (e.response?.statusCode == 404) return 'الرابط ده مش موجود على السيرفر';
return 'تأكد من الإنترنت وحاول تاني';
}
}
}