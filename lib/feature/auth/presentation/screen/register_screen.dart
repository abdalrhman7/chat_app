import 'package:chat_app/core/routing/routes.dart';
import 'package:chat_app/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:chat_app/feature/auth/presentation/widget/register_button.dart';
import 'package:chat_app/feature/auth/presentation/widget/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
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
              TextInput(
                controller: _usernameController,
                hint: 'Username',
                icon: Icons.person,
              ),
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
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                  if (state is AuthSuccess) {
                    Navigator.of(context).pushNamed(Routes.loginScreen);
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return AuthButton(text: 'Register', onPressed: () {
                    context.read<AuthCubit>().register(email: _emailController.text, password: _passwordController.text, username: _usernameController.text);
                  },);
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
          Navigator.of(context).pushNamed(Routes.loginScreen);
        },
        child: RichText(
          text: const TextSpan(
              text: 'Already have an account? ',
              style: TextStyle(color: Colors.grey),
              children: [
                TextSpan(
                  text: 'Click here to login',
                  style: TextStyle(color: Colors.blue),
                ),
              ]),
        ),
      ),
    );
  }

}

