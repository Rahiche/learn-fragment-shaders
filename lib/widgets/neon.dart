// import 'package:flutter/material.dart';
// import 'package:flutter_shaders/flutter_shaders.dart';
//
// class NeonBorder extends StatefulWidget {
//   const NeonBorder({
//     super.key,
//     required this.slow,
//   });
//
//   final bool slow;
//
//   @override
//   State<NeonBorder> createState() => _NeonBorderState();
// }
//
// class _NeonBorderState extends State<NeonBorder>
//     with SingleTickerProviderStateMixin {
//   late AnimationController animationController;
//   late Animation animation;
//   late Animation animation2;
//   double value = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     animationController = AnimationController(
//       vsync: this,
//       // duration: AppDurations.verySlow * 10,
//     );
//     animation = Tween(begin: 0.1, end: 0.004).animate(animationController);
//     animation2 =
//         Tween(begin: widget.slow ? 1.0 : 5.0, end: widget.slow ? 5.0 : 52.0)
//             .animate(animationController);
//     animationController.repeat(reverse: true);
//   }
//
//   @override
//   void dispose() {
//     animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void reassemble() {
//     // TODO: implement reassemble
//     super.reassemble();
//
//     // animation = Tween(begin: 0.1, end: 0.004).animate(animationController);
//     // animation2 = Tween(begin: 1.0, end: 52.0).animate(animationController);
//     // animationController.repeat(reverse: true);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Center(
//           child: AnimatedBuilder(
//             animation: animationController,
//             builder: (BuildContext context, Widget? child) {
//               return ShaderBuilder((context, shader, child) {
//                 return AnimatedSampler(
//                   (image, size, canvas) {
//                     // Set the values for resolution and iTime
//                     shader.setFloat(0, size.width);
//                     shader.setFloat(1, size.height);
//                     shader.setFloat(2, value);
//
//                     shader.setImageSampler(0, image); // calmLevel
//
//                     value += .1;
//
//                     canvas.drawRect(
//                       Rect.fromLTWH(0, 0, size.width, size.height),
//                       Paint()
//                         ..shader = shader
//                         ..blendMode = BlendMode.luminosity,
//                     );
//                   },
//                   // child: CustomButton.outlineLarge(
//                   //   text: "Naw, I Got This",
//                   //   onPressed: () {
//                   //     Navigator.of(context).pop(false);
//                   //   },
//                   // ),
//                 );
//               }, assetKey: 'shaders/border.frag');
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
