import 'package:flutter/material.dart';
import 'package:notion_assistant/data_model/database_type.dart';
import 'package:notion_assistant/external/local_storage.dart';
import 'package:notion_assistant/main.dart';

class DatabaseInputField extends StatefulWidget {
  const DatabaseInputField({
    Key? key,
    required this.onDatabaseAdd,
    required this.type,
  }) : super(key: key);

  final DatabaseType type;
  final VoidCallback onDatabaseAdd;

  @override
  State<DatabaseInputField> createState() => _DatabaseInputFieldState();
}

class _DatabaseInputFieldState extends State<DatabaseInputField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  label: Title(
                    color: Colors.black,
                    child: Text(widget.type.value),
                  ),
                ),
                onFieldSubmitted: setDatabaseId),
          ),
          ElevatedButton(
            onPressed: () => setDatabaseId(controller.text),
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }

  void setDatabaseId(String id) async {
    await getIt.get<LocalStorage>().setDatabaseId(widget.type, id);
    widget.onDatabaseAdd();
    controller.clear();
  }
}
