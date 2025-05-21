import 'package:chat_app/feature/conversation/domain/entities/conversation_entity.dart';
import 'package:chat_app/feature/conversation/domain/repo/conversation_repo.dart';

import '../../../../core/netwoking/api_result.dart';

class FetchConversationUseCase {
  final ConversationRepo conversationRepo;

  FetchConversationUseCase({required this.conversationRepo});

  Future<ApiResult<List<ConversationEntity>>> call() async{
    return await conversationRepo.fetchConversations();
  }
}
