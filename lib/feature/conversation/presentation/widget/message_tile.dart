


import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({
    super.key,
    required this.name,
    required this.time,
    required this.message,
  });

  final String name, message;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return ListTile(

      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: const CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
      ),
      title: Text(
        name,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        message,
        style: const TextStyle(color: Colors.grey, overflow: TextOverflow.ellipsis),
      ),
      trailing: Text(
        formatTime(time),
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }

  String formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2,'0')}:${dateTime.minute.toString().padLeft(2,'0')}';
  }
}
