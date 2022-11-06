import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notion_assistant/config.dart';
import 'package:notion_assistant/external/const_token_interceptor.dart';
import 'package:notion_assistant/external/dio_factory.dart';
import 'package:notion_assistant/external/local_storage.dart';
import 'package:notion_assistant/external/storage_token_interceptor.dart';
import 'package:notion_assistant/views/main_app.dart';
import 'package:notion_assistant/external/notion_client.dart';

final getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  var localStorage = LocalStorage();
  getIt.registerSingleton<LocalStorage>(localStorage);
  getIt.registerSingleton<NotionClient>(NotionClient(_createDio(localStorage)));
  runApp(const MaterialApp(home: MyApp()));
}

Dio _createDio(LocalStorage storage) {
  var dio = Dio(BaseOptions(baseUrl: baseUrl));
  final options = CacheOptions(
    store: HiveCacheStore("cache"),
    policy: CachePolicy.forceCache,
    maxStale: const Duration(minutes: 5),
    priority: CachePriority.high,
    cipher: null,
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    allowPostMethod: true,
  );
  dio.interceptors.addAll([
    StorageTokenInterceptor(storage),
    DioCacheInterceptor(options: options),
  ]);
  return dio;
}
