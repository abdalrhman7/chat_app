import 'package:chat_app/chat_screen.dart';
import 'package:chat_app/core/di/dependancy_injection.dart';
import 'package:chat_app/core/routing/routes.dart';
import 'package:chat_app/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:chat_app/feature/auth/presentation/screen/login_screen.dart';
import 'package:chat_app/feature/auth/presentation/screen/register_screen.dart';
import 'package:chat_app/message_screen.dart';
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
        case Routes.chatScreen:
        return MaterialPageRoute(
          builder: (_) => const ChatScreen(),
        );
        case Routes.messageScreen:
        return MaterialPageRoute(
          builder: (_) => const MessageScreen(),
        );
      default:
        return null;
    }
  }
}
