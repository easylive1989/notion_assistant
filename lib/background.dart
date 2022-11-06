import 'dart:async';
import 'dart:js';

import 'package:notion_assistant/external/dio_factory.dart';
import 'package:notion_assistant/external/local_storage.dart';
import 'package:notion_assistant/external/notion_client.dart';
//
// import 'package:notion_assistant/data_model/database_type.dart';
// import 'package:notion_assistant/external/dio_factory.dart';
// import 'package:notion_assistant/external/local_storage.dart';
// import 'package:notion_assistant/external/notion_client.dart';

void main() {
  // var dioFactory = DioFactory();
  // var localStorage = LocalStorage();
  // var notionClient = NotionClient(dioFactory.createForNotion(), localStorage);
  _setBadge(2);
  Timer.periodic(const Duration(seconds: 300), (timer) async {
    // var eventDatabaseId = localStorage.getDatabaseId(DatabaseType.unreads);
    // if (eventDatabaseId != null) {
    //   var events = await notionClient.getEvents(eventDatabaseId);
    //
    // }
  });
}

void _setBadge(int count) {
  var badgeText = JsObject.jsify({"text": "$count"});
  var badgeBackgroundColor = JsObject.jsify({"color": "#D00218"});
  context["chrome"]["browserAction"].callMethod("setBadgeText", [badgeText]);
  context["chrome"]["browserAction"].callMethod("setBadgeBackgroundColor", [badgeBackgroundColor]);
}
//
// @JS('chrome.browserAction.setBadgeText')
// external void setBadgeText(Object obj);