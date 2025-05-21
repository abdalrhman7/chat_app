import 'dart:async';

import 'package:chat_app/core/netwoking/api_result.dart';
import 'package:chat_app/core/services/socket_service.dart';
import 'package:chat_app/feature/conversation/domain/entities/conversation_entity.dart';
import 'package:chat_app/feature/conversation/domain/repo/conversation_repo.dart';

import '../datesource/conversation_remote_datesource.dart';

class ConversationRepoImpl implements ConversationRepo {
  final ConversationRemoteDataSource conversationRemoteDataSource;
  final ISocketService socketService;  

  ConversationRepoImpl({
    required this.conversationRemoteDataSource,
    required this.socketService,
  });

  @override
  Future<ApiResult<List<ConversationEntity>>> fetchConversations() async {
    try {
      final result = await conversationRemoteDataSource.fetchConversations();
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  @override
  Future<ApiResult<String>> checkOrCreateConversation({required String contactId}) async {
    try {
      final result = await conversationRemoteDataSource.checkOrCreateConversation({
        "contactId": contactId,
      });
      return ApiResult.success(result.conversationId);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  @override
  Stream<void> onConversationUpdated() {
    final controller = StreamController<void>();

    socketService.socket.off('conversationUpdated');
    socketService.socket.on('conversationUpdated', (_) {
      controller.add(null);
    });

    controller.onCancel = () {
      socketService.socket.off('conversationUpdated');
      controller.close();
    };

    return controller.stream;
  }
}

