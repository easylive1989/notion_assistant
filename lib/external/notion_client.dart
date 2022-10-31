import 'package:dio/dio.dart';
import 'package:notion_assistant/data_model/events.dart';
import 'package:notion_assistant/data_model/unread.dart';
import 'package:notion_assistant/external/local_storage.dart';
import 'package:notion_assistant/data_model/todo.dart';

class NotionClient {
  final Dio _dio;
  final LocalStorage _storage;

  NotionClient(Dio dio, LocalStorage localStorage)
      : _dio = dio,
        _storage = localStorage;

  Future<Todos> getRecentTodos(String id) async {
    Response response = await _dio.post(
      "$id/query",
      data: {
        "filter": {
          "and": [
            {
              "property": "近期任務",
              "checkbox": {"equals": true}
            },
            {
              "property": "完成",
              "checkbox": {"equals": false}
            },
            {
              "property": "清單",
              "select": {"does_not_equal": "垃圾桶"}
            }
          ]
        }
      },
      options: Options(headers: {
        "Notion-Version": "2021-08-16",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${_storage.getToken()}",
      }),
    );

    return Todos(
      todos: response.data["results"]
          .map<Todo>((json) => Todo.fromJson(json["properties"]))
          .toList(),
    );
  }

  Future<Unreads> getUnreads(String id) async {
    Response response = await _dio.post(
      "$id/query",
      options: Options(headers: {
        "Notion-Version": "2021-08-16",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${_storage.getToken()}",
      }),
    );
    return Unreads(
      unreads: response.data["results"]
          .map<Event>((json) => Unread.fromJson(json["properties"]))
          .toList(),
    );
  }

  Future<Events> getEvents(String id) async {
    Response response = await _dio.post(
      "$id/query",
      options: Options(headers: {
        "Notion-Version": "2021-08-16",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${_storage.getToken()}",
      }),
    );
    return Events(
      events: response.data["results"]
          .map<Event>((json) => Event.fromJson(json["properties"]))
          .toList(),
    );
  }
}
