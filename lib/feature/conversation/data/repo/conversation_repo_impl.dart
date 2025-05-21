import 'package:chat_app/core/netwoking/api_result.dart';
import 'package:chat_app/feature/conversation/domain/entities/conversation_entity.dart';
import 'package:chat_app/feature/conversation/domain/repo/conversation_repo.dart';

import '../datesource/conversation_remote_datesource.dart';

class ConversationRepoImpl extends ConversationRepo {
  final ConversationRemoteDataSource conversationRemoteDataSource;

  ConversationRepoImpl(this.conversationRemoteDataSource);

  @override
  Future<ApiResult<List<ConversationEntity>>> fetchConversations() async {
    try {
     var result = await conversationRemoteDataSource.fetchConversations();
      return ApiResult.success(result);
    } catch (e) {
      print('errorrrrr ${e.toString()}');
      return ApiResult.failure(e.toString());
    }
  }

  @override
  Future<ApiResult<String>> checkOrCreateConversation({required String contactId}) async{
    try {
      var result = await conversationRemoteDataSource.checkOrCreateConversation(
        {"contactId": contactId},
      );
      return ApiResult.success(result.conversationId);
    } catch (e) {
      print('errorrrrr ${e.toString()}');
      return ApiResult.failure(e.toString());
    }
  }
}
