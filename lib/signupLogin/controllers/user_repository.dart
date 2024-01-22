 /*
  =========================
  Todo: Step - 2 [User Repository to perform Database Operations]
  =========================
*/


import 'package:btcmining/Model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class UserRepository extends GetxController {
//   static UserRepository get instance => Get.find();
//
//   final _dp = FirebaseFirestore.instance;
//
//   // Store user in FireStore
//   createUser(UserModel user) async {
//    await _dp.collection("Users").add(user.toJson()).whenComplete(() {
//      Get.snackbar("Success", "You account has been created.",
//          snackPosition: SnackPosition.BOTTOM,
//          backgroundColor: Colors.green.withOpacity(0.1),
//          colorText: Colors.green,
//      );
//    }).catchError((error, stackTrace){
//       Get.snackbar("Error", "Something went wrong. Try again",
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.redAccent.withOpacity(0.1),
//       colorText: Colors.red);
//       print("ERROR - $error");
//       });
//   }
//
//  // Step 2 - FeTch ALL Users OR User details
//   Future<UserModel> getUserDetails(String email) async {
//     final snapshot = await _dp.collection("Users").where("Email", isEqualTo: email).get();
//     final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
//     return userData;
//   }
//
//   Future<List<UserModel>> allUser() async {
//     final snapshot = await _dp.collection("Users").get();
//     final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
//     return userData;
//   }
//
//   Future<void> updateUserRecord(UserModel user) async {
//     await _dp.collection("Users").doc(user.id).update(user.toJson());
//   }
// }