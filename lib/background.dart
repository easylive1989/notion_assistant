import 'dart:async';
import 'dart:html';
import 'dart:js';

import 'package:dio/dio.dart';
import 'package:notion_assistant/config.dart';
import 'package:notion_assistant/external/const_token_interceptor.dart';
import 'package:notion_assistant/external/notion_client.dart';

void main() {
  var token = window.localStorage['flutter.t']?.toString();
  if (token == null) {
    return;
  }

  var notionClient = NotionClient(_createDio(token.replaceAll("\"", "")));
  _updateBadge(notionClient);
  Timer.periodic(const Duration(seconds: 300), (timer) async {
    await _updateBadge(notionClient);
  });
}

Future _updateBadge(NotionClient notionClient) async {
  var unreadCount = await _getUnreadCount(notionClient);
  var todosCount = await _getTodos(notionClient);
  _setBadge(unreadCount + todosCount);
}

Future _getUnreadCount(NotionClient notionClient) async {
  var unreadsDatabaseId = window.localStorage['flutter.Unreadsdl'];
  if (unreadsDatabaseId != null) {
    var unreads =
        await notionClient.getUnreads(unreadsDatabaseId.replaceAll("\"", ""));
    return unreads.unreads.length;
  }
  return 0;
}

Future _getTodos(NotionClient notionClient) async {
  var todosDatabaseId = window.localStorage['flutter.Todosdl'];
  if (todosDatabaseId != null) {
    var todos =
        await notionClient.getRecentTodos(todosDatabaseId.replaceAll("\"", ""));
    return todos.todos.length;
  }
  return 0;
}

void _setBadge(int count) {
  var badgeText = JsObject.jsify({"text": "${count > 0 ? count : ""}"});
  var badgeBackgroundColor = JsObject.jsify({"color": "#D00218"});
  context["chrome"]["browserAction"].callMethod("setBadgeText", [badgeText]);
  context["chrome"]["browserAction"]
      .callMethod("setBadgeBackgroundColor", [badgeBackgroundColor]);
}

Dio _createDio(String token) {
  var dio = Dio(BaseOptions(baseUrl: baseUrl));
  dio.interceptors.addAll([ConstTokenInterceptor(token)]);
  return dio;
}
