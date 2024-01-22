import 'dart:async';

import 'package:btcmining/View/Widget/fetch_screen.dart';
import 'package:btcmining/View/navBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../View/splash.dart';

class SplashService{
  void isLogin(BuildContext context){

    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user != null){
      Timer(const Duration(seconds: 3),
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FetchScreen())));
    }else{
      Timer(const Duration(seconds: 3),
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Splash())));
    }
  }
}