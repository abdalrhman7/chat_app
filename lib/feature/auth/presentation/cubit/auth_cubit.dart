import 'package:bloc/bloc.dart';
import 'package:chat_app/core/helper/shared_pref_helper.dart';
import 'package:chat_app/core/netwoking/dio_factory.dart';
import 'package:chat_app/feature/auth/domain/usecases/login_usecase.dart';
import 'package:chat_app/feature/auth/domain/usecases/register_usecase.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.registerUseCase, required this.loginUseCase})
      : super(AuthInitial());

  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    var result = await loginUseCase(email, password);
    result.when(
      success: (data) async{
        print('dataaaaaa ${data.token}');
       await SharedPrefHelper.setSecuredString('token', data.token!);
        await SharedPrefHelper.setSecuredString('userId', data.id);
        DioFactory.setTokenIntoHeaderAfterLogin(data.token!);
        emit(AuthSuccess('Login Success'));
      },
      failure: (errorMessage) {
        emit(AuthError(errorMessage));
      },
    );
  }

  Future<void> register({
    required String email,
    required String password,
    required String username,
  }) async {
    emit(AuthLoading());
    var result = await registerUseCase(email, password, username);
    result.when(
      success: (data) {

        emit(AuthSuccess('Register Success'));
      },
      failure: (errorMessage) {
        emit(AuthError(errorMessage));
      },
    );
  }
}
