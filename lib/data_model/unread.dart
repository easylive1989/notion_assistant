class Unreads {
  final List<Unread> unreads;

  Unreads({required this.unreads});
}

class Unread {
  final String name;

  Unread({required this.name});

  factory Unread.fromJson(dynamic json) {
    return Unread(
      name: json["名稱"]["title"][0]["text"]["content"],
    );
  }
}