import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class ConffettiShader extends StatefulWidget {
  const ConffettiShader({Key? key}) : super(key: key);

  @override
  State<ConffettiShader> createState() => _ConffettiShaderState();
}

class _ConffettiShaderState extends State<ConffettiShader>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  double value = 0;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Stack(
          children: [
            // TextButton(onPressed: () {}, child: Text("Hi")),
            Center(
              child: ShaderBuilder(
                (context, shader, child) {
                  return AnimatedSampler(
                    (image, size, canvas) {
                      // Set the values for resolution and iTime
                      shader.setFloat(0, size.width);
                      shader.setFloat(1, size.height);
                      shader.setFloat(2, value);
                      value = value + 0.05;
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
            ),
          ],
        );
      },
    );
  }

  Widget buildMaterial() {
    return Container(
      color: Colors.blue,
    );
  }
}
