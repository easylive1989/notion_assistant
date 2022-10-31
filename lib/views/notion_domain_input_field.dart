import 'package:flutter/material.dart';
import 'package:notion_assistant/external/local_storage.dart';
import 'package:notion_assistant/main.dart';

class NotionDomainInputField extends StatefulWidget {
  const NotionDomainInputField({
    Key? key,
  }) : super(key: key);

  @override
  State<NotionDomainInputField> createState() => _NotionDomainInputFieldState();
}

class _NotionDomainInputFieldState extends State<NotionDomainInputField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text: getIt.get<LocalStorage>().getNotionDomain(),
    );
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
              onFieldSubmitted: setToken,
              decoration: const InputDecoration(
                hintText: "https://www.notion.so/username",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => setToken(controller.text),
            child: const Icon(Icons.save),
          )
        ],
      ),
    );
  }

  void setToken(String notionDomain) async {
    await getIt.get<LocalStorage>().setNotionDomain(notionDomain);
  }
}
