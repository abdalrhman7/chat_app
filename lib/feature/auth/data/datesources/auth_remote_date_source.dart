import 'package:chat_app/core/netwoking/api_constants.dart';
import 'package:chat_app/feature/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_remote_date_source.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio, {String baseUrl}) = _AuthRemoteDataSource;

  @POST(ApiConstants.login)
  Future<UserModel> login(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.register)
  Future<UserModel> register(@Body() Map<String, dynamic> body);
}
