

import 'package:chat_app/feature/conversation/domain/repo/conversation_repo.dart';

class ListenConversationUpdatesUseCase {
  final ConversationRepo conversationRepo;

  ListenConversationUpdatesUseCase({required this.conversationRepo});

  Stream<void> call() => conversationRepo.onConversationUpdated();
}
