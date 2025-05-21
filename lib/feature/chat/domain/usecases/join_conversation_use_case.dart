import 'package:chat_app/feature/chat/domain/repo/message_repo.dart';

class JoinConversationUseCase {
  final MessageRepo messageRepo;
  JoinConversationUseCase(this.messageRepo);

  Future<void> call(String conversationId) {
    return messageRepo.joinConversation(conversationId);
  }
}
