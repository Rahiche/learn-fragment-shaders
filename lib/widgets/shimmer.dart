import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class Shimmer extends StatefulWidget {
  const Shimmer({Key? key}) : super(key: key);

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
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
                    shader.setFloat(2, value);

                    shader.setImageSampler(0, image);
                    value += 0.03;
                    canvas.drawRect(
                      Rect.fromLTWH(0, 0, size.width, size.height),
                      Paint()..shader = shader,
                    );
                  },
                  child: ShimmerList(),
                );
              },
              assetKey: 'shaders/light_sweep.frag',
            );
          }),
    );
    return Scaffold(
      body: child,
    );
  }
}

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800; // Default time for the shimmer effect.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer List'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 800 + offset;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.black54,
              ),
              height: 100.0,
            ),
          );
        },
      ),
    );
  }
}
