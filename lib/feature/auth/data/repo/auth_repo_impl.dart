import 'package:chat_app/core/netwoking/api_result.dart';
import 'package:chat_app/feature/auth/data/datesources/auth_remote_date_source.dart';
import 'package:chat_app/feature/auth/domain/entities/user_entity.dart';
import 'package:chat_app/feature/auth/domain/repo/auth_repository.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImpl(this.authRemoteDataSource);

  @override
  Future<ApiResult<UserEntity>> login(String email, String password) async {
    try {
      var result = await authRemoteDataSource
          .login({"email": email, "password": password});
      return ApiResult.success(result);
    } catch (e) {
      print('errorrrrr ${e.toString()}');
      return ApiResult.failure(e.toString());
    }
  }

  @override
  Future<ApiResult<UserEntity>> register({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      var result = await authRemoteDataSource.register(
        {"email": email, "password": password, "username": username},
      );
      return ApiResult.success(result);
    } catch (e) {
      print(' errorrrrr ${e.toString()}');
      return ApiResult.failure(e.toString());
    }
  }
}
