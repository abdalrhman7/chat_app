part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoadingState extends ChatState {}

final class ChatLoadedState extends ChatState {
  final List<MessageEntity> messages;
  ChatLoadedState(this.messages);
}

final class ChatErrorState extends ChatState {
  final String errorMessage;
  ChatErrorState(this.errorMessage);
}

