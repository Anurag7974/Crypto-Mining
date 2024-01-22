import 'package:btcmining/View/Widget/loading_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../Login_Pages/auth/firebase_consts.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';
import '../../services/global_method.dart';
import '../Components/text_widget.dart';
import '../backWidget.dart';

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  String? _totBal;
  bool _isLoading = false;
  final User? user = authInstance.currentUser;
  final _formKey = GlobalKey<FormState>();
  final _accountNameController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _accountController = TextEditingController();
  final _cityController = TextEditingController();
  final _branchController = TextEditingController();
  final _ifscController = TextEditingController();
  final _amountController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose(){
    _accountNameController.dispose();
    _bankNameController.dispose();
    _accountController.dispose();
    _cityController.dispose();
    _branchController.dispose();
    _ifscController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitFromOnRegister() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(isValid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      final withdrawalId = const Uuid().v4();
      User? user = authInstance.currentUser;
      try {
        await FirebaseFirestore.instance.collection('Withdrawal').doc(withdrawalId).set({
          'withdrawalId': withdrawalId,
          'userId': user!.uid,
          'userName': user.displayName,
          'accountName': _accountNameController.text,
          'bank': _bankNameController.text,
          'account': _accountController.text,
          'city': _cityController.text,
          'branch': _branchController.text,
          'ifsc': _ifscController.text,
          'amount': _amountController.text,
          'withdrawalDate': Timestamp.now(),
        });
        await Fluttertoast.showToast(
          msg: "Money will be credited to your bank account within 24 hours.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        //     //********************** End code! ********************************************************
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
  void initState(){
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });
    if(user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      String _uid = user!.uid;
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      if(userDoc == null) {
        return;
      } else {
        _totBal = userDoc.get('totBal');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethods.errorDialog(subtitle: '$error', context: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         leading: const BackWidget(),
         elevation: 2,
         backgroundColor: const Color(0xFFFFE400),
         centerTitle: true,
         title: Text('Withdrawal', style: Theme.of(context).textTheme.headline5,),
         // title: TextWidget(text: tEditProfile, color: Colors.black87, textSize: 25.0, isTitle: true, ),
       ),
       body: LoadingManager(
         isLoading: _isLoading,
         child: SingleChildScrollView(
           child: Column(
             children: [
               const SizedBox(height: 10,),
               SizedBox(
                 width: 300,
                 height: 150,
                 child: Container(
                   height: 80,
                   padding: const EdgeInsets.all(defaultSpacing),
                   decoration:  const BoxDecoration(
                       boxShadow: [BoxShadow(color: Colors.black12, offset: Offset.zero, spreadRadius: 3, blurRadius: 12)],
                       color: primaryDark ,
                       borderRadius: BorderRadius.all(Radius.circular(defaultRadius))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Total balance",style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.black, fontWeight: FontWeight.w800),),
                      const SizedBox(height: defaultSpacing / 2,),
                      Text("₹ ${ _totBal == null ? 'name' : _totBal!}",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black, fontSize: fontSizeHeading, ),),

                    ],
                  ),
                 ),
               ),
               const SizedBox(height: 20,),
               Column(
                 children: [
                   Text("Notes: Withdrawal amount more than Rs 500",style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.red, ),),
                 ],
               ),
               Form(
                 key: _formKey,
                 child: Padding(
                   padding: const EdgeInsets.all(tDefaultSize),
                   child: Column(
                     children: [
                       TextFormField(
                         controller:_accountNameController,
                         decoration: InputDecoration(
                           label: const Text("Account Holder Name"),
                           floatingLabelStyle: const TextStyle(color: tSecondaryColor),
                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                           prefixIcon: const Icon(LineAwesomeIcons.user),
                           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100),
                               borderSide: const BorderSide(width: 2, color: tPrimaryColor)),

                         ),
                       ),
                       const SizedBox(height: tFormHeight - 15,),
                       TextFormField(
                         controller:_bankNameController,
                         decoration: InputDecoration(
                           label: const Text("Bank Name"),
                           floatingLabelStyle: const TextStyle(color: tSecondaryColor),
                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                           prefixIcon: const Icon(LineAwesomeIcons.university),
                           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100),
                               borderSide: const BorderSide(width: 2, color: tPrimaryColor)),
                         ),
                       ),
                       const SizedBox(height: tFormHeight - 15,),
                       TextFormField(
                         controller:_accountController,
                         decoration: InputDecoration(
                           label: const Text("Account Number"),
                           floatingLabelStyle: const TextStyle(color: tSecondaryColor),
                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                           prefixIcon: const Icon(LineAwesomeIcons.keyboard),
                           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100),
                               borderSide: const BorderSide(width: 2, color: tPrimaryColor)),
                         ),
                       ),
                       const SizedBox(height: tFormHeight - 15,),
                       TextFormField(
                         controller:_cityController,
                         decoration: InputDecoration(
                           label: const Text("City"),
                           floatingLabelStyle: const TextStyle(color: tSecondaryColor),
                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                           prefixIcon: const Icon(LineAwesomeIcons.city),
                           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100),
                               borderSide: const BorderSide(width: 2, color: tPrimaryColor)),
                         ),
                       ),
                       const SizedBox(height: tFormHeight - 15,),
                       TextFormField(
                         controller:_branchController,
                         decoration: InputDecoration(
                           label: const Text("Branch"),
                           floatingLabelStyle: const TextStyle(color: tSecondaryColor),
                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                           prefixIcon: const Icon(LineAwesomeIcons.code_branch),
                           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100),
                               borderSide: const BorderSide(width: 2, color: tPrimaryColor)),
                         ),
                       ),
                       const SizedBox(height: tFormHeight - 15,),
                       TextFormField(
                         controller:_ifscController,
                         decoration: InputDecoration(
                           label: const Text("IFSC"),
                           floatingLabelStyle: const TextStyle(color: tSecondaryColor),
                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                           prefixIcon: const Icon(LineAwesomeIcons.code),
                           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100),
                               borderSide: const BorderSide(width: 2, color: tPrimaryColor)),
                         ),
                       ),
                       const SizedBox(height: tFormHeight - 15,),
                       TextFormField(
                         controller:_amountController,
                         decoration: InputDecoration(
                           label: const Text("Amount"),
                           floatingLabelStyle: const TextStyle(color: tSecondaryColor),
                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                           prefixIcon: const Icon(LineAwesomeIcons.dollar_sign),
                           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100),
                               borderSide: const BorderSide(width: 2, color: tPrimaryColor)),
                         ),
                       ),
                      //  const SizedBox(height: tFormHeight - 10,),
                      // Container(
                      //   width: 200,
                      //   height: 50,
                      //   child: Flexible(
                      //     child: Material(
                      //       color: Colors.red,
                      //       borderRadius: BorderRadius.circular(20),
                      //       child: InkWell(
                      //         onTap: (){
                      //           _submitFromOnRegister();
                      //         },
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             TextWidget(text: ' Submit  ', color: Colors.white, textSize: 18,),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // )
                       ElevatedButton(onPressed: (){
                         _submitFromOnRegister();
                       }, child: TextWidget(text: ' Submit  ', color: Colors.white, textSize: 18,),)
                     ],
                   ),
                 ),
               ),
             ],
           )
         ),
       ),
     );
  }

}
