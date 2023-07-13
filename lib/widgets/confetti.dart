import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class ConffettiShader extends StatefulWidget {
  const ConffettiShader({Key? key}) : super(key: key);

  @override
  State<ConffettiShader> createState() => _ConffettiShaderState();
}

class _ConffettiShaderState extends State<ConffettiShader> {
  double value = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(const Duration(milliseconds: 40), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShaderBuilder(
        (context, shader, child) {
          return AnimatedSampler(
            (image, size, canvas) {
              // Set the values for resolution and iTime
              shader.setFloat(0, size.width / 3);
              shader.setFloat(1, size.height / 3);
              shader.setFloat(2, value);
              value++;
              canvas.drawImage(image, Offset(0, 0), Paint());
              canvas.drawRect(
                Rect.fromLTWH(0, 0, size.width, size.height),
                Paint()..shader = shader,
              );
            },
            child: buildMaterial(),
          );
        },
        assetKey: 'shaders/confetti.frag',
      ),
    );
  }

  Widget buildMaterial() {
    return Container(
      color: Colors.blue,
    );
  }
}
