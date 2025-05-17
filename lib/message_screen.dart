import 'package:chat_app/core/theme.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Recent', style: Theme.of(context).textTheme.bodySmall),
          ),
          Container(
            height: 100,
            padding: const EdgeInsets.all(4),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                RecentContact(
                  name: 'noby',
                ),
                RecentContact(
                  name: 'noby',
                ),
                RecentContact(
                  name: 'noby',
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: DefaultColors.messageListPage,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: ListView(
                children: const [
                  MessageTile(
                    name: 'noby',
                    time: '12:00',
                    message: 'hello',
                  ),
                  MessageTile(
                    name: 'noby',
                    time: '12:00',
                    message: 'hello',
                  ),
                  MessageTile(
                    name: 'noby',
                    time: '12:00',
                    message: 'hello',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  const MessageTile({
    super.key,
    required this.name,
    required this.time,
    required this.message,
  });

  final String name, time, message;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: const CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
      ),
      title: Text(
        name,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        message,
        style: const TextStyle(
            color: Colors.grey, overflow: TextOverflow.ellipsis),
      ),
      trailing: Text(
        time,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}

class RecentContact extends StatelessWidget {
  const RecentContact({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
          ),
          const SizedBox(height: 6),
          Text(name, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
