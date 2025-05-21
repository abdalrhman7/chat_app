

import 'package:chat_app/core/netwoking/api_result.dart';
import 'package:chat_app/feature/chat/domain/entities/message_entity.dart';

abstract class MessageRepo {
  Future<ApiResult<List<MessageEntity>>> fetchMessages(String conversationId);

  Future<void> sendMessage(MessageEntity message);

  Future<void> joinConversation(String conversationId);

  Stream<MessageEntity> onMessageReceived();
}
