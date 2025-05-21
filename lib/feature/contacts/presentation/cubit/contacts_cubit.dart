import 'package:bloc/bloc.dart';
import 'package:chat_app/feature/contacts/domain/entities/contact_entity.dart';
import 'package:chat_app/feature/contacts/domain/usecases/add_contact_usecase.dart';
import 'package:chat_app/feature/contacts/domain/usecases/fetch_contact_usecase.dart';
import 'package:chat_app/feature/conversation/domain/usecase/check_or_create_conversation_use_case.dart';
import 'package:meta/meta.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit(
      {required this.fetchContactUseCase,
      required this.addContactUseCase,
      required this.checkOrCreateConversationUseCase})
      : super(ContactsInitial());

  final FetchContactUseCase fetchContactUseCase;
  final AddContactUseCase addContactUseCase;
  final CheckOrCreateConversationUseCase checkOrCreateConversationUseCase;

  Future<void> checkOrCreateConversation(
      {required String contactId, required String contactName}) async {
    emit(ContactsLoading());
    final result = await checkOrCreateConversationUseCase(contactId: contactId);
    result.when(
        success: (conversationId) {
          emit(
            ConversationReady(
              conversationId: conversationId,
              contactName: contactName,
            ),
          );
        },
        failure: (errorMessage) {
          emit(ContactsError(errorMessage: 'failed to create conversation'));
        });
  }

  Future<void> fetchContacts() async {
    emit(ContactsLoading());
    final contacts = await fetchContactUseCase();
    contacts.when(
      success: (data) {
        emit(ContactsLoaded(contacts: data));
      },
      failure: (errorMessage) {
        emit(ContactsError(errorMessage: errorMessage));
      },
    );
  }

  Future<void> addContact(String email) async {
    emit(ContactsLoading());
    final contacts = await addContactUseCase(email: email);
    contacts.when(
      success: (data) {
        emit(ContactsAdded());
        fetchContacts();
      },
      failure: (errorMessage) {
        emit(ContactsError(errorMessage: errorMessage));
      },
    );
  }
}
