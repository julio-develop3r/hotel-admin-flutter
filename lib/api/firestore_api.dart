import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locks_flutter/shared/print.dart';

class FirestoreApi {
  factory FirestoreApi() => _singleton;

  FirestoreApi._internal() {
    _init();
  }

  static final FirestoreApi _singleton = FirestoreApi._internal();
  late final FirebaseFirestore firestore;

  static const bool isProduction = bool.fromEnvironment('dart.vm.product');

  void _init() {
    printSuccess('Init Firebase Api {isProduction: $isProduction}');
    firestore = FirebaseFirestore.instance;

    if (!isProduction) {
      final String host = Platform.isAndroid ? '10.0.2.2' : 'localhost';
      firestore.settings = const Settings(persistenceEnabled: false, sslEnabled: false);
      firestore.useFirestoreEmulator(host, 8080);
    }
  }
}
