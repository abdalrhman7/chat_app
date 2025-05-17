import 'package:chat_app/core/netwoking/api_result.dart';
import 'package:chat_app/feature/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<ApiResult<UserEntity>> login(String email, String password);
  Future<ApiResult<UserEntity>> register({required String email,required String password ,required String username});
}