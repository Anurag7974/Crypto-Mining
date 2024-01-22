// import 'package:btcmining/constants/sizes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../constants/text_strings.dart';
// import 'opt_screen.dart';
//
// class ForgetPasswordMailScreen extends StatelessWidget {
//   const ForgetPasswordMailScreen({Key ? key}) : super (key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.all(tDefaultSize),
//             child: Column(
//               children: [
//                 const SizedBox(height: tDefaultSize * 4),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     /* -- Section-1 -- */
//                     Column(
//                       children: [
//                         Image(image: const AssetImage("assets/image/forget.png"), height: size.height * 0.2,),
//                         const SizedBox(height: 40.0),
//                         Text(tForgetPassword, style: Theme.of(context).textTheme.headline4,  textAlign:TextAlign.center, ),
//                         Text(tForgetPasswordSubTitle, style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.center,),
//                         /* --End Section-- */
//
//                         /* -- Section-2 -- */
//                         const SizedBox(height: tFormHeight),
//                         Form(
//                             child: Column(
//                               children: [
//                                 TextFormField(
//                                   decoration: const InputDecoration(label: Text(tEmail), hintText: tEmail, prefixIcon: Icon(Icons.mail_outline_rounded)),
//                                 ),
//                                 const SizedBox(height: 20.0),
//                                 SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){Get.to(() => const OTPScreen());}, child: Text(tNext),)),
//                               ],
//                             )
//                         )
//                         /* -- End Section -- */
//                       ],
//                     ),
//                   ],
//                 ),
//               ],),
//           ),
//         ),
//       ),
//     );
//   }
//
// }