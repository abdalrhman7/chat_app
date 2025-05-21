import 'package:chat_app/core/netwoking/api_constants.dart';
import 'package:chat_app/feature/auth/data/models/user_model.dart';
import 'package:chat_app/feature/conversation/data/models/conversation_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'conversation_remote_datesource.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ConversationRemoteDataSource {
  factory ConversationRemoteDataSource(Dio dio, {String baseUrl}) = _ConversationRemoteDataSource;

  @GET(ApiConstants.conversations)
  Future<List<ConversationModel>> fetchConversations();

  @POST(ApiConstants.checkOrCreateConversation)
  Future<ConversationIdResponse> checkOrCreateConversation(@Body() Map<String, dynamic> body);

}