import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class BasicShader extends StatefulWidget {
  const BasicShader({Key? key}) : super(key: key);

  @override
  State<BasicShader> createState() => _BasicShaderState();
}

class _BasicShaderState extends State<BasicShader> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: ShaderBuilder(
          (context, shader, child) {
            return AnimatedSampler(
              (image, size, canvas) {
                // Set the values for resolution and iTime
                shader.setFloat(0, Colors.blue.red / 255); // color red
                shader.setFloat(1, Colors.blue.green / 255); // color green
                shader.setFloat(2, Colors.blue.blue / 255); // color blue
                //
                // canvas.drawRect(
                //   Rect.fromLTWH(0, 0, size.width, size.height),
                //   Paint()..shader = shader,
                // );

                canvas.drawCircle(
                  Offset(size.width / 2, size.height / 2),
                  size.height / 2,
                  Paint()..shader = shader,
                );
              },
              child: const SizedBox(
                width: 500,
                height: 500,
              ),
            );
          },
          // assetKey: 'shaders/circle.frag',
          assetKey: 'shaders/hello_world.frag',
        ),
      ),
    );
  }
}
