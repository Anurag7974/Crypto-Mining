import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../View/Components/text_widget.dart';
import '../../View/Widget/loading_manager.dart';
import '../../services/global_method.dart';
import '../../services/utils.dart';
import '../auth_button.dart';
import '../consts/contss.dart';
import 'firebase_consts.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = '/ForgetPasswordScreen';
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailTextController = TextEditingController();
  @override
  void dispose(){
    _emailTextController.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  void _forgetPassFCT() async {
    if(_emailTextController.text.isEmpty || !_emailTextController.text.contains("@")) {
      GlobalMethods.errorDialog(subtitle: 'Please enter a correct email address', context: context);
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.sendPasswordResetEmail(email: _emailTextController.text.toLowerCase());
        Fluttertoast.showToast(
            msg: "An email has been sent to your email address",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade600,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(subtitle: '${error.message}', context: context);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
        setState(() {
          _isLoading = false;
        });
      }
      finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(
          children: [
            Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(Constss.authImagesPaths[index],fit: BoxFit.cover,);
              },
              autoplay: true,
              itemCount: Constss.authImagesPaths.length,
            ),
            Container(color: Colors.black.withOpacity(0.6),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.1,),
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => Navigator.canPop(context) ? Navigator.pop(context) : null,
                    child: const Icon(
                      IconlyLight.arrowLeft2, color: Colors.white, size: 24,
                    ),
                  ),
                  // const BackButton( color: Colors.white),
                  const SizedBox(height: 20,),
                  TextWidget(text: 'Forget password', color: Colors.white, textSize: 30,
                  ),
                  const SizedBox(height: 30,),
                  TextField(
                    controller: _emailTextController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Email address",
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  AuthButton(
                    buttonText: 'Reset now',
                    fct: () {
                      _forgetPassFCT();
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}

