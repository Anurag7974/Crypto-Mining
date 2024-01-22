// import 'package:btcmining/Model/user_model.dart';
// import 'package:btcmining/signupLogin/controllers/user_repository.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// import 'authentication_repository.dart';
//
// class ProfileController extends GetxController {
//   static ProfileController get instance => Get.find();
//
//
//
//   // Repositories
//   final _authRepo = Get.put(AuthenticationRepository());
//   final _userRepo = Get.put(UserRepository());
//
//   // Step 3 - Get User Email and pass to UserRepository to fetch user record.
//   getUserData() {
//     final email = _authRepo.firebaseUser.value?.email;
//     if(email != null){
//       return _userRepo.getUserDetails(email);
//     }else {
//       Get.snackbar("Error", "Login to continue");
//     }
//   }
//
//   updateRecord(UserModel user) async {
//     await _userRepo.updateUserRecord(user);
//   }
// // }