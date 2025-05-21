import 'package:chat_app/core/netwoking/api_constants.dart';
import 'package:chat_app/feature/auth/data/models/user_model.dart';
import 'package:chat_app/feature/chat/data/models/message_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'message_remote_datasource.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class MessageRemoteDatasource {
  factory MessageRemoteDatasource(Dio dio, {String baseUrl}) = _MessageRemoteDatasource;

  // path parameter بدل query
  @GET('${ApiConstants.messages}/{conversationId}')
  Future<List<MessageModel>> fetchMessages(@Path('conversationId') String conversationId);
}


