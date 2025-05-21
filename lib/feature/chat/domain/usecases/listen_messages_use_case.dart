import 'package:chat_app/feature/chat/domain/entities/message_entity.dart';
import 'package:chat_app/feature/chat/domain/repo/message_repo.dart';

class ListenMessagesUseCase {
  final MessageRepo messageRepo;
  ListenMessagesUseCase(this.messageRepo);

  Stream<MessageEntity> call() {
    return messageRepo.onMessageReceived();
  }
}
