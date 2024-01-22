// import 'package:btcmining/signupLogin/controllers/mail_verfication_controller.dart';
// import 'package:btcmining/signupLogin/screen/login_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import '../../View/navBar.dart';
// import '../../View/splash.dart';
// import 'SignUpWithEmailAndPasswordFailure.dart';
//
//
// /// -- README(Docs[6]) -- Bindings
// class AuthenticationRepository extends GetxController {
//   static AuthenticationRepository get instance => Get.find();
//
// //  Variables
//   final _auth = FirebaseAuth.instance;
//   late final Rx<User?> firebaseUser;
//   final verificationId = ''.obs;
// //
// //   /// Getters
// //   User? get firebaseUser => _firebaseUser.value;
// //   String get getUserID => firebaseUser?.uid ?? "";
// //   String get getUserEmail => firebaseUser?.email ?? "";
// //
// //
// //   //Will be load when app launches this func will be called and set the firebaseUser state
//   @override
//   void onReady(){
//     // Future.delayed(const Duration(seconds: 6));
//     firebaseUser = Rx<User?>(_auth.currentUser);
//     firebaseUser.bindStream(_auth.userChanges());
//     // FlutterNativeSplash.remove();
//     // setInitialScreen(_firebaseUser.value);
//     ever(firebaseUser, _setInitialScreen);
//   }
// //
// //   // Setting initial screen onLOAD
//   _setInitialScreen(User? user) {
//     user == null ? Get.offAll(() => const Splash()) : Get.offAll(() => const NavBar());
//         // : user.emailVerified ? Get.offAll(() => const NavBar())
//
//   }
// //
// //
// //   /* --------------------------------------- Email & Password sign-in ------------------------------------------------------------*/
// //
// //   /// [EmailAuthentication] - REGISTER
//   Future<void> createUserWithEmailAndPassword(String email, String password) async {
//     try {
//       await _auth.createUserWithEmailAndPassword(email: email, password: password);
//       firebaseUser.value != null ? Get.offAll(() => const NavBar()) : Get.to(() => const Splash());
//     } on FirebaseAuthException catch (e) {
//       final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
//       print('FIREBASE AUTH EXCEPTION - ${ex.message}');
//       throw ex;
//     } catch (_) {
//       const ex = SignUpWithEmailAndPasswordFailure();
//       print('EXCEPTION - ${ex.message}');
//       throw ex;
//     }
//   }
//
//   //   /// [EmailAuthentication] - LOGIN
//   Future<void> loginWithEmailAndPassword(String email, String password) async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//     } catch (_) {}
//   }
// //
//   Future<void> logout() async => await _auth.signOut();
// //
// //   /// [EmailVerification] - VERIFICATION
// //   Future<void> sendEmailVerification() async{
// //     try {
// //       await auth.currentUser?.sendEmailVerification();
// //     } on FirebaseAuthException catch (e) {
// //       final ex = TExceptions.fromCode(e.code);
// //       throw ex.message;
// //     } catch (_){
// //       const ex = TExceptions();
// //       throw ex.message;
// //     }
// //   }
// //
// // /* -------------------------------------------- Federated identity & social sign-in ------------------------------------------------------- */
// //
// //   /// [GoogleAuthentication] - GOOGLE
// //   Future<UserCredential> signInWithGoogle() async {
// //     try {
// //       // Trigger the authentication flow
// //       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
// //
// //       // Obtain the auth details from the request
// //       final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
// //
// //       // Create a new credential
// //       final credential = GoogleAuthProvider.credential(
// //         accessToken: googleAuth?.accessToken,
// //         idToken: googleAuth?.idToken,
// //       );
// //       // Once signed in, return the UserCredential
// //       return await FirebaseAuth.instance.signInWithCredential(credential);
// //
// //     } on FirebaseAuthException catch (e) {
// //       final ex = TExceptions.fromCode(e.code);
// //       throw ex.message;
// //     } catch (_){
// //       const ex = TExceptions();
// //       throw ex.message;
// //     }
// //   }
// //
// //  /// [FacebookAuthentication] - FACEBOOK
// //  //  Future<UserCredential> signInWithFacebook() async {
// //  //    try {
// //  //    //  Trigger the sign-in flow
// //  //      final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['email']);
// //  //
// //  //    }
// //  //  }
// //
// //   /// [PhoneAuthentication] - LOGIN
// //      loginWithPhoneNo(String phoneNumber) async { }
// //
// //   /// [PhoneAuthentication] - REGISTER
//   Future <void> phoneAuthentication(String phoneNo) async {
//     await _auth.verifyPhoneNumber(
//         phoneNumber: phoneNo,
//         verificationCompleted: (credential) async {
//          await _auth.signInWithCredential(credential);
//         },
//         codeSent: (verificationId, resendToken) {
//           this.verificationId.value = verificationId;
//         },
//         codeAutoRetrievalTimeout: (verificationId) {
//           this.verificationId.value = verificationId;
//         },
//         verificationFailed: (e) {
//           if (e.code == 'invalid-phone-number') {
//             Get.snackbar('Error', 'The provided phone number is not valid');
//           } else {
//             Get.snackbar('Error', 'Something went wrong. Try again');
//           }
//         },
//     );
//   }
// //
// //   // / [PhoneAuthentication] - VERIFY PHONE NO BY OTP
//   Future<bool> verifyOTP(String otp) async {
//     var credentials = await _auth
//         .signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId.value, smsCode: otp));
//     return credentials.user != null ? true : false;
//   }
// //
// //   /*--------------------------------------- ./end Federated identity & social sign-in -----------------------------------------------------------*/
// //   /// [LogoutUser] - valid for any authentication.
// //   Future<void> logout() async {
// //     try {
// //       await GoogleSignIn().signOut();
// //       await FacebookAuth.instance.logOut();
// //       await FirebaseAuth.instance.signOut();
// //       Get.offAll(() => const Splash());
// //     } on FirebaseAuthException catch (e) {
// //       throw e.message!;
// //     } on FormatException catch (e) {
// //       throw e.message;
// //     } catch (e) {
// //       throw 'Unable to logout. try again. ';
// //     }
// //   }
//
// }