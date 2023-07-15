import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class Mang extends StatefulWidget {
  const Mang({Key? key}) : super(key: key);

  @override
  State<Mang> createState() => _MangState();
}

class _MangState extends State<Mang> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  double value = 0;
  @override
  Widget build(BuildContext context) {
    final child = Center(
      child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return ShaderBuilder(
              (context, shader, child) {
                return AnimatedSampler(
                  (image, size, canvas) {
                    // Set the values for resolution and iTime
                    shader.setFloat(0, size.width);
                    shader.setFloat(1, size.height);
                    shader.setFloat(2, 30);
                    shader.setFloat(3, 30);

                    // shader.setImageSampler(0, image);
                    value += 0.3;
                    canvas.drawRect(
                      Rect.fromLTWH(0, 0, size.width, size.height),
                      Paint()..shader = shader,
                      // ..blendMode = BlendMode.screen,
                    );
                  },
                  // child: const Icon(
                  //   Icons.add_business_sharp,
                  //   size: 200,
                  // ),
                  child: FlutterLogo(
                    size: 80,
                    // style: FlutterLogoStyle.stacked,
                  ),
                  // child: FilledButton(
                  //   onPressed: () {},
                  //   child: const Text(
                  //     "Click here",
                  //     style: TextStyle(fontSize: 40),
                  //   ),
                  // ),
                );
              },
              assetKey: 'shaders/mang.frag',
            );
          }),
    );
    return Scaffold(
      backgroundColor: Colors.green,
      body: child,
    );
  }
}
