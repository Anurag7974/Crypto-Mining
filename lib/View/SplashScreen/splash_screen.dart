// import 'package:btcmining/View/SplashScreen/splash_screen_controller.dart';
// import 'package:btcmining/View/splash.dart';
// import 'package:btcmining/constants/colors.dart';
// import 'package:btcmining/constants/image_strings.dart';
// import 'package:btcmining/constants/sizes.dart';
// import 'package:btcmining/constants/text_strings.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'fade_in_animation/animation_design.dart';
//
// class SplashScreen extends StatelessWidget {
//   SplashScreen({Key? key}) : super(key: key);
//
//   final splashController = Get.put(SplashScreenController());
//
//   @override
//   Widget build(BuildContext context) {
//     splashController.startAnimation();
//     return Scaffold(
//       body: Stack(
//         children: [
//           // AnimatedPositioned(
//           //   duration: const Duration(milliseconds: 1600),
//           //   top: animate ?  0 : -30,
//           //     left: animate ?  0 : -30,
//           //     child: Image(image: AssetImage(tSplashTopIcon),)),
//           TFadeInAnimation(splashController: splashController),
//           Obx( () => AnimatedPositioned(
//                 duration: const Duration(milliseconds: 2400),
//                 bottom: splashController.animate.value ? 100 : 0,
//                 child: AnimatedOpacity(
//                     duration: const Duration(milliseconds: 2000),
//                     opacity: splashController.animate.value ? 1 : 0,
//                     child: const Image(image: AssetImage(tSplashImage),))),
//           ),
//           Obx( () => AnimatedPositioned(
//                 duration: const Duration(milliseconds: 2400),
//                 bottom: splashController.animate.value ? 60 : 0,
//                 right: tDefaultSize,
//                 child: AnimatedOpacity(
//                   duration: const Duration(milliseconds: 2000),
//                   opacity: splashController.animate.value ? 1 : 0,
//                   child: Container(
//                     width: tSplashContainerSize,
//                     height: tSplashContainerSize,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(100),
//                       color: tPrimaryColor,
//                     ),
//                   ),
//                 )),
//           ),
//           Obx( () => AnimatedPositioned(
//                 duration: const Duration(milliseconds: 2400),
//                 bottom: splashController.animate.value ? 800 : 0,
//                 right: tDefaultSize,
//                 child: AnimatedOpacity(
//                   duration: const Duration(milliseconds: 2000),
//                   opacity: splashController.animate.value ? 1 : 0,
//                   child: Container(
//                     width: tSplashContainerSize,
//                     height: tSplashContainerSize,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(100),
//                       color: tPrimaryColor,
//                     ),
//                   ),
//                 )),
//           )
//         ],
//       ),
//     );
//   }
//
//
// }
//
