part of 'contacts_cubit.dart';

@immutable
sealed class ContactsState {}

final class ContactsInitial extends ContactsState {}

final class ContactsLoading extends ContactsState {}

final class ContactsLoaded extends ContactsState {
 final List<ContactsEntity> contacts;

  ContactsLoaded({required this.contacts});
}

final class ContactsError extends ContactsState {
  final String errorMessage;

  ContactsError({required this.errorMessage});
}

final class ContactsAdded extends ContactsState {}

final class ConversationReady extends ContactsState {
  final String conversationId;
  final String contactName;

  ConversationReady({required this.conversationId, required this.contactName});
}
