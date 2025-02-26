import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:locks_flutter/app/app_service.dart';
import 'package:locks_flutter/shared/print.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    printWarning('email: $email');
    printWarning('pass: $password');

    try {
      final UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      AppService.instance.setCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        printError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        printError('Wrong password provided for that user.');
      }
    }
  }
}
