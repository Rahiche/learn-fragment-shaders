import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';
import 'package:untitled/widgets/sliding_number.dart';

class ElectroVibesSample extends StatefulWidget {
  const ElectroVibesSample({Key? key}) : super(key: key);

  @override
  State<ElectroVibesSample> createState() => _ElectroVibesSampleState();
}

class _ElectroVibesSampleState extends State<ElectroVibesSample> {
  int number = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () {
          number++;
          setState(() {});
        },
        child: Container(
          color: Colors.black,
          child: Center(
            child: Stack(
              children: [
                Center(
                    child: ElectroVibes(
                  number: number,
                )),
                Center(
                  child: SlidingNumber(
                    number: number,
                    initialAnimation: false,
                    style: const TextStyle(color: Colors.white, fontSize: 62),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ElectroVibes extends StatefulWidget {
  const ElectroVibes({
    Key? key,
    required this.number,
  }) : super(key: key);

  final int number;
  @override
  State<ElectroVibes> createState() => _ElectroVibesState();
}

class _ElectroVibesState extends State<ElectroVibes>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  late Animation animation2;
  double value = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    animation = Tween(begin: 0.1, end: 0.004).animate(animationController);
    animation2 = Tween(begin: 1.0, end: 5.0).animate(animationController);
    animationController.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant ElectroVibes oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.number != widget.number) {
      update();
    }
  }

  update() async {
    animation2 = Tween(begin: 5.0, end: 152.0).animate(animationController);
    await Future.delayed(const Duration(milliseconds: 800));
    animation2 = Tween(begin: 0.0, end: 0.0).animate(animationController);
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
          return ShaderBuilder(
            (context, shader, child) {
              return AnimatedSampler(
                (image, size, canvas) {
                  // Set the values for resolution and iTime
                  shader.setFloat(0, size.width);
                  shader.setFloat(1, size.height);
                  shader.setFloat(2, value);
                  shader.setFloat(3, animation2.value);

                  value += animation.value;
                  canvas.drawRect(
                    Rect.fromLTWH(0, 0, size.width, size.height),
                    Paint()..shader = shader,
                  );
                },
                child: const SizedBox(
                  width: 500,
                  height: 500,
                ),
              );
            },
            assetKey: 'shaders/electro.frag',
          );
        });
  }
}
