import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:to_do/app.dart';
import 'package:to_do/auth/login.dart';

void main() {
  Fimber.plantTree(DebugTree(useColors: true));

  runApp(ToDoApp());
}
