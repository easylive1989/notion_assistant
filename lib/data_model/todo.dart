class Todos {
  final List<Todo> todos;

  Todos({required this.todos});
}

class Todo {
  final String name;

  Todo({required this.name});

  factory Todo.fromJson(dynamic json) {
    return Todo(
      name: json["任務項目"]["title"][0]["text"]["content"],
    );
  }
}