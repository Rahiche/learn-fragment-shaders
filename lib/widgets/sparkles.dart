import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class Sparkles extends StatefulWidget {
  const Sparkles({Key? key}) : super(key: key);

  @override
  State<Sparkles> createState() => _SparklesState();
}

class _SparklesState extends State<Sparkles>
    with SingleTickerProviderStateMixin {
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
    final screenSize = MediaQuery.sizeOf(context);
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
                    shader.setFloat(2, value);

                    value += 0.03;
                    canvas.drawRect(
                      Rect.fromLTWH(0, 0, size.width, size.height),
                      Paint()..shader = shader,
                    );
                  },
                  // child: const Icon(
                  //   Icons.add_business_sharp,
                  //   size: 200,
                  // ),
                  child: Container(
                    width: screenSize.width,
                    height: screenSize.height,
                    // child: FilledButton(
                    //   onPressed: () {},
                    //   child: const Text(
                    //     "Click here",
                    //     style: TextStyle(fontSize: 40),
                    //   ),
                    // ),
                  ),
                );
              },
              assetKey: 'shaders/sparkles.frag',
            );
          }),
    );
    return Scaffold(
      body: Stack(
        children: [
          child,
          Center(
            child: FilledButton(
              onPressed: () {},
              child: const Text(
                "Click here",
                style: TextStyle(fontSize: 40),
              ),
            ),
          )
        ],
      ),
    );
  }
}
