import 'package:flutter/material.dart';
import 'package:untitled/basic_shader.dart';
import 'package:untitled/widgets/blur_shader.dart';
import 'package:untitled/widgets/bubbles.dart';
import 'package:untitled/widgets/confetti.dart';
import 'package:untitled/widgets/electro_vibes.dart';
import 'package:untitled/widgets/frosted.dart';
import 'package:untitled/widgets/mang.dart';
import 'package:untitled/widgets/noise_blur.dart';
import 'package:untitled/widgets/shimmer.dart';
import 'package:untitled/widgets/shiny_button.dart';
import 'package:untitled/widgets/sliding_number.dart';
import 'package:untitled/widgets/sparkles.dart';

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Electro Vibes Sample'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ElectroVibesSample()),
              );
            },
          ),
          ListTile(
            title: const Text('Blur Shader'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BlurShader()),
              );
            },
          ),
          ListTile(
            title: const Text('Confetti Shader'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ConffettiShader()),
              );
            },
          ),
          ListTile(
            title: const Text('Shiny Button'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShinyButton()),
              );
            },
          ),
          ListTile(
            title: const Text('Shimmer'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Shimmer()),
              );
            },
          ),
          ListTile(
            title: const Text('Sparkles'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Sparkles()),
              );
            },
          ),
          ListTile(
            title: const Text('Noise Blur'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NoiseBlur()),
              );
            },
          ),
          ListTile(
            title: const Text('Frosted Glass'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FrostedGlass()),
              );
            },
          ),
          ListTile(
            title: const Text('Bubbles'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Bubbles()),
              );
            },
          ),
        ],
      ),
    );
  }
}
