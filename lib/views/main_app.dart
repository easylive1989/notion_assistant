import 'package:flutter/material.dart';
import 'package:notion_assistant/views/database_builder.dart';
import 'package:notion_assistant/data_model/database_type.dart';
import 'package:notion_assistant/views/events_widget.dart';
import 'package:notion_assistant/external/local_storage.dart';
import 'package:notion_assistant/main.dart';
import 'package:notion_assistant/views/todos_widget.dart';
import 'package:notion_assistant/views/token_input_field.dart';
import 'package:notion_assistant/views/unreads_widget.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var hasToken = getIt.get<LocalStorage>().hasToken();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (!hasToken) TokenInputField(onTokenSet: () => setState(() {})),
            if (hasToken)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: DatabaseBuilder(
                      type: DatabaseType.todos,
                      builder: (context, id) => TodosWidget(id: id),
                    ),
                  ),
                  Expanded(
                    child: DatabaseBuilder(
                      type: DatabaseType.unreads,
                      builder: (context, id) => UnreadsWidget(id: id),
                    ),
                  ),
                  Expanded(
                    child: DatabaseBuilder(
                      type: DatabaseType.events,
                      builder: (context, id) => EventsWidget(id: id),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
