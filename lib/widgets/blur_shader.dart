import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class BlurShader extends StatefulWidget {
  const BlurShader({Key? key}) : super(key: key);

  @override
  State<BlurShader> createState() => _BlurShaderState();
}

class _BlurShaderState extends State<BlurShader> {
  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: buildMaterial(),
    // );
    return Center(
      child: ShaderBuilder(
        (context, shader, child) {
          return AnimatedSampler(
            (image, size, canvas) {
              // Set the values for resolution and iTime
              shader.setFloat(0, size.width / 3);
              shader.setFloat(1, size.height / 3);

              shader.setImageSampler(0, image);

              canvas.drawRect(
                Rect.fromLTWH(0, 0, size.width, size.height),
                Paint()..shader = shader,
              );
              // canvas.drawImage(image, Offset(0, 0), Paint());
            },
            child: buildMaterial(),
          );
        },
        assetKey: 'shaders/blur_single_pass.frag',
      ),
    );
  }

  Widget buildMaterial() {
    return Material(
      color: Colors.transparent,
      child: const Text(
        "Hi",
        style: TextStyle(color: Colors.blue, fontSize: 100),
      ),
    );
  }
}
