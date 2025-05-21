import 'dart:async';

import 'package:chat_app/core/netwoking/api_result.dart';
import 'package:chat_app/core/services/socket_service.dart';
import 'package:chat_app/feature/chat/data/datesource/message_remote_datasource.dart';
import 'package:chat_app/feature/chat/domain/entities/message_entity.dart';
import 'package:chat_app/feature/chat/domain/repo/message_repo.dart';

class MessageRepoImpl implements MessageRepo {
  final MessageRemoteDatasource messageRemoteDatasource;
  final ISocketService socketService;

  MessageRepoImpl({
    required this.messageRemoteDatasource,
    required this.socketService,
  });

  @override
  Future<ApiResult<List<MessageEntity>>> fetchMessages(String conversationId) async {
    try {
      final result = await messageRemoteDatasource.fetchMessages(conversationId);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  @override
  Future<void> sendMessage(MessageEntity message) async {
    final payload = {
      'conversationId': message.conversationId,
      'senderId': message.senderId,
      'content': message.content,
    };
    socketService.socket.emit('sendMessage', payload);
  }

  @override
  Future<void> joinConversation(String conversationId) async {
    socketService.socket.emit('joinConversation', conversationId);
  }

  @override
  Stream<MessageEntity> onMessageReceived() {
    final controller = StreamController<MessageEntity>();

    socketService.socket.off('newMessage');
    socketService.socket.on('newMessage', (data) {
      final msg = MessageEntity(
        id: data['id'],
        conversationId: data['conversation_id'],
        senderId: data['sender_id'],
        content: data['content'],
        createdAt: data['created_at'],
      );
      controller.add(msg);
    });

    controller.onCancel = () {
      socketService.socket.off('newMessage');
      controller.close();
    };

    return controller.stream;
  }
}

