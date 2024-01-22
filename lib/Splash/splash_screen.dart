import 'package:btcmining/Splash/splash_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen>{

  SplashService splashScreen = SplashService();

  @override
  void initState() {
    super.initState();
    splashScreen.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
     return const Scaffold(
       backgroundColor: Colors.white,
       body: SizedBox(
         width: double.infinity,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Image(image: AssetImage("assets/offers/logSplash.png"), width: 200,),
             Text('BTC Mining', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
             SizedBox(height: 25,),
             SpinKitSquareCircle(
               color: Colors.orange,
               size: 50,

             )
           ],
         ),
       )
     );
  }

}