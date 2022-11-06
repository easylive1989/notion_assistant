import 'package:dio/dio.dart';

class ConstTokenInterceptor extends Interceptor {
  final String _token;

  ConstTokenInterceptor(String token) : _token = token;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addEntries(
        [MapEntry("Authorization", "Bearer $_token")]);
    return super.onRequest(options, handler);
  }
}
