import 'package:flutter/material.dart';
import 'package:untitled/basic_shader.dart';
import 'package:untitled/widgets/blur_shader.dart';
import 'package:untitled/widgets/confetti.dart';
import 'package:untitled/widgets/electro_vibes.dart';
import 'package:untitled/widgets/shiny_button.dart';
import 'package:untitled/widgets/sliding_number.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shaders Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const ElectroVibesSample(),
      // home: const BlurShader(),
      // home: const ConffettiShader(),
      home: const ShinyButton(),
    );
  }
}
