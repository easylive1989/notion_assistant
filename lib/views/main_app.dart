import 'package:flutter/material.dart';
import 'package:notion_assistant/views/database_builder.dart';
import 'package:notion_assistant/data_model/database_type.dart';
import 'package:notion_assistant/views/events_widget.dart';
import 'package:notion_assistant/external/local_storage.dart';
import 'package:notion_assistant/main.dart';
import 'package:notion_assistant/views/notion_domain_input_field.dart';
import 'package:notion_assistant/views/todos_widget.dart';
import 'package:notion_assistant/views/token_input_field.dart';
import 'package:notion_assistant/views/unreads_widget.dart';
import 'dart:html' as html;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

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
            if (hasToken) ...[
              const NotionDomainInputField(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: DatabaseBuilder(
                      type: DatabaseType.todos,
                      builder: (context, id) => GestureDetector(
                        onTap: () => _openDatabase(id),
                        child: TodosWidget(id: id),
                      ),
                    ),
                  ),
                  Expanded(
                    child: DatabaseBuilder(
                      type: DatabaseType.unreads,
                      builder: (context, id) => GestureDetector(
                        onTap: () => _openDatabase(id),
                        child: UnreadsWidget(id: id),
                      ),
                    ),
                  ),
                  Expanded(
                    child: DatabaseBuilder(
                      type: DatabaseType.events,
                      builder: (context, id) => GestureDetector(
                        onTap: () => _openDatabase(id),
                        child: EventsWidget(id: id),
                      ),
                    ),
                  ),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }

  html.WindowBase _openDatabase(String id) {
    return html.window.open(
        "${getIt.get<LocalStorage>().getNotionDomain() ?? ""}$id", "new tab");
  }
}
