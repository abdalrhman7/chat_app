import 'package:chat_app/core/helper/shared_pref_helper.dart';
import 'package:chat_app/core/theme.dart';
import 'package:chat_app/feature/auth/presentation/widget/received_message.dart';
import 'package:chat_app/feature/auth/presentation/widget/sent_message.dart';
import 'package:chat_app/feature/chat/presentation/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.mate});

  final String mate;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String userId = '';

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final id = await SharedPrefHelper.getSecuredString('userId');
    setState(() {
      userId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
            ),
            const SizedBox(width: 10),
            Text(
              widget.mate,
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
          Expanded(child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              if (state is ChatLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ChatLoadedState) {
                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(20),
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[index];
                    final isSender = message.senderId == userId;
                    if (isSender) {
                      return SentMessage(message: message.content);
                    } else {
                      return ReceivedMessage(message: message.content);
                    }
                  },
                );
              } else if (state is ChatErrorState) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else {
                return const Center(child: Text('No messages yet'));
              }
            },
          )),
          const MessageInput(),
        ],
      ),
    );
  }
}

class MessageInput extends StatefulWidget {
  const MessageInput({super.key});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ChatCubit>();
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
            onTap: () {},
          ),
          const SizedBox(width: 10),
          Expanded(
              child: TextField(
            controller: cubit.messageController,
            decoration: const InputDecoration(
              hintText: 'Type a message',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
            style: const TextStyle(color: Colors.white),
          )),
          const SizedBox(height: 10),
          GestureDetector(
              child: const Icon(
                Icons.send,
                color: Colors.grey,
              ),
              onTap: () async {
                print('cubit.messageController.text: ${cubit.messageController.text}');
              await  cubit.sendMessage();
                cubit.messageController.clear();
              })
        ],
      ),
    );
  }
}




