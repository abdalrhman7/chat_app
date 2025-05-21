import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/core/services/socket_service.dart';
import 'package:chat_app/feature/conversation/domain/entities/conversation_entity.dart';
import 'package:chat_app/feature/conversation/domain/usecase/fetch_conversation_use_case.dart';
import 'package:chat_app/feature/conversation/domain/usecase/listen_conversation_updates_use_case.dart';
import 'package:meta/meta.dart';

part 'conversation_state.dart';

class ConversationCubit extends Cubit<ConversationState> {
  final FetchConversationUseCase fetchConversationUseCase;
  final ListenConversationUpdatesUseCase listenUpdatesUseCase;
  StreamSubscription<void>? _sub;

  ConversationCubit({
    required this.fetchConversationUseCase,
    required this.listenUpdatesUseCase,
  }) : super(ConversationInitial());

  void setupConversations() {
    _loadAndListen();
  }

  void _loadAndListen() {
    fetchConversations();

    _sub = listenUpdatesUseCase().listen((_) {
      fetchConversations();
    });
  }

  Future<void> fetchConversations() async {
    emit(ConversationLoading());
    final result = await fetchConversationUseCase();
    result.when(
      success: (data) => emit(ConversationLoaded(data)),
      failure: (err)     => emit(ConversationError(err)),
    );
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
