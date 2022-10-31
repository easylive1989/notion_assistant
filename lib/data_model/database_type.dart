enum DatabaseType {
  events("Events"),
  todos("Todos"),
  unreads("Unreads");

  final String value;

  const DatabaseType(this.value);
}