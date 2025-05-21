import 'package:chat_app/core/routing/routes.dart';
import 'package:chat_app/core/theme.dart';
import 'package:chat_app/feature/conversation/presentation/cubit/conversation_cubit.dart';
import 'package:chat_app/feature/conversation/presentation/widget/message_tile.dart';
import 'package:chat_app/feature/conversation/presentation/widget/recent_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key});

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
              child: BlocBuilder<ConversationCubit, ConversationState>(
                builder: (context, state) {
                  if (state is ConversationLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ConversationLoaded) {
                    return ListView.builder(
                      itemCount: state.conversations.length,
                      itemBuilder: (context, index) {
                        final conversation = state.conversations[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(Routes.chatScreen, arguments: {
                              'conversationId': conversation.id,
                              'participantName': conversation.participantName
                            });
                          },
                          child: MessageTile(
                            name: conversation.participantName,
                            time: conversation.lastMessageTime,
                            message: conversation.lastMessage.toString(),
                          ),
                        );
                      },
                    );
                  } else if (state is ConversationError) {
                    return Center(child: Text(state.errorMessage));
                  }
                  return const Center(child: Text('No conversations found'));
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.contacts,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.contactScreen);
        },
      ),
    );
  }
}
