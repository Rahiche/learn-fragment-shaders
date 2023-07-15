import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class NoiseBlur extends StatefulWidget {
  const NoiseBlur({Key? key}) : super(key: key);

  @override
  State<NoiseBlur> createState() => _NoiseBlurState();
}

class _NoiseBlurState extends State<NoiseBlur>
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
    final child = Center(
      child: Stack(
        children: [
          AnimatedBuilder(
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
                          Paint()..shader = shader
                          // ..blendMode = BlendMode.exclusion,
                          );
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Image.network(
                            "https://i.imgur.com/4bXbEAl.jpeg",
                            // "https://vmagazine.com/wp-content/uploads/2022/04/thumbnail_IMG_3862-1.jpg",
                            fit: BoxFit.fill,
                            width: MediaQuery.sizeOf(context).width / 2,
                          ),
                        ),
                        Expanded(
                          child: Image.network(
                            // "https://i.imgur.com/4bXbEAl.jpeg",
                            "https://vmagazine.com/wp-content/uploads/2022/04/thumbnail_IMG_3862-1.jpg",
                            fit: BoxFit.fill,
                            width: MediaQuery.sizeOf(context).width / 2,
                          ),
                        ),
                      ],
                    ),
                    // child: FlutterLogo(
                    //   size: 200,
                    // ),
                    // child: const Icon(
                    //   Icons.add_business_sharp,
                    //   size: 200,
                    //   color: Colors.green,
                    // ),
                  );
                },
                assetKey: 'shaders/noise_blur.glsl',
                // assetKey: 'shaders/frosted.frag',
              );
            },
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Center(
          //         child: Image.network(
          //           "https://i.imgur.com/4bXbEAl.jpeg",
          //           // "https://vmagazine.com/wp-content/uploads/2022/04/thumbnail_IMG_3862-1.jpg",
          //           fit: BoxFit.fill,
          //           width: 200,
          //           height: 200,
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       child: Center(
          //         child: Image.network(
          //           // "https://i.imgur.com/4bXbEAl.jpeg",
          //           "https://vmagazine.com/wp-content/uploads/2022/04/thumbnail_IMG_3862-1.jpg",
          //           fit: BoxFit.fill,
          //           width: 200,
          //           height: 200,
          //         ),
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    );
    return Scaffold(
      body: child,
    );
  }
}
