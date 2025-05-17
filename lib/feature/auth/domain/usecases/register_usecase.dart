import 'package:chat_app/core/netwoking/api_result.dart';
import 'package:chat_app/feature/auth/domain/entities/user_entity.dart';
import 'package:chat_app/feature/auth/domain/repo/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<ApiResult<UserEntity>> call(String email, String password , String username) {
    return repository.register(email: email,password: password , username: username);
  }
}
