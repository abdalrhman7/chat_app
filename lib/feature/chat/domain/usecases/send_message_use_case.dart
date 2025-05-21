

import 'package:chat_app/feature/chat/domain/entities/message_entity.dart';
import 'package:chat_app/feature/chat/domain/repo/message_repo.dart';

class SendMessageUseCase {
  final MessageRepo messageRepo;
  SendMessageUseCase(this.messageRepo);

  Future<void> call(MessageEntity message) {
    return messageRepo.sendMessage(message);
  }
}
