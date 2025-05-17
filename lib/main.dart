import 'package:chat_app/core/theme.dart';
import 'package:chat_app/feature/auth/presentation/screen/register_screen.dart';
import 'package:flutter/material.dart';

import 'chat_screen.dart';
import 'core/di/dependancy_injection.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'feature/auth/presentation/screen/login_screen.dart';
import 'message_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  runApp(
    MyApp(
      appRouter: AppRouter(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
      initialRoute:  Routes.loginScreen,
    );
  }
}
