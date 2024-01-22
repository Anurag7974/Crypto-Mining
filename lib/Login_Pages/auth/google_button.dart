import 'package:btcmining/View/Widget/fetch_screen.dart';
import 'package:btcmining/View/navBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../View/Components/text_widget.dart';
import '../../services/global_method.dart';
import 'firebase_consts.dart';

class GoogleButton extends StatelessWidget {
   const GoogleButton({Key? key}) : super(key: key);

  Future<void> _googleSignIn(context) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if(googleAccount != null){
      final googleAuth = await googleAccount.authentication;
      if(googleAuth.accessToken != null && googleAuth.idToken != null){
        try{
            final authResult = await authInstance.signInWithCredential(GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken));
            if (authResult.additionalUserInfo!.isNewUser) {
              await FirebaseFirestore.instance.collection('users').doc(authResult.user!.uid,).set({
                'id': authResult.user!.uid,
                'name': authResult.user!.displayName,
                'email': authResult.user!.email,
                'phone': '',
                'password': '',
                'refCode': authInstance.currentUser!.uid,
                'referrals': <String>[],
                'refEarning': 0,
                'profile': "https://cdn-icons-png.flaticon.com/512/2815/2815428.png",
                'income': "0.00",
                'withdrawal':"0.00",
                'totBal': "0.00",
                // 'userWish': [],
                // 'userCart': [],
                'createdAt': Timestamp.now(),
              });
            }
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const FetchScreen()));
        }on FirebaseException catch (error) {
          GlobalMethods.errorDialog(subtitle: '${error.message}', context: context);
        } catch (error) {
          GlobalMethods.errorDialog(subtitle: '$error', context: context);
        } finally {}
      }
    }
  }

  // Future<UserCredential> _googleSignIn() async {
  //   final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
  //
  //   final GoogleSignInAuthentication gAuth = await gUser!.authentication;
  //
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: gAuth.accessToken, idToken: gAuth.idToken,
  //   );
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  @override
  Widget build(BuildContext context) {
    return Material (
      color: Colors.blue,
      child: InkWell(
        onTap: () {
          _googleSignIn(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                color: Colors.white,
                child: Image.asset('assets/icons/google.png', width: 40,)),
            const SizedBox(width: 8,),
            TextWidget(text: 'Sign in with google', color: Colors.white, textSize: 18,)
          ],
        ),
      ),
    );
  }

}