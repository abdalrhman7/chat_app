import 'package:chat_app/core/netwoking/api_result.dart';
import 'package:chat_app/feature/chat/data/datesource/message_remote_datasource.dart';
import 'package:chat_app/feature/chat/domain/entities/message_entity.dart';
import 'package:chat_app/feature/chat/domain/repo/message_repo.dart';

class MessageRepoImpl implements MessageRepo {
  final MessageRemoteDatasource messageRemoteDatasource;

  MessageRepoImpl(this.messageRemoteDatasource);

  @override
  Future<ApiResult<List<MessageEntity>>> fetchMessages(
      String conversationId) async {
    try {
      var result = await messageRemoteDatasource.fetchMessages(conversationId);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  @override
  Future<void> sendMessage(MessageEntity message) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
}
