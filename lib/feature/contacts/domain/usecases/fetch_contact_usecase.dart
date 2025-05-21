import 'package:chat_app/core/netwoking/api_result.dart';
import 'package:chat_app/feature/contacts/domain/entities/contact_entity.dart';
import 'package:chat_app/feature/contacts/domain/repo/contact_repo.dart';

class FetchContactUseCase {
  final ContactsRepo contactsRepo;

  FetchContactUseCase({required this.contactsRepo});

  Future<ApiResult<List<ContactsEntity>>> call() {
    return contactsRepo.getContacts();
  }

}