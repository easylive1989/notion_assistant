import 'package:flutter/material.dart';
import 'package:notion_assistant/external/local_storage.dart';
import 'package:notion_assistant/main.dart';

class TokenInputField extends StatefulWidget {
  const TokenInputField({
    Key? key,
    required this.onTokenSet,
  }) : super(key: key);

  final VoidCallback onTokenSet;

  @override
  State<TokenInputField> createState() => _TokenInputFieldState();
}

class _TokenInputFieldState extends State<TokenInputField> {
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
              onFieldSubmitted: setToken,
              decoration: const InputDecoration(
                hintText: "Input your integration token",
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

  void setToken(String token) async {
    await getIt.get<LocalStorage>().setToken(token);
    widget.onTokenSet();
  }
}
