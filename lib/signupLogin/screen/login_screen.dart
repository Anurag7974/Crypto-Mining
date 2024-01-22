// import 'package:btcmining/constants/sizes.dart';
// import 'package:btcmining/signupLogin/screen/signup_screen.dart';
// import 'package:flutter/material.dart';
//
// import '../../constants/text_strings.dart';
// import 'login_from_widget.dart';
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({Key? key}) : super(key: key);
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
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /* -- Section-1 --*/
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Image(image: const AssetImage("assets/image/bitcoin.png"), height: size.height * 0.2,),
//                     Text(tLoginTitle, style: Theme.of(context).textTheme.headline3,  ),
//                     Text(tLoginSubTile, style: Theme.of(context).textTheme.bodyText1,),
//                   ],
//                 ),
//                 /* -- /.end --*/
//
//                 /* -- Section-2 [Form] -- */
//                 const LoginForm(),
//                 /* -- /.end --*/
//
//                 /* -- Section-3 [Form] -- */
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Text("OR"),
//                     const SizedBox(height: tFormHeight -20,),
//                     SizedBox(
//                         width: double.infinity,
//                         child : OutlinedButton.icon(
//                             icon: const Image(image: AssetImage("assets/icons/google.png"), width: 20.0,),
//                             onPressed: () {}, label: const Text(tSignInWithGoole))
//                     ),
//
//                     const SizedBox(
//                       height: tFormHeight - 20,
//                     ),
//                     TextButton(onPressed: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
//                     },
//                         child: Text.rich(
//                             TextSpan(
//                                 text: tDontHaveAnAccount,style: Theme.of(context).textTheme.bodyText1,
//                                 children: const [TextSpan(text: " "+tSignup, style: TextStyle(color: Colors.blue) )])))
//                   ],
//                 )
//                 /* -- /.end --*/
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// }