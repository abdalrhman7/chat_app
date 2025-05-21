import 'package:chat_app/core/di/dependancy_injection.dart';
import 'package:chat_app/core/routing/routes.dart';
import 'package:chat_app/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:chat_app/feature/auth/presentation/screen/login_screen.dart';
import 'package:chat_app/feature/auth/presentation/screen/register_screen.dart';
import 'package:chat_app/feature/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_app/feature/chat/presentation/screen/chat_screen.dart';
import 'package:chat_app/feature/contacts/presentation/cubit/contacts_cubit.dart';
import 'package:chat_app/feature/contacts/presentation/screen/contacts_screen.dart';
import 'package:chat_app/feature/conversation/presentation/cubit/conversation_cubit.dart';
import 'package:chat_app/feature/conversation/presentation/screen/conversation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<AuthCubit>(),
            child: const LoginScreen(),
          ),
        );

      case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<AuthCubit>(),
            child: const RegisterScreen(),
          ),
        );

        case Routes.contactScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<ContactsCubit>()..fetchContacts(),
            child: const ContactsScreen(),
          ),
        );

      case Routes.chatScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final conversationId = args['conversationId'];
        final participantName = args['participantName'];
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider(
              create: (context) => getIt<ChatCubit>()..setConversationId(conversationId)..fetchMessages(),
              child:  ChatScreen(mate: participantName,),
            );
          },
        );

      case Routes.conversationScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                getIt<ConversationCubit>()..setupConversations(),
            child: const ConversationScreen(),
          ),
        );

      default:
        return null;
    }
  }
}
