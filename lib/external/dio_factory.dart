import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';

class DioFactory {
  Dio createForNotion() {
    String baseUrl = "https://api.notion.com/v1/databases/";
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
    dio.interceptors.add(DioCacheInterceptor(options: options));
    return dio;
  }
}