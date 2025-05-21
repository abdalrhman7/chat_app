import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/core/helper/shared_pref_helper.dart';
import 'package:chat_app/core/services/socket_service.dart' show SocketService;
import 'package:chat_app/feature/chat/domain/entities/message_entity.dart';
import 'package:chat_app/feature/chat/domain/usecases/fetch_message_usecase.dart';
import 'package:chat_app/feature/chat/domain/usecases/join_conversation_use_case.dart';
import 'package:chat_app/feature/chat/domain/usecases/listen_messages_use_case.dart';
import 'package:chat_app/feature/chat/domain/usecases/send_message_use_case.dart';
import 'package:flutter/material.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final FetchMessageUseCase fetchUseCase;
  final SendMessageUseCase sendUseCase;
  final JoinConversationUseCase joinUseCase;
  final ListenMessagesUseCase listenUseCase;

  ChatCubit({
    required this.fetchUseCase,
    required this.sendUseCase,
    required this.joinUseCase,
    required this.listenUseCase,
  }) : super(ChatInitial());

  final TextEditingController messageController = TextEditingController();
  String conversationId = '';
  final List<MessageEntity> _messages = [];
  StreamSubscription<MessageEntity>? _sub;

  void setConversationId(String id) {
    conversationId = id;
  }

  Future<void> fetchMessages() async {
    emit(ChatLoadingState());
    final result = await fetchUseCase(conversationId);
    result.when(
      success: (data) {
        _messages
          ..clear()
          ..addAll(data);
        emit(ChatLoadedState(List.from(_messages.reversed)));

        joinUseCase(conversationId);
        _sub = listenUseCase().listen((message) {
          _messages.add(message);
          emit(ChatLoadedState(List.from(_messages.reversed)));
        });
      },
      failure: (err) => emit(ChatErrorState(err)),
    );
  }

  Future<void> sendMessage() async {
    final userId = await SharedPrefHelper.getSecuredString('userId');
    final message = MessageEntity(
      id: '',
      conversationId: conversationId,
      senderId: userId,
      content: messageController.text,
      createdAt: DateTime.now().toIso8601String(),
    );
    await sendUseCase(message);
    messageController.clear();
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
