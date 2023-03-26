import 'package:flutter/material.dart';
import 'package:task_byte/model/user_model.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  static const String route = "messageScreen";

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late User user;

  @override
  void didChangeDependencies() {
    user = ModalRoute.of(context)!.settings.arguments as User;
    super.didChangeDependencies();
  }

  final _messageController = TextEditingController(text: "Message");

  buildMessage() {
    return ListTile(
      title: Text(user.userId!),
      // title: Text(post.postTime!),
      leading: const CircleAvatar(
        backgroundImage: AssetImage("assets/images/me.jpg"),
      ),
      subtitle: Text("${user.firstName!} ${user.lastName!}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Page"),
      ),
      body: Column(
        children: [
          Expanded(
            child: buildMessage(),
          ),
          const Divider(),
          ListTile(
            title: TextFormField(
              controller: _messageController,
              // textInputAction: TextInputAction.newline,
              // keyboardType: TextInputType.multiline,
              // maxLines: 5,
              decoration:
                  const InputDecoration(labelText: "Write a message..."),
            ),
            trailing: OutlinedButton(
              child: const Text("Message"),
              onPressed: () {
                print("Enter Message");
              },
            ),
          )
        ],
      ),
    );
  }
}
