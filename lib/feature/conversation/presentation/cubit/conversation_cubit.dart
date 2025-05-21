import 'package:bloc/bloc.dart';
import 'package:chat_app/core/services/socket_service.dart';
import 'package:chat_app/feature/conversation/domain/entities/conversation_entity.dart';
import 'package:chat_app/feature/conversation/domain/usecase/fetch_conversation_use_case.dart';
import 'package:meta/meta.dart';

part 'conversation_state.dart';

class ConversationCubit extends Cubit<ConversationState> {
  ConversationCubit({required this.socketService,required this.fetchConversationUseCase})
      : super(ConversationInitial());
  final SocketService socketService ;

  final FetchConversationUseCase fetchConversationUseCase;

  void setupConversations() {
    fetchConversations();
    initializeSocketListener();
  }


  void initializeSocketListener() {
    try {
      socketService.socket.on(
        'conversationUpdated',
        onConversationUpdated,
      );
    }  catch (e) {
      print('errorrrrr ${e.toString()}');
    }
  }

  onConversationUpdated(data) {
    fetchConversations();
  }

  Future<void> fetchConversations() async {
    emit(ConversationLoading());
    var result = await fetchConversationUseCase();
    result.when(
      success: (data) {
        emit(ConversationLoaded(data));
      },
      failure: (errorMessage) {
        emit(ConversationError(errorMessage));
      },
    );
  }


}
