import 'package:chat_app/core/netwoking/api_result.dart';
import 'package:chat_app/feature/contacts/data/datesources/contacts_remote_data_source.dart';
import 'package:chat_app/feature/contacts/domain/entities/contact_entity.dart';
import 'package:chat_app/feature/contacts/domain/repo/contact_repo.dart';

class ContactsRepoImpl implements ContactsRepo {
  final ContactsRemoteDataSource contactsRemoteDataSource;

  ContactsRepoImpl(this.contactsRemoteDataSource);

  @override
  Future<ApiResult> addContact({required String email}) async {
    try {
     await contactsRemoteDataSource.addContact({"contactEmail": email});
      return const ApiResult.success(true);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  @override
  Future<ApiResult<List<ContactsEntity>>> getContacts() async {
    try {
      var result = await contactsRemoteDataSource.fetchContacts();
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }
}
