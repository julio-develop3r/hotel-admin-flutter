import 'package:flutter/material.dart';

abstract class StatusTypes {
  static const String available = 'Disponible';
  static const String notAvailable = 'No disponible';
  static const String salto = 'SALTO';
  static const String inProgress = 'En progreso';
  static const String priority = 'Prioridad';
}

const Map<String, Color> colorStatus = <String, Color>{
  StatusTypes.available: Colors.green,
  StatusTypes.notAvailable: Colors.red,
  StatusTypes.salto: Colors.blue,
  StatusTypes.inProgress: Colors.pinkAccent,
  StatusTypes.priority: Colors.yellow
};
