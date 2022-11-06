import 'package:dio/dio.dart';
import 'package:notion_assistant/data_model/events.dart';
import 'package:notion_assistant/data_model/unread.dart';
import 'package:notion_assistant/data_model/todo.dart';

class NotionClient {
  final Dio _dio;

  NotionClient(Dio dio)
      : _dio = dio;

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
      }),
    );
    return Unreads(
      unreads: response.data["results"]
          .map<Unread>((json) => Unread.fromJson(json["properties"]))
          .toList(),
    );
  }

  Future<Events> getEvents(String id) async {
    Response response = await _dio.post(
      "$id/query",
      options: Options(headers: {
        "Notion-Version": "2021-08-16",
        "Content-Type": "application/json",
      }),
    );
    return Events(
      events: response.data["results"]
          .map<Event>((json) => Event.fromJson(json["properties"]))
          .toList(),
    );
  }
}
