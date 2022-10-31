import 'package:clock/clock.dart';
import 'package:equatable/equatable.dart';

class Events {
  final List<Event> events;

  Events({required this.events}) {
    events.sort((a, b) => a.start.compareTo(b.start));
  }

  List<Event> getTodayEvents() {
    return events.where((event) => _isToday(event)).toList();
  }

  List<Event> getNextEvents() {
    return events.where((event) => _isAfterToday(event)).toList();
  }

  bool _isAfterToday(Event event) {
    var end = event.end ?? event.start;
    return !end.isBefore(_getTomorrow());
  }

  bool _isToday(Event event) {
    var end = event.end ?? event.start;
    return !end.isBefore(_getToday()) && event.start.isBefore(_getTomorrow());
  }

  DateTime _getToday() {
    DateTime now = clock.now();
    return DateTime(now.year, now.month, now.day);
  }

  DateTime _getTomorrow() {
    DateTime tomorrow = clock.now().add(const Duration(days: 1));
    return DateTime(tomorrow.year, tomorrow.month, tomorrow.day);
  }
}

class Event extends Equatable {
  final String name;
  final DateTime start;
  final DateTime? end;

  const Event({
    required this.name,
    required this.start,
    this.end,
  });

  factory Event.fromJson(dynamic json) {
    var endDate = json["Date"]["date"]["end"];
    return Event(
      name: json["Name"]["title"][0]["text"]["content"],
      start: DateTime.parse(json["Date"]["date"]["start"]),
      end: endDate != null ? DateTime.parse(endDate) : null,
    );
  }

  @override
  List<Object?> get props => [name, start, end];
}
