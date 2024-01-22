// import 'package:btcmining/Model/user_model.dart';
// import 'package:btcmining/constants/sizes.dart';
// import 'package:btcmining/signupLogin/controllers/helper_controller.dart';
// import 'package:btcmining/signupLogin/screen/opt_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../constants/colors.dart';
// import '../../constants/text_strings.dart';
// import '../controllers/SignUpController.dart';
// import 'login_screen.dart';
//
//
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final controller = Get.put(SignUpController());
//   final formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//             child: Container(
//               padding: const EdgeInsets.all(tDefaultSize),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   /* -- Section-1 (Header Code) --*/
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Image(image: const AssetImage("assets/image/bitcoin.png"),
//                         height: size.height * 0.2,),
//                       Text(tSignUpTitle, style: Theme.of(context).textTheme.headline3,),
//                       Text(tSignUpSubTitle, style: Theme.of(context).textTheme.bodyText1,),
//                     ],
//                   ),
//                   /* -- /.end --*/
//
//                   /* -- Section-2 (Form Code) --*/
//                   Container(
//                     padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
//                     child: Form(
//                       key: formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Obx(() => TextFormField(
//                               controller: controller.fullName,
//                               decoration:  const InputDecoration(label: Text(tFullName), border: OutlineInputBorder(), prefixIcon: Icon(Icons.person_outline_rounded,color: tSecondaryColor,),),
//                             ),
//                           ),
//                           const SizedBox(height: tFormHeight - 20,),
//
//                           Obx(() =>  TextFormField(
//                               controller: controller.email,
//                               decoration:  const InputDecoration(label: Text(tEmail), border: OutlineInputBorder(), prefixIcon: Icon(Icons.email_outlined, color: tSecondaryColor,)),
//                             ),
//                           ),
//                           const SizedBox(height: tFormHeight - 20,),
//
//                           Obx(() => TextFormField(
//                               controller: controller.phoneNo,
//                               decoration:  const InputDecoration(label: Text(tPhoneNo), border: OutlineInputBorder(), prefixIcon: Icon(Icons.numbers, color: tSecondaryColor,)),
//                             ),
//                           ),
//                           const SizedBox(height: tFormHeight - 20,),
//
//                           Obx(() =>  TextFormField(
//                               controller: controller.password,
//                               validator: Helper.validatePassword,
//                               // obscureText: controller.showPassword.value ? ,
//                               decoration:  const InputDecoration(
//                                   label: Text(tPassword),
//                                   border: OutlineInputBorder(),
//                                   prefixIcon: Icon(Icons.fingerprint),
//                                 // suffixIcon: IconButton(
//                                 //     icon: controller.s
//                                 //     onPressed: onPressed, icon: icon)
//
//                               ),
//
//                             ),
//                           ),
//                           const SizedBox(height: tFormHeight - 10,),
//                           SizedBox(
//                               width: double.infinity,
//                               child: ElevatedButton(onPressed: () {
//                                 if(formKey.currentState!.validate()){
//                                   // Email & Password Authentication
//                                   // SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());
//
//                                   // For Phone Authentication
//                                   // SignUpController.instance.phoneAuthentication(controller.phoneNo.text.trim());
//                                   // Get.to(const OTPScreen());
//
//                                   /*
//                                      ==================
//                                      Todo: Step - 3 [Get User and Pass it to Controller]
//                                      ==================
//                                    */
//                                   final user = UserModel(
//                                       email: controller.email.text.trim(),
//                                       password: controller.password.text.trim(),
//                                       fullName: controller.fullName.text.trim(),
//                                       phoneNo: controller.phoneNo.text.trim(),
//                                   );
//                                   SignUpController.instance.createUser(user);
//
//                                 }
//                               },
//                                   child: Text(tSignup.toUpperCase())))
//                         ],
//                       ),
//                     ),
//                   ),
//                   /* -- /.end --*/
//
//                   /* -- Section-3 (Footer Code) --*/
//                   Column(
//                     children: [
//                       const Text("OR"),
//                       SizedBox(
//                         width: double.infinity,
//                         child: OutlinedButton.icon(
//                           onPressed: () {},
//                           icon: const Image(image: AssetImage("assets/icons/google.png"), width: 20.0,),
//                           label: Text(tSignInWithGoole.toUpperCase()),),
//                       ),
//                       TextButton(onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
//                       },
//                         child: Text.rich(
//                             TextSpan(
//                                 children: [
//                                   TextSpan(text: tAlreadyHaveAnAccount, style: Theme.of(context).textTheme.bodyText1,),
//                                   TextSpan(text: " "+ tLogin.toUpperCase())
//                                 ]
//                             )
//                         ),
//                       )
//                     ],
//                   )
//                   /* -- /.end --*/
//                 ],
//               ),
//             )),
//       ),
//     );
//   }
// }