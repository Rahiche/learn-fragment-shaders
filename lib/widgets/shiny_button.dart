import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class ShinyButton extends StatefulWidget {
  const ShinyButton({Key? key}) : super(key: key);

  @override
  State<ShinyButton> createState() => _ShinyButtonState();
}

class _ShinyButtonState extends State<ShinyButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    animationController.repeat();
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
                  // child: const Icon(
                  //   Icons.add_business_sharp,
                  //   size: 200,
                  // ),
                  child: FilledButton(
                    onPressed: () {},
                    child: const Text(
                      "Click here",
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
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
