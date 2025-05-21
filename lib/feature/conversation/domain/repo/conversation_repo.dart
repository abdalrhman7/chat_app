import 'package:chat_app/core/netwoking/api_result.dart';
import 'package:chat_app/feature/conversation/domain/entities/conversation_entity.dart';

abstract class ConversationRepo {
  Future<ApiResult<List<ConversationEntity>>> fetchConversations();
  Future<ApiResult<String>> checkOrCreateConversation({required String contactId});

  Stream<void> onConversationUpdated();
}
