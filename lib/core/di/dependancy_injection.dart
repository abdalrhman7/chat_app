import 'package:chat_app/core/netwoking/dio_factory.dart';
import 'package:chat_app/feature/auth/data/datesources/auth_remote_date_source.dart';
import 'package:chat_app/feature/auth/data/repositories/auth_repo_impl.dart';
import 'package:chat_app/feature/auth/domain/repo/auth_repository.dart';
import 'package:chat_app/feature/auth/domain/usecases/login_usecase.dart';
import 'package:chat_app/feature/auth/domain/usecases/register_usecase.dart';
import 'package:chat_app/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();

  //login
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(dio),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepoImpl(getIt<AuthRemoteDataSource>()),
  );
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(repository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(repository: getIt<AuthRepository>()),
  );

  getIt.registerFactory<AuthCubit>(() => AuthCubit(
    loginUseCase: getIt<LoginUseCase>(),
    registerUseCase: getIt<RegisterUseCase>(),
  ));

  // signup
  // getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt<ApiService>()));
  // getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt<SignupRepo>()));
  //

  // login
  // getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt<ApiService>()));
  // getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<LoginRepo>()));
  //
}
