import 'package:flutter/material.dart';
import 'package:notion_assistant/views/database_input_field.dart';
import 'package:notion_assistant/data_model/database_type.dart';
import 'package:notion_assistant/external/local_storage.dart';
import 'package:notion_assistant/main.dart';

class DatabaseBuilder extends StatefulWidget {
  const DatabaseBuilder({
    Key? key,
    required this.type,
    required this.builder,
  }) : super(key: key);

  final DatabaseType type;
  final Function(BuildContext, String) builder;

  @override
  State<DatabaseBuilder> createState() => _DatabaseBuilderState();
}

class _DatabaseBuilderState extends State<DatabaseBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (getIt<LocalStorage>().hasDatabase(widget.type))
          widget.builder(
            context,
            getIt<LocalStorage>().getDatabaseId(widget.type)!,
          ),
        DatabaseInputField(
          onDatabaseAdd: () => setState(() {}),
          type: widget.type,
        ),
      ],
    );
  }
}
