import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class Bubbles extends StatefulWidget {
  const Bubbles({Key? key}) : super(key: key);

  @override
  State<Bubbles> createState() => _BubblesState();
}

class _BubblesState extends State<Bubbles> with SingleTickerProviderStateMixin {
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
  double count = 0.01;

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
                    shader.setFloat(0, size.width / 10);
                    shader.setFloat(1, size.height / 5);
                    shader.setFloat(2, value);
                    shader.setFloat(3, count);

                    value += 0.03;
                    canvas.drawRect(
                      Rect.fromLTWH(0, 0, size.width, size.height),
                      Paint()..shader = shader,
                    );
                  },
                  child: SizedBox(
                    width: screenSize.width,
                    height: screenSize.height,
                  ),
                );
              },
              assetKey: 'shaders/fluid_bubbles.frag',
            );
          }),
    );
    return Scaffold(
      body: Stack(
        children: [
          child,
          Center(
            child: FilledButton(
              onPressed: () {
                count = count + 0.001;
                setState(() {});
              },
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
