import 'package:btcmining/Login_Pages/auth/ref_page.dart';
import 'package:btcmining/View/navBar.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../View/Components/text_widget.dart';
import '../../View/Widget/fetch_screen.dart';
import '../../View/Widget/loading_manager.dart';
import '../../constants/colors.dart';
import '../../services/global_method.dart';
import '../../services/utils.dart';
import '../auth_button.dart';
import '../consts/contss.dart';
import 'firebase_consts.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/RegisterScreen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _phoneTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  bool _obscureText = true;
  @override
  void dispose(){
    _fullNameController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();
    _phoneTextController.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  void _submitFromOnRegister() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(isValid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.createUserWithEmailAndPassword(
            email: _emailTextController.text.toLowerCase().trim(),
            password: _passTextController.text.trim());
        print("Successfully registered");
    //     //********************** Firebase Data transfer code **************************************
        final User? user = authInstance.currentUser;
        final _uid = user!.uid;
        user.updateDisplayName(_fullNameController.text);
        user.reload();
        await FirebaseFirestore.instance.collection('users').doc(_uid).set({
          'id': _uid,
          'name': _fullNameController.text,
          'email': _emailTextController.text.toLowerCase(),
          'phone': _phoneTextController.text,
          'password': _passTextController.text,
          'refCode': authInstance.currentUser!.uid,
          'referrals': <String>[],
          'refEarning': 0,
          'profile': "https://cdn-icons-png.flaticon.com/512/2815/2815428.png",
          'income': "0.00",
          'withdrawal':"0.00",
          'totBal': "0.00",
          // 'userCart': [],
          'createdAt': Timestamp.now(),
        });
    //     //********************** End code! ********************************************************
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  RefCodePage()));
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
    final theme = Utils(context).getTheme;
    Color color = Utils(context).color;
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(
          children: <Widget>[
            Swiper(
              duration: 800,
              autoplayDelay: 6000,

              itemBuilder: (BuildContext context, int index) {
                return Image.asset(Constss.authImagesPaths[index],fit: BoxFit.cover);
              },
              autoplay: true,
              itemCount: Constss.authImagesPaths.length,
            ),
            Container(color: Colors.black.withOpacity(0.5),),
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const SizedBox( height: 60.0,),
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => Navigator.canPop(context) ? Navigator.pop(context) : null,
                    child: Icon(
                      IconlyLight.arrowLeft2,
                      color: theme == true ? Colors.white : Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 40.0,),
                  TextWidget(text: 'Welcome', color: Colors.white, textSize: 30, isTitle: true,),
                  const SizedBox(height: 8,),
                  TextWidget(text: 'Sign up to continue', color: Colors.white, textSize: 18, isTitle: false),
                  const SizedBox(height: 30.0,),
                  // Stack(
                  //   children: [
                  //     SizedBox(
                  //       width: 120, height: 120,
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Column(
                  //           children: [
                  //             ClipRRect(
                  //                 borderRadius: BorderRadius.circular(100),
                  //                 child: const Image(image: AssetImage("assets/image/profile.png"))),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     Positioned(
                  //       bottom: 0,
                  //       right: 0,
                  //       child: Container(
                  //         width: 35,
                  //         height: 35,
                  //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: tPrimaryColor),
                  //         child: const Icon(LineAwesomeIcons.camera, color: Colors.black, size: 20,),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 30,),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          //******************************** Full name Text Filed Code **************************************************
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context).requestFocus(_emailFocusNode),
                            keyboardType: TextInputType.name,
                            controller: _fullNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "The Field is missing";
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                hintText: 'Full name',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                )
                            ),
                          ),
                          //******************************** End! Code **************************************************
                          const SizedBox(height: 15,),
                          //******************************** Email Text Filed Code **************************************************
                          TextFormField(
                            focusNode: _emailFocusNode,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context).requestFocus(_passFocusNode),
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailTextController,
                            validator: (value){
                              if(value!.isEmpty || !value.contains("@")) {
                                return "Please enter a valid Email address";
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                )
                            ),
                          ),
                          //******************************** End! Code **************************************************
                          const SizedBox(height: 20,),
                          //******************************** Shipping Text Filed Code **************************************************
                          TextFormField(
                            focusNode: _addressFocusNode,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.phone,
                            onEditingComplete: () => FocusScope.of(context).requestFocus(_addressFocusNode),
                            controller: _phoneTextController,
                            validator: (value) {
                              if(value!.isEmpty || value.length < 9) {
                                return "Please enter a valid address";
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            // maxLines: 2,
                            textAlign: TextAlign.start,
                            decoration: const InputDecoration(
                                hintText: 'Phone',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                )
                            ),
                          ),
                          //******************************** End! Code **************************************************
                          const SizedBox(height: 20,),
                          //******************************** Password Text Filed Code **************************************************
                          TextFormField(
                            focusNode: _passFocusNode,
                            obscureText: _obscureText,
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passTextController,
                            validator: (value){
                              if(value!.isEmpty || value.length < 7) {
                                return "Please enter a valid password";
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            onEditingComplete:_submitFromOnRegister,
                            decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(
                                    _obscureText ? Icons.visibility : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                ),
                                hintText: 'Password',
                                hintStyle: const TextStyle(color: Colors.white),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                )
                            ),
                          ),
                          //******************************** End! Code **************************************************
                          const SizedBox(height: 20,),
                         ],
                      )
                  ),
                  const SizedBox(height: 5.0,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // GlobalMethods.navigateTo(ctx: context, routeName: ForgetPasswordScreen.routeName);
                      },
                      child: const Text('Forget password',
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                            fontStyle: FontStyle.italic
                        ),),
                    ),
                  ),
                  // _isLoading ? const CircularProgressIndicator() :
                  AuthButton(
                    buttonText: 'Sign up',
                    fct: () {
                      _submitFromOnRegister();
                    },
                  ),
                  const SizedBox(height: 10,),
                  RichText(
                      text: TextSpan(
                          text: 'Already a user?',
                          style: const TextStyle(color: Colors.white, fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Sign in',
                                style: const TextStyle(
                                    color: Colors.lightBlue, fontSize: 18),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  GlobalMethods.navigateTo(ctx: context, routeName: LoginScreen.routeName);
                                }
                            )
                          ]
                      )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

  }
}
