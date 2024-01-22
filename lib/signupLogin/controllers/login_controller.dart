// import 'package:btcmining/constants/text_strings.dart';
// import 'package:btcmining/signupLogin/controllers/authentication_repository.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// import 'helper_controller.dart';
//
// class LoginController extends GetxController {
//   static LoginController get instance => Get.find();
//
//  // TextField Controllers to get data from TextFields
//   final showPassword = false.obs;
//   final email = TextEditingController();
//   final password = TextEditingController();
//   GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
//
//   // Loader
//   final isLoading = false.obs;
//   final isGoogleLoading = false.obs;
//   final isFacebookLoading = false.obs;
//
//   // [EmailAndPasswordLogin]
//   Future<void> login() async {
//     try {
//       isLoading.value = true;
//       if (!loginFormKey.currentState!.validate()) {
//         isLoading.value = false;
//         return;
//       }
//       await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());
//     }catch (e) {
//       isLoading.value = false;
//       Helper.errorSnackBar(title: tOhSnap, message: e.toString());
//     }
//   }
//
//   // [GoogleSignInAuthentication]
//   // Future<void> googleSignIn() async {
//   //   try {
//   //     isGoogleLoading.value = true;
//   //     final auth =  AuthenticationRepository.instance;
//   //     await auth.signInWithGoogle();
//   //     isGoogleLoading.value = false;
//   //     AuthenticationRepository.instance.setInitialScreen(auth.firebaseUser);
//   //   } catch (e) {
//   //     isGoogleLoading.value = false;
//   //     Helper.errorSnackBar(title: tOhSnap, message: e.toString());
//   //   }
//   // }
//
//   /// [FacebookSignInAuthentication]
//   // Future<void> facebookSignIn() async {}
//
//   // // Call this Function from Design & it will do the rest
//   // Future<void> loginUser(String email, String password)  async {
//   //   String? error = AuthenticationRepository.instance.loginWithEmailAndPassword(email, password) as String?;
//   //   if(error != null){
//   //     Get.showSnackbar(GetSnackBar(message: error.toString()));
//   //   }
//   // }
//
// }