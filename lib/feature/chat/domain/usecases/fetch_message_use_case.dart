

import 'package:chat_app/feature/chat/domain/entities/message_entity.dart';
import 'package:chat_app/feature/chat/domain/repo/message_repo.dart';

import '../../../../core/netwoking/api_result.dart';

class FetchMessageUseCase {
  final MessageRepo messageRepo;
  FetchMessageUseCase(this.messageRepo);

  Future<ApiResult<List<MessageEntity>>> call(String conversationId) {
    return messageRepo.fetchMessages(conversationId);
  }
}
