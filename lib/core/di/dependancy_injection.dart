import 'package:chat_app/core/netwoking/dio_factory.dart';
import 'package:chat_app/core/services/socket_service.dart';
import 'package:chat_app/feature/auth/data/datesources/auth_remote_date_source.dart';
import 'package:chat_app/feature/auth/data/repo/auth_repo_impl.dart';
import 'package:chat_app/feature/auth/domain/repo/auth_repository.dart';
import 'package:chat_app/feature/auth/domain/usecases/login_usecase.dart';
import 'package:chat_app/feature/auth/domain/usecases/register_usecase.dart';
import 'package:chat_app/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:chat_app/feature/chat/data/datesource/message_remote_datasource.dart';
import 'package:chat_app/feature/chat/data/repo/message_repo_impl.dart';
import 'package:chat_app/feature/chat/domain/repo/message_repo.dart';
import 'package:chat_app/feature/chat/domain/usecases/fetch_message_usecase.dart';
import 'package:chat_app/feature/chat/domain/usecases/join_conversation_use_case.dart';
import 'package:chat_app/feature/chat/domain/usecases/listen_messages_use_case.dart';
import 'package:chat_app/feature/chat/domain/usecases/send_message_use_case.dart';
import 'package:chat_app/feature/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_app/feature/contacts/data/datesources/contacts_remote_data_source.dart';
import 'package:chat_app/feature/contacts/data/repo/contacts_repo_impl.dart';
import 'package:chat_app/feature/contacts/domain/repo/contact_repo.dart';
import 'package:chat_app/feature/contacts/domain/usecases/fetch_contact_usecase.dart';
import 'package:chat_app/feature/contacts/presentation/cubit/contacts_cubit.dart';
import 'package:chat_app/feature/conversation/data/datesource/conversation_remote_datesource.dart';
import 'package:chat_app/feature/conversation/data/repo/conversation_repo_impl.dart';
import 'package:chat_app/feature/conversation/domain/repo/conversation_repo.dart';
import 'package:chat_app/feature/conversation/domain/usecase/check_or_create_conversation_use_case.dart';
import 'package:chat_app/feature/conversation/domain/usecase/fetch_conversation_use_case.dart';
import 'package:chat_app/feature/conversation/domain/usecase/listen_conversation_updates_use_case.dart';
import 'package:chat_app/feature/conversation/presentation/cubit/conversation_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../feature/contacts/domain/usecases/add_contact_usecase.dart'
    show AddContactUseCase;

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ISocketService>(() => SocketService());

  //auth
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

  //conversation
  getIt.registerLazySingleton<ConversationRemoteDataSource>(
    () => ConversationRemoteDataSource(dio),
  );

  getIt.registerLazySingleton<ConversationRepo>(
    () => ConversationRepoImpl( conversationRemoteDataSource: getIt<ConversationRemoteDataSource>() , socketService: getIt<ISocketService>()),
  );

  getIt.registerLazySingleton<FetchConversationUseCase>(
    () => FetchConversationUseCase(conversationRepo: getIt<ConversationRepo>()),
  );
  getIt.registerLazySingleton<CheckOrCreateConversationUseCase>(
    () => CheckOrCreateConversationUseCase(
        conversationRepo: getIt<ConversationRepo>()),
  );

  getIt.registerLazySingleton<ListenConversationUpdatesUseCase>(
        () => ListenConversationUpdatesUseCase(conversationRepo: getIt<ConversationRepo>()),
  );

  getIt.registerFactory<ConversationCubit>(() => ConversationCubit(
      fetchConversationUseCase: getIt<FetchConversationUseCase>(),
      listenUpdatesUseCase: getIt<ListenConversationUpdatesUseCase>(),
      ));

  //message
  getIt.registerLazySingleton<MessageRemoteDatasource>(
      () => MessageRemoteDatasource(dio));

  getIt.registerLazySingleton<MessageRepo>(() => MessageRepoImpl(
      messageRemoteDatasource: getIt<MessageRemoteDatasource>(),
      socketService: getIt<ISocketService>()));

  getIt.registerLazySingleton<FetchMessageUseCase>(
      () => FetchMessageUseCase(getIt<MessageRepo>()));

  getIt.registerLazySingleton<ListenMessagesUseCase>(
      () => ListenMessagesUseCase(getIt<MessageRepo>()));

  getIt.registerLazySingleton<JoinConversationUseCase>(
      () => JoinConversationUseCase(getIt<MessageRepo>()));

  getIt.registerLazySingleton<SendMessageUseCase>(
      () => SendMessageUseCase(getIt<MessageRepo>()));


  getIt.registerFactory<ChatCubit>(
    () => ChatCubit(
      fetchUseCase: getIt<FetchMessageUseCase>(),
      joinUseCase: getIt<JoinConversationUseCase>(),
      listenUseCase: getIt<ListenMessagesUseCase>(),
      sendUseCase: getIt<SendMessageUseCase>(),
    ),
  );

  // contact
  getIt.registerLazySingleton<ContactsRemoteDataSource>(
      () => ContactsRemoteDataSource(dio));

  getIt.registerLazySingleton<ContactsRepo>(
      () => ContactsRepoImpl(getIt<ContactsRemoteDataSource>()));

  getIt.registerLazySingleton<AddContactUseCase>(
      () => AddContactUseCase(contactsRepo: getIt<ContactsRepo>()));

  getIt.registerLazySingleton<FetchContactUseCase>(
      () => FetchContactUseCase(contactsRepo: getIt<ContactsRepo>()));

  getIt.registerFactory<ContactsCubit>(
    () => ContactsCubit(
      addContactUseCase: getIt<AddContactUseCase>(),
      fetchContactUseCase: getIt<FetchContactUseCase>(),
      checkOrCreateConversationUseCase:
          getIt<CheckOrCreateConversationUseCase>(),
    ),
  );
}
