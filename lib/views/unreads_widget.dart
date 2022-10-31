import 'package:flutter/material.dart';
import 'package:notion_assistant/data_model/unread.dart';
import 'package:notion_assistant/main.dart';
import 'package:notion_assistant/external/notion_client.dart';
import 'package:notion_assistant/data_model/todo.dart';

class UnreadsWidget extends StatelessWidget {
  const UnreadsWidget({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<Unreads>(
          future: getIt.get<NotionClient>().getUnreads(id),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Title(color: Colors.black, child: const Text("待讀文章")),
                  ...snapShot.data!.unreads.map((event) {
                    return ListTile(title: Text(event.name, maxLines: 1));
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
}
