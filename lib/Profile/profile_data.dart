// import 'dart:typed_data';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
//
// import '../Login_Pages/auth/firebase_consts.dart';
//
// final FirebaseStorage _storage = FirebaseStorage.instance;
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
// class StoreData{
//   Future<String> uploadImageToStorage(String childName, Uint8List file) async {
//     Reference ref = _storage.ref().child(childName);
//     UploadTask uploadTask = ref.putData(file);
//     TaskSnapshot snapshot = await uploadTask;
//     String downloadUrl = await snapshot.ref.getDownloadURL();
//     return downloadUrl;
//   }
//   final User? user = authInstance.currentUser;
//   Future<String> saveData({
//     required Uint8List file,
// }) async {
//     String resp = "Some Error Occurred";
//     String _uid = user!.uid;
//     try{
//       String imageUrl = await uploadImageToStorage('profileImage/', file);
//       await _firestore.collection('users').doc(_uid).update({
//           'profile' : imageUrl
//       });
//       resp = 'success';
//     }
//         catch(err){
//       resp = err.toString();
//     }
//     return resp;
//   }
// }