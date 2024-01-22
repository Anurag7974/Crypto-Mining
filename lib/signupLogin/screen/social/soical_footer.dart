// import 'package:btcmining/constants/colors.dart';
// import 'package:btcmining/constants/sizes.dart';
// import 'package:btcmining/signupLogin/controllers/login_controller.dart';
// import 'package:btcmining/signupLogin/screen/social/tSocialButton.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../../../constants/text_strings.dart';
//
// class SocialFooter extends StatelessWidget {
//   const SocialFooter({
//     Key? key,
// }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//       final controller = Get.put(LoginController());
//       return Container(
//         padding: const EdgeInsets.only(top: tDefaultSpace * 1.5, bottom: tDefaultSpace),
//         child: Column(
//           children: [
//             Obx(() => TSocialButton(
//                image: "assets/icons/google.png",
//               background: CupertinoColors.systemBlue,
//               foreground: CupertinoColors.destructiveRed,
//               text: '${tConnectWith.tr} ${tGoogle.tr}',
//               isLoading: controller.isGoogleLoading.value ? true : false,
//               onPressed: controller.isFacebookLoading.value || controller.isLoading.value
//                   ? () {}
//                   : controller.isGoogleLoading.value
//                   ? () {}
//                   : () => controller.googleSignIn(),
//             ),
//             ),
//             const SizedBox(height: 10,),
//             Obx(
//                 () => TSocialButton(
//                     text: '${tConnectWith.tr} ${tFacebook.tr}',
//                     image: "assets/icons/Facebook.png",
//                     foreground: tWhiteColor,
//                     background: CupertinoColors.systemBlue,
//                     onPressed: controller.isGoogleLoading.value || controller.isLoading.value
//                         ? () {}
//                         : controller.isFacebookLoading.value
//                         ? () {}
//                         : () => controller.facebookSignIn(),
//                 ),
//             ),
//             const SizedBox(height: tDefaultSpace * 2,),
//           ],
//         ),
//       );
//   }
// }
//
//
//
