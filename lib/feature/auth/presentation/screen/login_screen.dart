import 'package:chat_app/core/routing/routes.dart';
import 'package:chat_app/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:chat_app/feature/auth/presentation/widget/register_button.dart';
import 'package:chat_app/feature/auth/presentation/widget/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              TextInput(
                controller: _emailController,
                hint: 'Email',
                icon: Icons.email,
              ),
              const SizedBox(height: 20),
              TextInput(
                controller: _passwordController,
                hint: 'Password',
                icon: Icons.lock,
              ),
              const SizedBox(height: 20),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                  if (state is AuthSuccess) {
                    Navigator.of(context).pushNamed(Routes.messageScreen);
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return AuthButton(
                    text: 'Login',
                    onPressed: () {
                      context.read<AuthCubit>().login(
                          _emailController.text, _passwordController.text);
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              buildLoginPrompt()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoginPrompt() {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(Routes.registerScreen);
        },
        child: RichText(
          text: const TextSpan(
              text: 'Don\'t have an account? ',
              style: TextStyle(color: Colors.grey),
              children: [
                TextSpan(
                  text: 'Click here to register',
                  style: TextStyle(color: Colors.blue),
                ),
              ]),
        ),
      ),
    );
  }
}
