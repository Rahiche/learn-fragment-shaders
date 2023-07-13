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
    final child = AnimatedBuilder(
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
                  // shader.setFloat(3, animation2.value);

                  shader.setImageSampler(0, image);
                  value += 0.02;
                  canvas.drawRect(
                    Rect.fromLTWH(0, 0, size.width, size.height),
                    Paint()..shader = shader,
                  );
                },
                child: Center(
                  child: const Icon(
                    Icons.add_business_sharp,
                    size: 200,
                  ),
                ),
                // child: TextButton(
                //   onPressed: () {},
                //   child: Text("Click here"),
                // ),
              );
            },
            assetKey: 'shaders/light_sweep.frag',
          );
        });
    return Scaffold(
      body: child,
    );
  }
}
