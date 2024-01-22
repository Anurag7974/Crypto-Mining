
import 'dart:io';
import 'dart:typed_data';

import 'package:btcmining/Login_Pages/auth/firebase_consts.dart';
import 'package:btcmining/Profile/profile_data.dart';
import 'package:btcmining/Profile/utilsImage.dart';
import 'package:btcmining/View/Widget/loading_manager.dart';
import 'package:btcmining/constants/sizes.dart';
import 'package:btcmining/constants/text_strings.dart';
import 'package:btcmining/signupLogin/controllers/profile_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Model/user_model.dart';
import '../View/Components/text_widget.dart';
import '../View/backWidget.dart';
import '../constants/colors.dart';
import '../services/global_method.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  //Controllers
  final TextEditingController _email = TextEditingController(text:'');
  final TextEditingController _name = TextEditingController(text: '');
  final TextEditingController _phone = TextEditingController(text:'');

  //Select Images
  Uint8List? _image;
  void selectImage() async{
     Uint8List img = await pickImage(ImageSource.gallery);
     setState(() {
       _image = img;
     });
  }
  //
  // void saveProfile() async{
  //   String resp = await StoreData().saveData(file: _image!);
  // }

  @override
  void dispose(){
    _email.dispose();
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  String? email;
  String? phone;
  String? name;
  String? profile;
  bool _isLoading = false;
  final User? user = authInstance.currentUser;
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
        email = userDoc.get('email');
        _email.text = userDoc.get('email');
        name = userDoc.get('name');
        _name.text = userDoc.get('name');
        phone = userDoc.get('phone');
        _phone.text = userDoc.get('phone');
        profile = userDoc.get('profile').toString();

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
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

    Future<String> saveData({
      required Uint8List file,
    }) async {
      String resp = "Some Error Occurred";
      String _uid = user!.uid;
      try{
        String imageUrl = await uploadImageToStorage('profileImage', file);
        await _firestore.collection('users').doc(_uid).update({
          'profile' : imageUrl
        });
        resp = 'success';
      }
      catch(err){
        resp = err.toString();
      }
      return resp;
    }

  @override
  Widget build(BuildContext context) {
    bool isRefreshing = true;
    // final controller = Get.put(ProfileController());
    return Scaffold(
      //********************** App Bar Code ***********************************************
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 2,
        backgroundColor: const Color(0xFFFFE400),
        centerTitle: true,
        title: Text(tProfile, style: Theme.of(context).textTheme.headline5,),
        // title: TextWidget(text: tEditProfile, color: Colors.black87, textSize: 25.0, isTitle: true, ),
      ),
      //********************** End Code ***********************************************
      body: LoadingManager(
            isLoading: _isLoading,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(tDefaultSize),
                child: Column(
            //               /// Step 4 - Wrap this Widget with FutureBuilder
                          children: [
            //                 // -- IMAGE with ICON
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.yellow, width: 5)),
                              child: _isLoading ?
                              const Center(child: CircularProgressIndicator(color: Color(0xffFBC700),),
                              ) :
                              Stack(
                                children: [
                                  _image != null ? CircleAvatar(radius: 64, backgroundImage: MemoryImage(_image!),):
                                  SizedBox(
                                    width: 120, height: 120,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: FancyShimmerImage(
                                          imageUrl: profile!,
                                          boxFit: BoxFit.fill,
                                        )
                                        // Image.network(profile!
                                        //   ,loadingBuilder: (context, child, loadingProgress){
                                        //   if(loadingProgress == null) return child;
                                        //   return Center(child: CircularProgressIndicator());
                                        // }
                                        // ,fit: BoxFit.fill,),
                                    )
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: InkWell(
                                      onTap: (){
                                        selectImage();
                                      },
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: tPrimaryColor),
                                        child: const Icon(LineAwesomeIcons.camera, color: Colors.black, size: 20,),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 50,),
                            // -- Form Fields
                            Form(
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller:_name,
                                    decoration: InputDecoration(
                                      label: const Text(tFullName),
                                      floatingLabelStyle: const TextStyle(
                                          color: tSecondaryColor),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                                      prefixIcon: const Icon(LineAwesomeIcons.user),
                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100),
                                          borderSide: const BorderSide(width: 2, color: tPrimaryColor)),

                                    ),
                                  ),

                                ],
                              ),
                            ),
                            const SizedBox(height: tFormHeight - 20,),
                            TextFormField(
                              controller: _email,
                              decoration: InputDecoration(
                                  label: const Text(tEmail),
                                  floatingLabelStyle: const TextStyle(color: tSecondaryColor),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                                  prefixIcon: const Icon(LineAwesomeIcons.envelope_1),
                                  focusedBorder:  OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(width: 2, color: tPrimaryColor))
                                    ),
                                  ),
                                  const SizedBox(height: tFormHeight - 20,),
                                  TextFormField(
                                    controller: _phone,
                                    decoration: InputDecoration(
                                      label: const Text(tPhoneNo),
                                      floatingLabelStyle: const TextStyle(color: tSecondaryColor),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                                      prefixIcon: const Icon(LineAwesomeIcons.phone),
                                      focusedBorder:  OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(width: 2, color: tPrimaryColor)),
                                    ),
                                  ),
                                  const SizedBox(height: tFormHeight),
                                  SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () async{
                                          // Future<String> saveData({
                                          //   required Uint8List file
                                          // }) async {
                                            String _uid = user!.uid;
                                            try {
                                              String imageUrl = await uploadImageToStorage('profileImage', _image!);
                                              await FirebaseFirestore.instance.collection('users').doc(_uid).update({
                                                'name' : _name.text,
                                                'email' : _email.text,
                                                'phone' : _phone.text,
                                                'profile' : imageUrl
                                                // 'profile' : imageUrl
                                              });
                                              Navigator.pop(context);
                                              setState(() {
                                                name = _name.text;
                                                email = _email.text;
                                                phone = _phone.text;
                                                profile = profile;
                                              });
                                            } catch (err) {
                                              GlobalMethods.errorDialog(subtitle: err.toString(), context: context);
                                            }
                                          // }
                                          saveData(file: _image!);
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateProfileScreen()));
                                        },

                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: tPrimaryColor,
                                            side: BorderSide.none,
                                            shape: const StadiumBorder()),
                                        child: const Text('Save', style: TextStyle(color: tDarkColor)),
                                      )),
                                  const SizedBox(height: tFormHeight),
                  ]
                )
              ),
            ),
          )

    );
  }
}