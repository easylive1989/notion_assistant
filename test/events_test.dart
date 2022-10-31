import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notion_assistant/data_model/events.dart';

void main() {
  test("today events", () {
    withClock(Clock.fixed(DateTime.parse("2022-02-01")), () {
      var events = Events(events: [
        Event(
            name: "event 1",
            start: DateTime.parse("2022-01-03"),
            end: DateTime.parse("2022-01-04")),
        Event(
            name: "event 2",
            start: DateTime.parse("2022-01-03"),
            end: DateTime.parse("2022-02-03")),
        Event(
            name: "event 3",
            start: DateTime.parse("2022-02-03"),
            end: DateTime.parse("2022-03-03")),
        Event(
          name: "event 4",
          start: DateTime.parse("2022-01-01"),
        ),
        Event(
          name: "event 5",
          start: DateTime.parse("2022-02-01"),
        ),
        Event(
          name: "event 6",
          start: DateTime.parse("2022-02-03"),
        ),
      ]);
      expect(events.getTodayEvents(), [
        Event(
            name: "event 2",
            start: DateTime.parse("2022-01-03"),
            end: DateTime.parse("2022-02-03")),
        Event(
          name: "event 5",
          start: DateTime.parse("2022-02-01"),
        ),
      ]);
    });
  });

  test("next events", () {
    withClock(Clock.fixed(DateTime.parse("2022-02-01")), () {
      var events = Events(events: [
        Event(
            name: "event 1",
            start: DateTime.parse("2022-01-03"),
            end: DateTime.parse("2022-01-04")),
        Event(
            name: "event 2",
            start: DateTime.parse("2022-01-03"),
            end: DateTime.parse("2022-02-03")),
        Event(
            name: "event 3",
            start: DateTime.parse("2022-02-03"),
            end: DateTime.parse("2022-03-03")),
        Event(
          name: "event 4",
          start: DateTime.parse("2022-01-01"),
        ),
        Event(
          name: "event 5",
          start: DateTime.parse("2022-02-01"),
        ),
        Event(
          name: "event 6",
          start: DateTime.parse("2022-02-03"),
        ),
      ]);
      expect(events.getNextEvents(), [
        Event(
            name: "event 2",
            start: DateTime.parse("2022-01-03"),
            end: DateTime.parse("2022-02-03")),
        Event(
            name: "event 3",
            start: DateTime.parse("2022-02-03"),
            end: DateTime.parse("2022-03-03")),
        Event(
          name: "event 6",
          start: DateTime.parse("2022-02-03"),
        ),
      ]);
    });
  });
}
