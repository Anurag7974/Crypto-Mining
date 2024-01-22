// import 'package:btcmining/constants/sizes.dart';
// import 'package:btcmining/signupLogin/screen/opt_screen.dart';
// import 'package:btcmining/signupLogin/screen/signup_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../Profile/update_profile_screen.dart';
// import '../../View/navBar.dart';
// import '../../constants/text_strings.dart';
// import 'forget_password_mail.dart';
//
// class LoginForm extends StatelessWidget {
//   const LoginForm({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 25.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(
//                     prefixIcon: Icon(Icons.person_outline_outlined),
//                     labelText: tEmail,
//                     hintText : tEmail,
//                     border: OutlineInputBorder()
//                 ),
//               ),
//               const SizedBox(height: tFormHeight -20,),
//               TextFormField(
//                 decoration: const InputDecoration(
//                     prefixIcon: Icon(Icons.fingerprint),
//                     labelText: tPassword,
//                     hintText : tPassword,
//                     border: OutlineInputBorder(),
//                     suffixIcon: IconButton(onPressed: null, icon: Icon(Icons.remove_red_eye_sharp))
//                 ),
//               ),
//
//               // -- FORGET PASSWORD BTN
//               const SizedBox(height: tFormHeight - 20),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(onPressed: (){
//                   showModalBottomSheet(context: context,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), builder: (context) => Container(
//                     padding: const EdgeInsets.all(tDefaultSize),
//
//                     /* --Section-1 Header Code -- */
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(tForgetPasswordTitle, style: Theme.of(context).textTheme.headline4),
//                         Text(tForgetPasswordSubTitle, style: Theme.of(context).textTheme.bodyText2),
//                         const SizedBox(height: 30.0),
//                         /* -- End Code -- */
//
//                         /* --Section-2 E-Mail Code -- */
//                         GestureDetector(
//                           onTap: (){
//                             Navigator.pop(context);
//                             Get.to(() => const ForgetPasswordMailScreen());
//                             // Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPasswordMailScreen(),),);
//                             },
//                           child: Container(
//                             padding: const EdgeInsets.all(20.0),
//                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.grey.shade200),
//                             child: Row(
//                               children: [
//                                 const Icon(Icons.mail_outline_rounded, size: 60.0),
//                                 const SizedBox(width: 10.0),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(tEmail, style: Theme.of(context).textTheme.headline6),
//                                     Text(tResetViaEmail, style: Theme.of(context).textTheme.bodyText2),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         /* -- End Code -- */
//
//                         /* --Section-3 Phone No. Code -- */
//                         const SizedBox(height: 20.0),
//                         GestureDetector(
//                           onTap: (){
//                             Navigator.pop(context);
//                             Get.to(() => const OTPScreen());
//                             // Navigator.push(context, MaterialPageRoute(builder: (context) => const OTPScreen(),),);
//                             },
//                           child: Container(
//                             padding: const EdgeInsets.all(20.0),
//                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.grey.shade200),
//                             child: Row(
//                               children: [
//                                 const Icon(Icons.mobile_friendly_rounded, size: 60.0),
//                                 const SizedBox(width: 10.0),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(tPhoneNo, style: Theme.of(context).textTheme.headline6),
//                                     Text(tResetViaPhone, style: Theme.of(context).textTheme.bodyText2),
//
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         /* -- End Code -- */
//
//                       ],
//                     ),
//                   ),);
//                   }, child: Text(tForgetPassword)),
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(onPressed: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => const NavBar()));
//                 },
//                   child: Text(tLogin.toUpperCase()),
//                 ),
//               ),
//             ],
//           ),
//         )
//     );
//   }
// }