import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notion_assistant/external/dio_factory.dart';
import 'package:notion_assistant/external/local_storage.dart';
import 'package:notion_assistant/views/main_app.dart';
import 'package:notion_assistant/external/notion_client.dart';

final getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  var dioFactory = DioFactory();
  var localStorage = LocalStorage();
  getIt.registerSingleton<LocalStorage>(localStorage);
  getIt.registerSingleton<NotionClient>(NotionClient(
    dioFactory.createForNotion(),
    localStorage,
  ));
  runApp(const MaterialApp(home: MyApp()));
}