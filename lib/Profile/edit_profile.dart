// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import '../services/global_method.dart';
//
// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({Key? key,}) : super(key: key);
//
//
//   @override
//   State<EditProfileScreen> createState() => _EditProfileStateScreen();
// }
//
// class _EditProfileStateScreen extends State<EditProfileScreen>{
//   // String name = '';
//   // String email = '';
//   // String? imageUrl;
//   // String phone = '';
//   // String password = '';
//   //
//   // @override
//   // void initState() {
//   //   getProductData();
//   //   super.initState();
//   // }
//   //
//   // Future<void> getProductData() async {
//   //   try {
//   //     final DocumentSnapshot productsDoc = await FirebaseFirestore.instance.collection('products').doc(widget.id).get();
//   //     if (productsDoc == null) {
//   //       return;
//   //     } else {
//   //       setState(() {
//   //         name = productsDoc.get('name');
//   //         email = productsDoc.get('email');
//   //         imageUrl = productsDoc.get('imageUrl');
//   //         phone = productsDoc.get('phone');
//   //         password = productsDoc.get('password');
//   //
//   //       });
//   //     }
//   //   } catch (error) {
//   //     GlobalMethods.errorDialog(subtitle: '$error', context: context);
//   //   } finally {}
//   // }
//
//   final productsDoc =  FirebaseFirestore.instance.collection('users').doc(widget.id).get();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        body: SafeArea(
//          child: Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 15),
//            child: StreamBuilder(
//              stream: FirebaseFirestore.instance.collection('users').snapshots(),
//              builder: (context, snapshot) {
//                if(!snapshot.hasData){
//                  return Center(child: CircularProgressIndicator(),);
//                } else if (snapshot.hasData){
//                  return  Column(
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    children: [
//                      const SizedBox(height: 20,),
//                      Container(
//                        height: 130,
//                        width: 130,
//                        decoration: BoxDecoration(
//                            shape: BoxShape.circle,
//                            border: Border.all(color: Colors.orangeAccent, width: 4)
//                        ),
//                        child: ClipRRect(
//                          borderRadius: BorderRadius.circular(100),
//                          child: Image(
//                            fit: BoxFit.cover,
//                            image: const AssetImage("assets/image/profile.png"),
//                            loadingBuilder: (context, child, loadingProgress){
//                              if(loadingProgress == null) return child;
//                              return const Center(child: CircularProgressIndicator(),);
//                            },
//                            errorBuilder: (context, object, stack){
//                              return Container(
//                                child: Icon(Icons.error_outline, color: Colors.red,),
//                              );
//                            },
//                          ),
//
//                        ),
//                      )
//                    ],
//                  );
//                } else{
//                  return Center(child: Text('Something went wrong', style: Theme.of(context).textTheme.subtitle1,),);
//                }
//              },
//            ),
//          ),
//        ),
//      );
//   }
//
// }