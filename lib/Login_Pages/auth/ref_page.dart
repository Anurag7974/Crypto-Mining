import 'package:btcmining/View/navBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_form_field/flutter_text_form_field.dart';
import 'package:provider/provider.dart';

import '../../View/Components/text_widget.dart';
import '../../View/Widget/fetch_screen.dart';
import '../../enums/state.dart';
import '../../provider/ref_provider.dart';
import '../../utils/message.dart';
import '../auth_button.dart';

class RefCodePage extends StatefulWidget {
  @override
  _RefCodePageState createState() => _RefCodePageState();
}

class _RefCodePageState extends State<RefCodePage> {
  final TextEditingController _refController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Consumer<RefProvider>(builder: (context, model, child) {
          return model.state == ViewState.Busy
              ? const Center(
                child: CircularProgressIndicator(),
          ) :
          SingleChildScrollView(
               child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                   Image.asset("assets/icon/logooo.png"),
                  // const SizedBox(
                  //   height: 80,
                  // ),
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(30.0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                CustomTextField(
                                  _refController,
                                  hint: 'Referal code',
                                  password: false,
                                  border: Border.all(color: Colors.black54),
                                ),
                                // const SizedBox(
                                //   height: 20,
                                // ),
                                // const SizedBox(
                                //   height: 20,
                                // ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () async {
                                // Validate User Inputs
                                if (_refController.text.isEmpty) {
                                  showMessage(
                                      context, "Filed Referral code, otherwise continue instead");
                                } else {
                                  await model.setReferral(
                                      _refController.text.trim());

                                  if (model.state == ViewState.Success) {
                                    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const NavBar()));
                                    Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => const NavBar()), (route) => false);
                                  } else {
                                    showMessage(context, model.message);
                                  }
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15.0),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  "Continue",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Row(children: [
                              const Expanded(
                                child: Divider(color: Colors.black, thickness: 2,),
                              ),
                              const SizedBox(width: 5,),
                              TextWidget(text: 'OR', color: Colors.black, textSize: 18,),
                              const SizedBox(width: 5,),
                              const Expanded(
                                child: Divider(color: Colors.black, thickness: 2,),
                              ),
                            ],
                            ),
                            GestureDetector(
                              onTap: () {
                                //Navigate to Register Page
                                // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const FetchScreen()));
                                Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => FetchScreen()), (route) => false);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15.0),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  "No referral? continue instead",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // child: const Text(
                              //   "No referral? continue instead",
                              //   style: TextStyle(fontSize: 17),
                              // ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}

