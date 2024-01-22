// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
//
// import '../../../constants/sizes.dart';
// import '../../../constants/text_strings.dart';
// import '../splash_screen_controller.dart';
//
// class TFadeInAnimation extends StatelessWidget {
//   const TFadeInAnimation({
//     super.key,
//     required this.splashController,
//   });
//
//   final SplashScreenController splashController;
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx( () => AnimatedPositioned(
//         duration: const Duration(milliseconds: 1600),
//         top: 80,
//         left: splashController.animate.value ? tDefaultSize : -80,
//         child: AnimatedOpacity(
//           duration: const Duration(milliseconds: 1600),
//           opacity: splashController.animate.value ? 1 : 0,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(tAppName, style:  Theme.of(context).textTheme.headlineLarge , ),
//               Text(tAppTagLine, style: Theme.of(context).textTheme.headlineSmall,)
//             ],
//           ),
//         )
//     ),
//     );
//   }
// }