import 'package:chat_app/core/netwoking/api_result.dart';
import 'package:chat_app/feature/contacts/domain/repo/contact_repo.dart';

class AddContactUseCase {
  final ContactsRepo contactsRepo;

  AddContactUseCase({required this.contactsRepo});

  Future<ApiResult> call({required String email}) {
    return contactsRepo.addContact(email: email);
  }
}
