import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _name;
  int? _age;
  String? _condition;
  bool? _medicationReminders;

  String? get name => _name;
  int? get age => _age;
  String? get condition => _condition;
  bool? get medicationReminders => _medicationReminders;

  void updateUser(String name, int age, String condition, bool reminders) {
    _name = name;
    _age = age;
    _condition = condition;
    _medicationReminders = reminders;
    notifyListeners();
  }
}