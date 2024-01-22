import 'package:btcmining/signupLogin/screen/login_screen.dart';
import 'package:flutter/material.dart';

import '../Login_Pages/auth/login.dart';
import 'navBar.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();

}

class _SplashState extends State<Splash>{
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            height: myHeight,
            width: myWidth,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/image/1.gif'),
               const SizedBox(height: 20,),
               const Center(
                 child: Padding(
                   padding: EdgeInsets.all(8.0),
                   child: Column(
                     children: [
                       Text('The Future', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
                       Text('Learn more about cryptocurrency', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.grey),
                       ),
                       // Text('the future in IO Crypto', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.grey),
                       // ),
                     ],
                   ),
                 ),
               ),
                const SizedBox(height: 80,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: myWidth * 0.14),
                  child: GestureDetector(
                    onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(color: Color(0xffFBC700), borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: myWidth * 0.05, vertical: myHeight * 0.01),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text('CREATE ACCOUNT',style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                          RotationTransition(
                            turns: AlwaysStoppedAnimation(310 / 360),
                              child: Icon(Icons.arrow_forward_rounded)
                          )
                        ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

}