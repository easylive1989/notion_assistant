import 'package:dio/dio.dart';
import 'package:notion_assistant/external/local_storage.dart';

class StorageTokenInterceptor extends Interceptor {
  final LocalStorage _storage;

  StorageTokenInterceptor(LocalStorage storage) : _storage = storage;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addEntries(
        [MapEntry("Authorization", "Bearer ${_storage.getToken()}")]);
    return super.onRequest(options, handler);
  }
}
