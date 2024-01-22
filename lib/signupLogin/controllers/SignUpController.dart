// import 'package:btcmining/Model/user_model.dart';
// import 'package:btcmining/View/navBar.dart';
// import 'package:btcmining/signupLogin/controllers/authentication_repository.dart';
// import 'package:btcmining/signupLogin/controllers/user_repository.dart';
// import 'package:btcmining/signupLogin/screen/opt_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class SignUpController extends GetxController{
//   static SignUpController get instance => Get.find();
//   // final formKey = GlobalKey<FormState>();
//
//   // Loader
//   final isLoading = false.obs;
//   // Future<void> createUser() async {
//   //   try {
//   //     isLoading.value = true;
//   //     if (!signupFromKey.currentState!.validate()){
//   //
//   //     }
//   //   }
//   // }
//
// //  TextField Controllers to get data from TextField
//   final email = TextEditingController();
//   final password = TextEditingController();
//   final fullName = TextEditingController();
//   final phoneNo = TextEditingController();
//
//   final userRepo = Get.put(UserRepository());
//   /// Register New User using either [EmailAndPassword] OR [PhoneNumber] authentication.
//   Future<void> createUser(UserModel user) async{
//     await userRepo.createUser(user);
//     // phoneAuthentication(user.phoneNo);
//     // Get.to(() => const OTPScreen());
//     registerUser(user.email, user.password);
//     Get.to(() => const NavBar());
//   }
//
//   //
//   // /// [PhoneNoAuthentication]
//   void phoneAuthentication(String phoneNo) async {
//     try {
//       await AuthenticationRepository.instance.phoneAuthentication(phoneNo);
//     } catch (e) {
//       throw e.toString();
//     }
//   }
//
// //  Call this Function from Design & it will do the rest
//   void registerUser(String email, String password){
//    String? error =  AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password) as String;
//    if (error != null) {
//      Get.showSnackbar(GetSnackBar(message: error.toString(),));
//    }
//   }
//
// }