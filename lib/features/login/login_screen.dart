import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locks_flutter/features/login/cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final LoginCubit bloc = LoginCubit();

    return BlocProvider<LoginCubit>(
      create: (_) => bloc,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(image: AssetImage('assets/logo.jpg')),
            Text(
              'Inicio de Sesión',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nombre de usuario',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _passController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Contraseña',
                ),
                obscureText: true,
              ),
            ),
            ElevatedButton(
              onPressed: () => bloc.login(email: _emailController.text, password: _passController.text),
              child: const Text('Iniciar sesión'),
            )
          ],
        ),
      ),
    );
  }
}
