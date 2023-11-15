import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ithub_quiz/app_widget.dart';
import 'package:ithub_quiz/module/app_module.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: const IthubQuiz()));
}
