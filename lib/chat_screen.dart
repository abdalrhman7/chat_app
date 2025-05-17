import 'package:chat_app/core/theme.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
            ),
            const SizedBox(width: 10),
            Text(
              'John Doe',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(padding: const EdgeInsets.all(20), children: const [
              ReceivedMessage(message: 'Hello, how are you?'),
              SentMessage(
                message: 'I am good, how about you?',
              ),
              ReceivedMessage(message: 'I am fine, thanks!'),
            ]),
          ),
          const MessageInput(),
        ],
      ),
    );
  }
}

class MessageInput extends StatelessWidget {
  const MessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DefaultColors.sentMessageInput,
        borderRadius: BorderRadius.circular(25),
      ),
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          GestureDetector(
            child: const Icon(
              Icons.camera_alt,
              color: Colors.grey,
            ),
            onTap: () {

            },
          ),
          const SizedBox(width: 10),
          const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white),
              )
          ),
          const SizedBox(height: 10),
          GestureDetector(
            child: const Icon(
              Icons.send,
              color: Colors.grey,
            ),
            onTap: () {

            }
          )
        ],
      ),
    );
  }
}

class ReceivedMessage extends StatelessWidget {
  const ReceivedMessage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(right: 30, top: 5, bottom: 5),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: DefaultColors.receiverMessage,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}

class SentMessage extends StatelessWidget {
  const SentMessage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(left: 30, top: 5, bottom: 5),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: DefaultColors.senderMessage,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
