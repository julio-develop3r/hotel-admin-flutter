import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locks_flutter/shared/print.dart';

class AppService extends ChangeNotifier {
  factory AppService() => _instance;

  /// Ensure to make this as a singleton class.
  AppService._();

  static AppService get instance => _instance;
  static final AppService _instance = AppService._();

  UserCredential? credential;

  void setCredential(UserCredential? cred) {
    credential = cred;
    notifyListeners();
  }

  Future<void> logout() async {
    credential = null;

    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      printError('[logout] ${e.toString}`');
    }

    notifyListeners();
  }
}
