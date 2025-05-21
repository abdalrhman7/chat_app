import 'package:chat_app/feature/conversation/domain/repo/conversation_repo.dart';

import '../../../../core/netwoking/api_result.dart';

class CheckOrCreateConversationUseCase {
  final ConversationRepo conversationRepo;

  CheckOrCreateConversationUseCase({required this.conversationRepo});

  Future<ApiResult<String>> call({required String contactId}) async{
    return await conversationRepo.checkOrCreateConversation(contactId: contactId);
  }
}
