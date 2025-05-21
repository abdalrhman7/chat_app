import 'package:chat_app/core/netwoking/api_result.dart';
import 'package:chat_app/feature/contacts/domain/entities/contact_entity.dart';

abstract class ContactsRepo {
  Future<ApiResult<List<ContactsEntity>>> getContacts();
  Future<ApiResult> addContact({required String email});
}
