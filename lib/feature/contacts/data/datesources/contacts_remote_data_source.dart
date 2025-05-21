import 'package:chat_app/core/netwoking/api_constants.dart';
import 'package:chat_app/feature/auth/data/models/user_model.dart';
import 'package:chat_app/feature/chat/data/models/message_model.dart';
import 'package:chat_app/feature/contacts/data/models/contacts_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'contacts_remote_data_source.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ContactsRemoteDataSource {
  factory ContactsRemoteDataSource(Dio dio, {String baseUrl}) = _ContactsRemoteDataSource;

  // path parameter بدل query
  @GET(ApiConstants.contacts)
  Future<List<ContactsModel>> fetchContacts();

  @POST(ApiConstants.contacts)
  Future addContact(@Body() Map<String, dynamic> body);
}
