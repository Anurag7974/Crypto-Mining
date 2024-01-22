import 'package:btcmining/Login_Pages/auth/ref_page.dart';
import 'package:btcmining/Login_Pages/auth/register.dart';
import 'package:btcmining/View/navBar.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../View/Components/text_widget.dart';
import '../../View/Widget/fetch_screen.dart';
import '../../View/Widget/loading_manager.dart';
import '../../services/global_method.dart';
import '../auth_button.dart';
import '../consts/contss.dart';
import 'firebase_consts.dart';
import 'forget_password.dart';
import 'google_button.dart';

class LoginScreen extends StatefulWidget{
  static const routeName = '/LoginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _obscureText = true;
  @override
  void dispose(){
    _emailTextController.dispose();
    _passTextController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }
  bool _isLoading = false;
  void _submitFormOnLogin() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });
    if(isValid) {
      print('the from valid');
    }
      _formKey.currentState!.save();
      try {
        await authInstance.signInWithEmailAndPassword(
            email: _emailTextController.text.toLowerCase().trim(),
            password: _passTextController.text.trim());
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const FetchScreen()));
        print('Successfully logged in');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(children: [
          Swiper(
            duration: 800,
            autoplayDelay: 6000,
            itemBuilder: (BuildContext context,int index){
              return Image.asset(Constss.authImagesPaths[index],fit: BoxFit.fill,);
            },
            autoplay: true,
            itemCount: Constss.authImagesPaths.length,
          ),
          Container(color: Colors.black.withOpacity(0.6),),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 120.0,),
                  TextWidget(text: 'Welcome Back', color: Colors.white, textSize: 30, isTitle: true),
                  const SizedBox(height: 8.0,),
                  TextWidget(text: 'Sign in to continue', color: Colors.white, textSize: 18, isTitle: false),
                  const SizedBox(height: 30.0,),
                  Form(
                      key: _formKey,
                      child: Column(children: [
                        //******************************** Email Text Filed Code **************************************************
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context).requestFocus(_passFocusNode),
                          controller: _emailTextController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if(value!.isEmpty || !value.contains('@')){
                              return 'Please enter a valid email address';
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                            ),
                          ),),
                        //******************************** End! **************************************************
                        const SizedBox(height: 15,),
                        //******************************** Password Text Filed Code **************************************************
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {
                            _submitFormOnLogin();
                          },
                          controller:_passTextController,
                          focusNode: _passFocusNode,
                          obscureText: _obscureText,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if(value!.isEmpty || value.length < 7){
                              return 'Please enter a valid email address';
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText =! _obscureText;
                                  });
                                },
                                child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off, color: Colors.white,)),
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.white),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                            ),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                            ),
                          ),),
                        //******************************** End! **************************************************
                      ],)
                  ),
                  //******************************** Forget Password Filed Code ***************************************
                  const SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        GlobalMethods.navigateTo(ctx: context, routeName: ForgetPasswordScreen.routeName);
                      },
                      child: const Text('Forget password?', maxLines: 1,
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                            fontStyle: FontStyle.italic),),
                    ),
                  ),
                  //******************************** End! **************************************************
                  const SizedBox(height: 10,),
                  AuthButton(
                    fct: _submitFormOnLogin,
                    buttonText: 'Login',),
                  const SizedBox(height: 10,),
                   GoogleButton(),
                  const SizedBox(height: 10,),
                  Row(children: [
                    const Expanded(
                      child: Divider(color: Colors.white, thickness: 2,),
                    ),
                    const SizedBox(width: 5,),
                    TextWidget(text: 'OR', color: Colors.white, textSize: 18,),
                    const SizedBox(width: 5,),
                    const Expanded(
                      child: Divider(color: Colors.white, thickness: 2,),
                    ),
                  ],
                  ),
                  const SizedBox(height: 10,),
                  // AuthButton(fct: () {
                  //   Navigator.of(context).push(
                  //     // MaterialPageRoute(builder: (context) => const BottomBarScreen()),
                  //   );
                  // }, buttonText: 'Continue as a guest',primary: Colors.black,),
                  const SizedBox(height: 10,),
                  RichText(text: TextSpan(text: 'Don\'t have an account?',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      children: [
                        TextSpan(text: 'Sign up',
                            style: const TextStyle(color: Colors.lightBlue, fontSize: 18, fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()..onTap = (){
                              GlobalMethods.navigateTo(ctx: context, routeName: RegisterScreen.routeName);
                            }),
                      ]
                  )),
                ],
              ),
            ),
          )

        ],),
      ),
    );
  }

}