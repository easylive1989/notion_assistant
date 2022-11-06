enum DatabaseType {
  events,
  todos,
  unreads,
}

extension DatabaseTypeExtension on DatabaseType {
  String get value => {
    DatabaseType.events: "Events",
    DatabaseType.todos: "Todos",
    DatabaseType.unreads: "Unreads",
  }[this]!;
}