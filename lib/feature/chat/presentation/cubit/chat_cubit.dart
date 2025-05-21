import 'package:bloc/bloc.dart';
import 'package:chat_app/core/helper/shared_pref_helper.dart';
import 'package:chat_app/core/services/socket_service.dart' show SocketService;
import 'package:chat_app/feature/chat/domain/entities/message_entity.dart';
import 'package:chat_app/feature/chat/domain/usecases/fetch_message_usecase.dart';
import 'package:flutter/material.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
    ChatCubit({required this.fetchMessageUseCase, required this.socketService}) : super(ChatInitial());
  final FetchMessageUseCase fetchMessageUseCase;

  final SocketService socketService ;
  final TextEditingController messageController = TextEditingController();
  String conversationId = '';

  final List<MessageEntity> _messages = [];

  void setConversationId(String id) {
    conversationId = id;
  }

  Future<void> fetchMessages() async {
    emit(ChatLoadingState());
    var result = await fetchMessageUseCase(conversationId);
    result.when(
      success: (data) {
        _messages.clear();
        _messages.addAll(data);
        emit(ChatLoadedState(List.from(_messages.reversed)));
        socketService.socket.off('newMessage');
        socketService.socket.emit('joinConversation', conversationId);
        socketService.socket.on(
          'newMessage',
          (data) {
            print('step1 - receive $data');
            receiveMessage(data);
          },
        );
      },
      failure: (errorMessage) {
        emit(ChatErrorState(errorMessage));
      },
    );
  }

  Future<void> sendMessage() async {
    String userId = await SharedPrefHelper.getSecuredString('userId');
    final newMessage = {
      'conversationId': conversationId,
      'senderId': userId,
      'content': messageController.text,
    };
    print('Sending message payload: $newMessage');
    socketService.socket.emit('sendMessage', newMessage);
  }

  Future<void> receiveMessage(dynamic data) async {
    final message = MessageEntity(
      id: data['id'],
      conversationId: data['conversation_id'],
      senderId: data['sender_id'],
      content: data['content'],
      createdAt: data['created_at'],
    );

    _messages.add(message);
    emit(ChatLoadedState(List.from(_messages.reversed)));

  }
}
