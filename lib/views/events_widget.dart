import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notion_assistant/data_model/events.dart';
import 'package:notion_assistant/main.dart';
import 'package:notion_assistant/external/notion_client.dart';

class EventsWidget extends StatelessWidget {
  const EventsWidget({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<Events>(
          future: getIt.get<NotionClient>().getEvents(id),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Title(color: Colors.black, child: const Text("今日活動")),
                  ...snapShot.data!.getTodayEvents().map((event) {
                    return ListTile(title: Text(event.name));
                  }).toList(),
                  Title(color: Colors.black, child: const Text("接下來的活動")),
                  ...snapShot.data!.getNextEvents().map((event) {
                    return ListTile(
                      title: Text(event.name),
                      subtitle: Text(_getDateRange(event)),
                    );
                  }).toList(),
                ],
              );
            } else if (snapShot.hasError) {
              return Text("${snapShot.error}");
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  String _getDateRange(Event event) {
    var startDate = DateFormat("MM/dd hh:mm").format(event.start);
    if (event.end != null) {
      return "$startDate - ${DateFormat("MM/dd hh:mm").format(event.end!)}";
    }
    return startDate;
  }
}
