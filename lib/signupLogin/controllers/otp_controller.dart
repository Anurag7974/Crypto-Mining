// import 'package:btcmining/signupLogin/controllers/authentication_repository.dart';
// import 'package:get/get.dart';
//
// import '../../View/navBar.dart';
//
// class OTPController extends GetxController {
//
//   static OTPController get instance => Get.find();
//
//   void verifyOTP(String otp) async {
//     var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
//     isVerified ? Get.offAll(const NavBar()) : Get.back();
//
//   }
// }